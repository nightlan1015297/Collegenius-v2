import 'package:collegenius/core/error/exceptions.dart';
import 'package:collegenius/data/data_sources/crawlers/crawler.dart';
import 'package:dio/dio.dart';

/// A class responsible for crawling the EEClass website for course-related information.
///
/// The [EeclassCrawler] extends the [Crawler] abstract class and provides
/// implementations for fetching page content and checking session availability.
class EeclassCrawler extends Crawler {
  final Dio dio; // An instance of Dio for making HTTP requests.
  final String baseUrl = 'https://ncueeclass.ncu.edu.tw'; // Base URL for EEClass.

  /// Constructs an [EeclassCrawler] with the given [dio] instance.
  ///
  /// The [dio] parameter is required for making HTTP requests.
  EeclassCrawler({required this.dio});

  /// Fetches the content of the specified [url].
  ///
  /// This method checks if the user session is available. If the session
  /// is expired, it throws a [SessionExpiredException]. Otherwise, it makes
  /// a GET request to the provided [url] and returns the response body as a string.
  ///
  /// Throws [ServerException] if the request fails.
  @override
  Future<String> fetchPageContent(String url, {FormData? data}) async {
    try {
      // Check if the session is available before making the request.
      if (!await sessionIsAvailiable()) {
        // Throw a SessionExpiredException if the session is not available.
        throw SessionExpiredException(
            ident: 'Eeclass', message: 'Session expired');
      }
      if (data != null) {
        // Perform a POST request if form data is provided.
        var response = await dio.post('$baseUrl$url', data: data);
        return response.data.toString();
      } else {
        // Perform a GET request if no form data is provided.
        var response = await dio.get('$baseUrl$url');
        return response.data.toString();
      }
    } catch (e) {
      // Handle any errors by throwing a ServerException with details.
      throw ServerException(
          ident: 'Eeclass', message: 'Failed: ${e.toString()}');
    }
  }

  /// Checks if the user session is currently available.
  ///
  /// This method makes a request to the login page and checks the
  /// redirect status. If the server redirects to another page, it indicates
  /// that the user is logged in and the session is valid.
  ///
  /// Returns `true` if the session is available, otherwise `false`.
  @override
  Future<bool> sessionIsAvailiable() async {
    var res = await dio.get('$baseUrl/index/login');
    return res.isRedirect;
  }

  Future<void> toggleToEng() async {
    var response = await fetchPageContent('/dashboard');
    final reg =
        RegExp(r'\/ajax\/sys\.app\.service\/changeLocale\/\?ajaxAuth=\w+');
    var ajaxAuth = reg.firstMatch(response)![0];
    await dio.post(ajaxAuth!, data: FormData.fromMap({'locale': 'en-us'}));
  }

  /// Get all courses for given semester
  Future<String> getCoursesListPage({
    required String semester,
  }) async {
    return await fetchPageContent('/dashboard/historyCourse?termId=$semester');
  }

  /// History Course contains all avaliable semester information
  Future<String> getHistoryCoursePage() async {
    return await fetchPageContent('/dashboard/historyCourse');
  }

  /// Get course information page 
  Future<String> getCourseInfoPage({
    required String courseSerial,
  }) async {
    return await fetchPageContent('/course/info/$courseSerial');
  }

  /// Get course bulltin List
  Future<String> getCourseBulletinsListPage({
    required String courseSerial,
    int page = 1,
  }) async {
    return await fetchPageContent('/course/bulletin/$courseSerial?page=$page');
  }

  Future<String> getBullitin({
    required String bulletinUrl,
  }) async {
    return await fetchPageContent(bulletinUrl);
  }

  Future<String> getCourseMaterialListPage({
    required String courseSerial,
  }) async {
    return await fetchPageContent('/course/material/$courseSerial');
  }

  Future<String> getCourseMaterial({
    required String materialUrl,
  }) async {
    return await fetchPageContent(materialUrl);
  }

  Future<String> getCourseAssignmentListPage({
    required String courseSerial,
  }) async {
    return await fetchPageContent('/course/homeworkList/$courseSerial');
  }

  Future<String> getAssignment({
    required String assignmentUrl,
  }) async {
    return await fetchPageContent(assignmentUrl);
  }

  Future<String> getCourseQuizListPage({
    required String courseSerial,
  }) async {
    return await fetchPageContent('/course/examList/$courseSerial');
  }

  Future<String> getQuiz({
    required String quizUrl,
  }) async {
    return await fetchPageContent(quizUrl);
  }

  Future<String> getQuizScoreDistribution({
    required String scoreDistributionUrl,
  }) async {
    return await fetchPageContent(scoreDistributionUrl);
  }
}
