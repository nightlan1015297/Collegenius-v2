import 'package:collegenius/core/constants.dart';
import 'package:collegenius/domain/entities/auth_success.dart';
import 'package:collegenius/core/error/failures.dart';
import 'package:either_dart/either.dart';

/// Abstract class representing the authentication repository.
/// 
/// This class defines the contract for authentication-related operations 
/// such as user login, renewing sessions, and logging out. Specific 
/// implementations will provide the actual logic for these operations.
abstract class AuthRepository {
  /// Authenticates the user with the provided [username] and [password].
  /// 
  /// This method attempts to log in a user and returns an [Either] 
  /// containing a [Failure] on error or an [AuthSuccess] on success.
  Future<Either<Failure, AuthSuccess>> login({
    required String username,
    required String password,
    required WebsiteIdentifier ident,
  });

  /// Renews the current user session for the given [websiteIdentifier].
  /// 
  /// This method returns an [Either] containing a [Failure] on error 
  /// or an [AuthSuccess] on successful renewal of the session.
  Future<Either<Failure, AuthSuccess>> renewSession({
    required WebsiteIdentifier ident,
  });

  /// Logs out the current user.
  /// 
  /// This method is responsible for terminating the user's session and
  /// performing any necessary cleanup.
  Future<void> logout();
}
