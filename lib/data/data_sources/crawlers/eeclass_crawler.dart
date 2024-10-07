import 'package:collegenius/core/error/exceptions.dart';
import 'package:collegenius/data/data_sources/crawlers/crawler.dart';
import 'package:dio/dio.dart';

/// A class responsible for crawling the EEClass website for course-related information.
/// 
/// The [EeclassCrawler] extends the [Crawler] abstract class and provides 
/// implementations for fetching page content and checking session availability.
class EeclassCrawler extends Crawler {
  final Dio dio; // An instance of Dio for making HTTP requests.
  final String baseUrl = 'https://eeclass.ncu.edu.tw'; // Base URL for EEClass.

  /// Constructs an [EeclassCrawler] with the given [dio] instance.
  ///
  /// The [dio] parameter is required for making HTTP requests.
  EeclassCrawler({ required this.dio });

  /// Fetches the content of the specified [url].
  ///
  /// This method checks if the user session is available. If the session 
  /// is expired, it throws a [SessionExpiredException]. Otherwise, it makes 
  /// a GET request to the provided [url] and returns the response body as a string.
  ///
  /// Throws [ServerException] if the request fails.
  @override
  Future<String> fetchPageContent(String url) async {
    if (await sessionIsAvailiable()) {
      throw SessionExpiredException(ident: 'Eeclass', message: 'Session expired');
    }
    try {
      var response = await dio.get('$baseUrl/$url');
      return response.data.toString();
    } catch (e) {
      throw ServerException(ident: 'Eeclass', message: 'Failed: ${e.toString()}');
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
    var response = await dio.get(
      '$baseUrl/index/login',
      options: Options(
        followRedirects: false,
        validateStatus: (status) => status! < 500,
      ),
    );

    // If the server redirects to another page, it usually means we're logged in
    return response.isRedirect;
  }
}
