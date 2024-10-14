import 'package:collegenius/core/error/exceptions.dart';
import 'package:collegenius/data/data_sources/crawlers/crawler.dart';
// ignore: depend_on_referenced_packages
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

/// A class responsible for crawling course selection pages.
///
/// This class extends [Crawler] and implements methods to fetch page content
/// from the course selection system. It handles session verification and
/// manages exceptions related to server responses, including session expiration
/// and server issues.
class CourseSelectCrawler extends Crawler {
  /// The Dio instance used for making HTTP requests.
  ///
  /// [dio] is a third-party library used for performing HTTP requests, allowing 
  /// GET and POST operations to interact with the course selection system.
  final Dio dio;

  /// Cookie jar for session management.
  ///
  /// [sessionManager] manages cookies, which helps maintain user sessions 
  /// across different requests, ensuring continuity for the session.
  final CookieJar sessionManager;

  /// Base URL for course selection.
  ///
  /// [baseUrl] serves as the root URL for all requests made to the course 
  /// selection system.
  final baseUrl = 'https://cis.ncu.edu.tw/Course/main';

  /// Constructs a [CourseSelectCrawler] instance.
  ///
  /// Requires [dio] and [sessionManager] for handling HTTP requests and 
  /// managing user sessions, respectively.
  CourseSelectCrawler({required this.dio, required this.sessionManager});

  /// Fetches the content of a web page from the course selection system.
  ///
  /// This method checks if the session is available before making a request.
  /// If the session is expired, it throws a [SessionExpiredException].
  /// If the request fails, it throws a [ServerException] with details about
  /// the failure. 
  ///
  /// Parameters:
  /// - [url]: The specific path of the course selection system page to be fetched.
  /// - [data]: Optional [FormData] containing additional data for POST requests.
  ///
  /// Returns:
  /// - A [Future<String>] containing the HTML content of the requested page.
  ///
  /// Throws:
  /// - [ServerException] if the request fails.
  @override
  Future<String> fetchPageContent(String url, {FormData? data}) async {
    try {
      // Check if the session is available before making the request.
      if (!await sessionIsAvailiable()) {
        // Throw a SessionExpiredException if the session is not available.
        throw SessionExpiredException(
            ident: 'Course Select', message: 'Session expired');
      }
      if (data != null) {
        // Perform a POST request if form data is provided.
        var response = await dio.post('$baseUrl/$url', data: data);
        return response.data.toString();
      } else {
        // Perform a GET request if no form data is provided.
        var response = await dio.get('$baseUrl/$url');
        return response.data.toString();
      }
    } catch (e) {
      // Handle any errors by throwing a ServerException with details.
      throw ServerException(
          ident: 'Course Select', message: 'Failed: ${e.toString()}');
    }
  }

  /// Checks if the session is available.
  ///
  /// This method sends a request to the login page and checks if there are
  /// any redirects. If there are no redirects, it indicates that the session
  /// is no longer valid, meaning the user needs to log in again.
  ///
  /// Returns:
  /// - A [Future<bool>] indicating whether the session is still valid.
  @override
  Future<bool> sessionIsAvailiable() async {
    var response = await dio.get('$baseUrl/login');
    return response
        .redirects.isNotEmpty; // Returns true if session is available.
  }

  /// Fetches the course table page from the course selection system.
  ///
  /// This method fetches the page that contains the list of semesters and 
  /// courses available for selection. It can also filter the course table
  /// based on the [semester] parameter.
  ///
  /// Parameters:
  /// - [semester]: The specific semester for which the course table should be fetched.
  ///   If null, the current course table will be fetched.
  ///
  /// Returns:
  /// - A [Future<String>] containing the HTML content of the course table page.
  Future<String> getCourseTablePage(String? semester) async {
    if (semester == null) {
      // Fetch the default course table page if no specific semester is provided.
      return await fetchPageContent('personal/A4Crstable');
    }
    // Fetch the course table for the specified semester.
    return await fetchPageContent('personal/A4Crstable',
        data: FormData.fromMap({
          'semester': semester,
        }));
  }

  /// Fetches the announcement page from the course selection system.
  ///
  /// This page contains the latest announcements and semester information,
  /// such as important dates and updates related to course selection.
  ///
  /// Returns:
  /// - A [Future<String>] containing the HTML content of the announcement page.
  Future<String> getAnouncementPage() async {
    return await fetchPageContent('news/announce');
  }
}
