/// Abstract class representing a web crawler.
/// 
/// This class defines the contract for crawling web pages, providing methods 
/// for fetching page content and checking session availability. Specific 
/// implementations will define how to retrieve data from different websites. 
abstract class Crawler {
  /// Fetches the content of a web page at the specified [url].
  /// 
  /// Returns the page content as a [String]. This method should handle 
  /// any necessary HTTP requests and responses.
  Future<String> fetchPageContent(String url);

  /// Checks if the current user session is available.
  /// 
  /// Returns a [bool] indicating whether the session is active. 
  /// This method should verify if the user is logged in or if the session 
  /// has expired.
  Future<bool> sessionIsAvailiable();
}
