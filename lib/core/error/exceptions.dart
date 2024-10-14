/// Base class for custom exceptions.
abstract class AppException implements Exception {
  final String message;

  AppException({required this.message});

  @override
  String toString() => '$runtimeType: $message';
}

/// Exception thrown for server-related errors.
class ServerException extends AppException {
  final String ident;

  ServerException({required this.ident, required super.message});
}

/// Exception thrown for authentication errors.
class AuthenticationException extends AppException {
  AuthenticationException({required super.message});
}

/// Exception thrown when a session has expired.
class SessionExpiredException extends AppException {
  final String ident;

  SessionExpiredException({required this.ident, required super.message});
}

class ParserException extends AppException {
  final String serviceIdent;
  final String unitIdent;

  ParserException(
      {required this.serviceIdent,
      required this.unitIdent,
      required super.message});
}
