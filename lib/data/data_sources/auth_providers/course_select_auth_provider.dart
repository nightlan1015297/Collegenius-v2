import 'package:collegenius/data/data_sources/auth_providers/auth_provider.dart';
import 'package:collegenius/data/models/auth_result_model.dart';
import 'package:collegenius/core/error/exceptions.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

/// An implementation of [AuthProvider] for handling authentication
/// with the course selection system.
///
/// This class uses the Dio HTTP client to manage requests and stores
/// session information using the CookieJar package.
class CourseSelectAuthProvider implements AuthProvider {
  final Dio dio;                    // The Dio instance for making HTTP requests.
  final CookieJar cookieJar;        // Used to manage cookies for the session.

  // The base URL for the course selection system.
  @override
  final String baseUrl = 'https://cis.ncu.edu.tw/Course/main'; 
  
  /// Constructor for [CourseSelectAuthProvider].
  ///
  /// The [dio] client is required for making requests, and [cookieJar]
  /// is used for managing session cookies. This constructor initializes
  /// the class with necessary dependencies.
  CourseSelectAuthProvider({
    required this.dio,
    required this.cookieJar,
  });

  /// Authenticates the user using [username] and [password].
  ///
  /// This method sends a POST request to the login endpoint with user 
  /// credentials. It checks for successful authentication by calling 
  /// [_checkAuthenticationSuccess]. If successful, it returns an 
  /// [AuthSuccessModel] containing the authentication status and session data. 
  /// Throws a [ServerException] if authentication fails.
  @override
  Future<AuthResultModel> authenticate(String username, String password) async {
    try {
      await dio.post(
        '$baseUrl/login',
        data: FormData.fromMap({
          'submit': '登入',                     // Submit button text.
          'account': username,                  // User account (username).
          'passwd': password,                   // User password.
        }),
      );

      // Check if authentication was successful
      final isAuthenticated = await _checkAuthenticationSuccess();

      if (!isAuthenticated) {
        AuthResultModel(isSuccess: false);
      }
      return AuthResultModel(isSuccess: true); // Return an empty AuthSuccessModel on successful authentication.
    } catch (e) {
      throw ServerException(
        ident: 'Course Select',
        message: 'Failed: ${e.toString()}' // Log the error message from the exception.
      );
    }
  }

  /// Helper function to check if authentication was successful.
  ///
  /// This function sends a GET request to the login page to check for 
  /// any redirects. If redirects are present, it indicates a successful 
  /// login. Returns `true` if authentication was successful, otherwise `false`.
  Future<bool> _checkAuthenticationSuccess() async {
    final response = await dio.get('$baseUrl/login');
    if (response.statusCode == 200) {
      // If there are redirects, assume authentication was successful
      return response.redirects.isNotEmpty; // Check for redirects.
    }
    return false; // Return false if the status code is not 200.
  }

  /// Logs out the current user.
  ///
  /// Currently unimplemented, but can be used to clear the session or
  /// make a request to log out from the course selection system.
  @override
  Future<void> logout() async {
    // TODO: Implement logout if required
  }

  /// Retrieves the session data from the stored cookies.
  ///
  /// This method loads cookies stored by the Dio client and returns them
  /// as a [List<Cookie>]. Each cookie represents session-related 
  /// information such as authentication tokens.
  @override
  Future<List<Cookie>> getSession() async {
    var cookiesLst = await cookieJar.loadForRequest(Uri.parse(baseUrl));
    return cookiesLst; // Return the list of cookies for the session.
  }
}
