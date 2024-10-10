import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:cookie_jar/cookie_jar.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;

import 'package:collegenius/core/error/exceptions.dart';
import 'package:collegenius/data/models/auth_result_model.dart';
import 'package:collegenius/data/data_sources/auth_providers/auth_provider.dart';

/// An implementation of [AuthProvider] for handling authentication
/// with the Eeclass system at NCU.
///
/// This class uses Dio for HTTP requests and manages session information 
/// with CookieJar.
class EeclassAuthProvider implements AuthProvider {
  final Dio dio;                    // The Dio instance for making HTTP requests.
  final CookieJar cookieJar;        // Used to manage cookies for the session.

  @override
  final String baseUrl = 'https://ncueeclass.ncu.edu.tw';  

  /// Constructor for [EeclassAuthProvider].
  ///
  /// The [dio] client is required for making requests, and [cookieJar]
  /// is used for managing session cookies.
  EeclassAuthProvider({
    required this.dio,
    required this.cookieJar,
  });

  /// Authenticates the user using [username] and [password].
  ///
  /// This method first attempts to log in and returns an 
  /// [AuthSuccessModel] if successful. Throws an [AuthenticationException] 
  /// if login fails.
  @override
  Future<AuthResultModel> authenticate(String username, String password) async {
    // Perform login
    final validationResult = await _logIn(username, password);
    return AuthResultModel(isSuccess: validationResult);
  }

  /// Handles the login process.
  ///
  /// This method retrieves the CSRF token and sends a POST request
  /// to the login endpoint with user credentials. It checks login status 
  /// again and returns true if login is successful.
  Future<bool> _logIn(String username, String password) async {
    var csrfToken = await _getCsrfToken(); // Get the CSRF token for the session.

    var response = await dio.post(
      '$baseUrl/index/login',
      data: FormData.fromMap({
        '_fmSubmit': 'yes',             // Form submission flag.
        'formVer': '3.0',               // Form version.
        'formId': 'login_form',         // Form ID.
        'next': '/',                    // Redirect path after login.
        'act': 'kick',                  // Action to kick the session.
        'account': username,            // User account (username).
        'password': password,           // User password.
        'rememberMe': '',               // Remember me option.
        'anticsrf': csrfToken,          // CSRF token for security.
      }),
      options: Options(
        followRedirects: false,                    // Do not follow redirects automatically.
        validateStatus: (status) => status! < 500, // Valid status codes below 500.
      ),
    );

    // Check login status again
    final loginState = await _checkLogInStatus();

    return loginState; // Return the login status.
  }

  /// Retrieves the CSRF token from the homepage.
  ///
  /// This method sends a GET request to the homepage and parses the HTML 
  /// response to extract the CSRF token from the login form.
  Future<String> _getCsrfToken() async {
    var response = await dio.get('$baseUrl/');
    if (response.statusCode != 200) {
      throw ServerException(
        ident: 'Eeclass',
        message: 'Failed to get CSRF token. Server responded with status code ${response.statusCode}.',
      );
    }

    dom.Document document = htmlparser.parse(response.data.toString());
    List<dom.Element> elements = document.getElementsByClassName('fs-form-control');
    for (var element in elements) {
      for (var child in element.children) {
        if (child.attributes['name'] == 'anticsrf') {
          return child.attributes['value'] ?? ''; // Return CSRF token value.
        }
      }
    }
    throw ServerException(
      ident: 'Eeclass',
      message: 'CSRF token not found in the login page.',
    );
  }

  /// Checks if the user is logged in by examining the login page response.
  ///
  /// Sends a GET request to the login page and checks if the response indicates 
  /// a redirect, which typically signifies that the user is logged in.
  Future<bool> _checkLogInStatus() async {
    var response = await dio.get(
      '$baseUrl/index/login',
      options: Options(
        followRedirects: false, // Do not follow redirects automatically.
        validateStatus: (status) => status! < 500, // Valid status codes below 500.
      ),
    );

    // If the server redirects to another page, it usually means we're logged in
    return response.isRedirect; // Return true if there is a redirect.
  }

  /// Logs out the current user.
  ///
  /// This method can be used to terminate the user's session.
  @override
  Future<void> logout() async {
    await dio.get('$baseUrl/logout'); // Send a GET request to the logout endpoint.
  }

  /// Retrieves the session data from stored cookies.
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
