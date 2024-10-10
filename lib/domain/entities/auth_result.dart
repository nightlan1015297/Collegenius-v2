/// Represents a successful authentication result.
///
/// This class can be expanded to include user data and session
/// information as needed.
class AuthResult {
  final bool isSuccess;
  final String message;

  AuthResult({required this.isSuccess, required this.message});
}
