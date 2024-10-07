import 'dart:io';
import 'package:collegenius/data/models/auth_result_model.dart';

/// Abstract class representing the authentication provider.
/// 
/// This class serves as a contract for implementing various authentication 
/// mechanisms such as login, logout, and session management. Specific 
/// authentication services (e.g., CourseSelect, Eeclass) will implement 
/// this abstract class.
abstract class AuthProvider {
  final String baseUrl = 'https://example.com'; // Default base URL for authentication requests.
  
  /// Authenticates the user with the given [username] and [password].
  /// 
  /// This method is responsible for handling user authentication. It takes 
  /// a [username] and [password] as parameters and returns an [AuthSuccessModel] 
  /// that contains the authentication result. The result includes a success/failure 
  /// status and relevant user data if successful.
  Future<AuthSuccessModel> authenticate(String username, String password);

  /// Logs out the current user.
  ///
  /// This method ensures that the user's session is properly terminated. It clears
  /// session data from the application and performs any necessary logout operations.
  Future<void> logout();

  /// Retrieves the current user's session data.
  /// 
  /// This function returns a list of [Cookie] objects that represent the user's session 
  /// data, including tokens or other credentials. It allows for managing user sessions 
  /// across different services.
  Future<List<Cookie>> getSession();
}
