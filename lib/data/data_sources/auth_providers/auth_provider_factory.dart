import 'package:collegenius/core/constants.dart';
import 'package:collegenius/data/data_sources/auth_providers/auth_provider.dart';
import 'package:collegenius/data/data_sources/auth_providers/course_select_auth_provider.dart' as course_select;
import 'package:collegenius/data/data_sources/auth_providers/eeclass_auth_provider.dart' as eeclass;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

/// Factory class for creating instances of different authentication providers.
/// 
/// The class provides a mechanism to select and instantiate an authentication
/// provider based on the website identifier (e.g., 'CourseSelect', 'Eeclass').
/// It relies on [Dio] for handling HTTP requests and [CookieJar] for session 
/// management across the services.
class AuthProviderFactory {
  final Dio dio;
  final CookieJar sessionManager;

  /// Constructor for initializing the factory with a [Dio] instance 
  /// for HTTP requests and a [CookieJar] for session management.
  AuthProviderFactory({required this.dio, required this.sessionManager});

  /// Returns an appropriate [AuthProvider] based on the provided [websiteIdentifier].
  /// 
  /// The method uses a switch case to match the identifier with the corresponding 
  /// authentication provider (e.g., 'CourseSelect' or 'Eeclass'). If the identifier
  /// doesn't match any known provider, an [UnsupportedError] is thrown.
  AuthProvider getAuthProvider(WebsiteIdentifier ident) {
    switch (ident) {
      case WebsiteIdentifier.courseSelect:
        return course_select.CourseSelectAuthProvider(dio: dio, cookieJar: sessionManager);
      case WebsiteIdentifier.eeclass:
        return eeclass.EeclassAuthProvider(dio: dio, cookieJar: sessionManager);
      default:
        throw UnsupportedError('Website not supported');
    }
  }
}
