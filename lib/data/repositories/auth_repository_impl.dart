import 'package:collegenius/data/data_sources/auth_providers/auth_provider_factory.dart';
import 'package:collegenius/domain/repositories/auth_repository.dart';
import 'package:collegenius/domain/entities/auth_success.dart';
import 'package:collegenius/core/error/exceptions.dart';
import 'package:collegenius/core/error/failures.dart';
import 'package:either_dart/either.dart';

/// Implementation of the [AuthRepository] interface.
/// 
/// This class is responsible for handling authentication-related 
/// operations such as login, logout, and session renewal. It uses 
/// the [AuthProviderFactory] to obtain the appropriate authentication 
/// provider based on the provided website identifier.
class AuthRepositoryImpl implements AuthRepository {
  final AuthProviderFactory authProviderFactory; // Factory to create auth providers
  String? _username; // Cached username for session renewal
  String? _password; // Cached password for session renewal

  /// Constructs an [AuthRepositoryImpl] instance.
  ///
  /// The [authProviderFactory] is required to obtain the correct
  /// authentication provider for different websites.
  AuthRepositoryImpl({required this.authProviderFactory});

  /// Logs the user in with the given [username], [password], and [websiteIdentifier].
  ///
  /// This method attempts to authenticate the user by calling the appropriate 
  /// auth provider's authenticate method. If successful, it returns an 
  /// [AuthSuccess] model; otherwise, it returns a [Failure] with details 
  /// of the error encountered.
  @override
  Future<Either<Failure, AuthSuccess>> login({
    required String username,
    required String password,
    required String websiteIdentifier,
  }) async {
    try {
      final authProvider = authProviderFactory.getAuthProvider(websiteIdentifier);
      final authSuccessModel = await authProvider.authenticate(username, password);
      final authSuccess = authSuccessModel.toEntity(); // Convert DTO to entity
      return Right(authSuccess); // Return success result
    } on ServerException catch (e) {
      return Left(ServerFailure(message: 'error on ${e.ident} \n ${e.message}')); // Handle server errors
    } on UnsupportedError catch (e) {
      return Left(UnsupportFailure(message: e.message ?? 'Unsupported error')); // Handle unsupported errors
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message)); // Handle authentication errors
    }
  }

  /// Logs out the current user.
  ///
  /// This method currently does nothing but is included for completeness.
  @override
  Future<void> logout() {
    return Future.value(); // No operation for logout
  }

  /// Renews the user's session based on previously cached credentials.
  ///
  /// If the username or password is not initialized, it returns a failure indicating 
  /// that credentials are missing. Otherwise, it calls the login method with the cached 
  /// username and password to renew the session.
  @override
  Future<Either<Failure, AuthSuccess>> renewSession({required String websiteIdentifier}) {
    if (_username == null || _password == null) {
      return Future.value(Left(CredentialUninitFailure(message: 'Credential not initialized')));
    }
    return login(username: _username!, password: _password!, websiteIdentifier: websiteIdentifier); // Attempt to renew session
  }
}
