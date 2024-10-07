/// Base class for representing different types of failures.
/// 
/// This abstract class holds a common failure [message], which can be 
/// used by any specific failure type that extends it.
abstract class Failure {
  final String message;

  /// Constructor for initializing a [Failure] with a specific error [message].
  Failure(this.message);
}

/// Represents a server-related failure, such as a failed API call or
/// server downtime.
/// 
/// This failure type is commonly used when there is an issue communicating 
/// with the server or when the server responds with an error.
class ServerFailure extends Failure {
  /// Constructor for initializing [ServerFailure] with a specific error [message].
  ServerFailure({required String message}) : super(message);
}

/// Represents an authentication-related failure, such as incorrect 
/// username or password.
///
/// This failure type is used when user authentication fails, typically
/// due to invalid credentials or locked accounts.
class AuthenticationFailure extends Failure {
  /// Constructor for initializing [AuthenticationFailure] with a specific error [message].
  AuthenticationFailure({required String message}) : super(message);
}

/// Represents a failure due to unsupported operations or features.
/// 
/// This failure type is used when the operation being attempted is not 
/// supported by the system or service.
class UnsupportFailure extends Failure {
  /// Constructor for initializing [UnsupportFailure] with a specific error [message].
  UnsupportFailure({required String message}) : super(message);
}

/// Represents a failure due to uninitialized credentials.
/// 
/// This failure type is used when required credentials (like tokens or
/// user data) are missing or have not been initialized properly.
class CredentialUninitFailure extends Failure {
  /// Constructor for initializing [CredentialUninitFailure] with a specific error [message].
  CredentialUninitFailure({required String message}) : super(message);
}

/// Represents a failure due to session expiration.
/// 
/// This failure type is used when a user's session has expired, requiring
/// them to reauthenticate.
class SessionExpiredFailure extends Failure {
  /// Constructor for initializing [SessionExpiredFailure] with a specific error [message].
  SessionExpiredFailure({required String message}) : super(message);
}
