import 'package:collegenius/core/error/exceptions.dart';
import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/data/data_sources/crawlers/course_select_crawler.dart';
import 'package:collegenius/data/data_sources/parsers/course_select_parser.dart';
import 'package:collegenius/domain/entities/course_schedule.dart';
import 'package:collegenius/domain/entities/semester.dart';
import 'package:collegenius/domain/repositories/auth_repository.dart';
import 'package:collegenius/domain/repositories/course_schedule_repository.dart';
import 'package:either_dart/either.dart';

/// Implementation of the [CourseScheduleRepository] interface.
/// 
/// This class is responsible for managing course schedules, including fetching 
/// the current course schedule, current semester, and list of semesters. It 
/// utilizes the [AuthRepository] for session management and [CourseSelectCrawler] 
/// for crawling the course data from the source.
class CourseScheduleRepositoryImpl implements CourseScheduleRepository {
  final AuthRepository authRepository; // Repository for authentication management.
  final CourseSelectCrawler crsselCrawler; // Crawler for fetching course data.

  CourseScheduleRepositoryImpl(
      {required this.authRepository, required this.crsselCrawler});

  /// Fetches the current course schedule.
  /// 
  /// This method checks if the session is available. If not, it renews the 
  /// session using the [AuthRepository]. It then retrieves the course table 
  /// page and parses it into a [CourseSchedule] entity. Returns a 
  /// [Either] type, which contains a [Failure] on error or the 
  /// [CourseSchedule] on success.
  @override
  Future<Either<Failure, CourseSchedule>> getCourseSchedule() async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(websiteIdentifier: 'CourseSelect'); // Renew session if unavailable.
      }
      final responseBody = await crsselCrawler.getCourseTablePage(); // Fetch course table page.
      final courseSchedule = CourseSelectParser.parseSchedule(responseBody); // Parse the response into CourseSchedule.
      return Right(courseSchedule.toEntity()); // Return the parsed course schedule.
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message)); // Return failure on server error.
    } on SessionExpiredException catch (e) {
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}')); // Handle session expiration.
    }
  }

  /// Retrieves the current semester.
  /// 
  /// This method checks if the session is available and renews it if necessary. 
  /// It then fetches the announcement page and parses the current semester 
  /// information. Returns a [Either] type with a [Failure] on error or the 
  /// current [Semester] on success.
  @override
  Future<Either<Failure, Semester>> getCurrentSemester() async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(websiteIdentifier: 'CourseSelect'); // Renew session if unavailable.
      }
      final responseBody = await crsselCrawler.getAnouncementPage(); // Fetch announcement page.
      final semester = CourseSelectParser.parseCurrentSemester(responseBody); // Parse current semester information.
      return Right(semester.toEntity()); // Return the current semester.
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message)); // Return failure on server error.
    } on SessionExpiredException catch (e) {
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}')); // Handle session expiration.
    }
  }

  /// Retrieves a list of semesters.
  /// 
  /// This method checks if the session is available and renews it if necessary. 
  /// It fetches the course table page and parses the list of semesters. Returns a 
  /// [Either] type containing a [Failure] on error or a list of [Semester] 
  /// entities on success.
  @override
  Future<Either<Failure, List<Semester>>> getSemesterList() async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(websiteIdentifier: 'CourseSelect'); // Renew session if unavailable.
      }
      final responseBody = await crsselCrawler.getCourseTablePage(); // Fetch course table page.
      final semesterList = CourseSelectParser.parseSemesterList(responseBody); // Parse the list of semesters.
      return Right(semesterList.map((e) => e.toEntity()).toList()); // Return the list of semesters.
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message)); // Return failure on server error.
    } on SessionExpiredException catch (e) {
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}')); // Handle session expiration.
    }
  }

  /// Checks if the current session is available.
  /// 
  /// This method uses the [CourseSelectCrawler] to determine if the session 
  /// is still valid and accessible. Returns a boolean indicating session 
  /// availability.
  Future<bool> sessionIsAvaliable() async {
    return await crsselCrawler.sessionIsAvailiable(); // Check session availability.
  }
}
