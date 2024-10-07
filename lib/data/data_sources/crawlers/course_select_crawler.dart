import 'package:collegenius/core/error/exceptions.dart';
import 'package:collegenius/data/data_sources/crawlers/crawler.dart';
import 'package:dio/dio.dart';

/// A class responsible for crawling course selection pages.
/// 
/// This class extends [Crawler] and implements methods to fetch page content 
/// from the course selection system. It handles session verification and 
/// manages exceptions related to server responses.
class CourseSelectCrawler extends Crawler {
  final Dio dio; // The Dio instance used for making HTTP requests.
  final baseUrl = 'https://cis.ncu.edu.tw/Course/main'; // Base URL for course selection.

  CourseSelectCrawler({required this.dio});
  
  /// Fetches the content of a web page from the course selection system.
  /// 
  /// This method checks if the session is available before making a request. 
  /// If the session is expired, it throws a [SessionExpiredException].
  /// If the request fails, it throws a [ServerException] with details.
  @override
  Future<String> fetchPageContent(String url) async {
    if (await sessionIsAvailiable()) {
      throw SessionExpiredException(ident: 'Eeclass', message: 'Session expired');
    }
    try {
      var response = await dio.get('$baseUrl/$url');
      return response.data.toString();
    } catch (e) {
      throw ServerException(ident: 'Course Select', message: 'Failed: ${e.toString()}');
    }
  }

  /// Checks if the session is available.
  /// 
  /// This method sends a request to the login page and checks if there are 
  /// any redirects. If there are no redirects, it indicates that the session 
  /// is no longer valid.
  @override
  Future<bool> sessionIsAvailiable() async {
    var response = await dio.get('$baseUrl/login');
    return response.redirects.isNotEmpty; // Returns true if session is available.
  }

  /// Fetches the course table page from the course selection system.
  /// 
  /// This page contains the list of semesters and courses available for selection.
  Future<String> getCourseTablePage() async {
    return await fetchPageContent('personal/A4Crstable');
  }

  /// Fetches the announcement page from the course selection system.
  /// 
  /// This page contains the latest announcements and semester information.
  Future<String> getAnouncementPage() async {
    return await fetchPageContent('news/announce');
  }
}
