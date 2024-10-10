import 'package:collegenius/core/constants.dart';
import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/core/usecases/usecase.dart';
import 'package:collegenius/domain/entities/auth_result.dart';
import 'package:collegenius/domain/repositories/auth_repository.dart';
import 'package:either_dart/either.dart';

/// Use case for logging into multiple services.
///
/// This use case handles the process of authenticating a user across
/// multiple services in parallel. It returns either a list of successful
/// authentication results ([AuthSuccess]) or a list of failures.
class LoginToMultipleServices implements UseCase<Map<WebsiteIdentifier,AuthResult>, LoginParams> {
  final AuthRepository repository;

  /// Constructor for initializing [LoginToMultipleServices] use case.
  ///
  /// Requires an [AuthRepository] instance for performing the login operations.
  LoginToMultipleServices(this.repository);

  /// Overrides the call operator to initiate the login process for multiple services.
  ///
  /// This method takes [LoginParams], which includes the username, password,
  /// and a list of service identifiers. It attempts to log into each service
  /// in parallel, collecting either success results or failures. Returns
  /// either a [Failure] or a list of [AuthSuccess].
  @override
  Future<Either<Failure, Map<WebsiteIdentifier,AuthResult>>> call(LoginParams params) async {
    final websiteIdentifiers = params.idents;
    Map<WebsiteIdentifier,AuthResult> authResults = {};
    for (var ident in websiteIdentifiers) {
      final res = await repository.login(
        username: params.username,
        password: params.password,
        ident: ident,
      );
      res.fold(
        (failure) => authResults[ident] = AuthResult(isSuccess: false, message: failure.message),
        (authSuccess) => authResults[ident] = AuthResult(isSuccess: true, message: ''),
      );
    }
    return Right(authResults);
  }
}

/// Parameters required for logging into multiple services.
///
/// This class contains the [username], [password], and a list of 
/// [websiteIdentifiers] that identify the services the user wants to log into.
class LoginParams {
  final String username;
  final String password;
  final List<WebsiteIdentifier> idents;

  /// Constructor for initializing [LoginParams].
  ///
  /// Requires a [username], [password], and a list of [websiteIdentifiers].
  LoginParams({
    required this.username,
    required this.password,
    required this.idents,
  });
}