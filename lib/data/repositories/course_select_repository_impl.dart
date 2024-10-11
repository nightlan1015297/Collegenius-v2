import 'package:collegenius/core/constants.dart';
import 'package:collegenius/core/error/exceptions.dart';
import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/data/data_sources/crawlers/course_select_crawler.dart';
import 'package:collegenius/data/data_sources/parsers/course_select_parser.dart';
import 'package:collegenius/domain/entities/course_schedule.dart';
import 'package:collegenius/domain/entities/semester.dart';
import 'package:collegenius/domain/repositories/auth_repository.dart';
import 'package:collegenius/domain/repositories/course_select_repository.dart';
import 'package:either_dart/either.dart';

/// Implementation of the [CourseSelectRepository] interface.
///
/// This class is responsible for managing course schedules, including fetching
/// the current course schedule, current semester, and list of semesters.
/// It interacts with different layers such as [AuthRepository] for session management,
/// and [CourseSelectCrawler] for crawling course data from the external source.
class CourseSelectRepositoryImpl implements CourseSelectRepository {
  /// Repository for authentication management.
  ///
  /// This handles session-related tasks, such as renewing sessions when they expire.
  final AuthRepository authRepository;

  /// Crawler for fetching course data from the external course selection system.
  ///
  /// [crsselCrawler] is responsible for making HTTP requests to fetch raw course
  /// data such as course schedules and semester details.
  final CourseSelectCrawler crsselCrawler;

  /// Constructs a [CourseSelectRepositoryImpl] instance.
  ///
  /// Requires [authRepository] for session handling and [crsselCrawler] for
  /// data crawling from the course selection system.
  CourseSelectRepositoryImpl({
    required this.authRepository,
    required this.crsselCrawler,
  });

  /// Fetches the current course schedule.
  ///
  /// This method checks if the session is available. If not, it renews the session
  /// using the [AuthRepository]. It then retrieves the course table page using
  /// [CourseSelectCrawler] and parses it into a [CourseSchedule] entity using
  /// [CourseSelectParser]. Returns a [Either] type which contains a [Failure] in
  /// case of an error, or the [CourseSchedule] on success.
  ///
  /// Parameters:
  /// - [semester]: Optional parameter specifying the semester for which to fetch
  ///   the course schedule. If not provided, the current semester is used.
  ///
  /// Returns:
  /// - A [Future<Either<Failure, CourseSchedule>>] containing the result.
  @override
  Future<Either<Failure, CourseSchedule>> getCourseSchedule({String? semester}) async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(
            ident: WebsiteIdentifier.courseSelect); // Renew session if unavailable.
      }
      // Fetch the course table page for the specified semester.
      final responseBody = await crsselCrawler.getCourseTablePage(semester);
      // Parse the response body into a CourseSchedule object.
      final courseSchedule = CourseSelectParser.parseSchedule(responseBody);
      // Return the parsed course schedule as a domain entity.
      return Right(courseSchedule.toEntity());
    } on ServerException catch (e) {
      // Handle and return server-related errors.
      return Left(ServerFailure(message: e.message));
    } on SessionExpiredException catch (e) {
      // Handle session expiration and return appropriate failure.
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}'));
    }
  }

  /// Retrieves the current semester.
  ///
  /// This method checks if the session is available and renews it if necessary.
  /// It then fetches the announcement page using [CourseSelectCrawler] and parses
  /// the current semester information using [CourseSelectParser]. Returns an
  /// [Either] type with a [Failure] in case of an error or the current [Semester]
  /// on success.
  ///
  /// Returns:
  /// - A [Future<Either<Failure, Semester>>] containing the current semester information.
  @override
  Future<Either<Failure, Semester>> getCurrentSemester() async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(
            ident: WebsiteIdentifier.courseSelect); // Renew session if unavailable.
      }
      // Fetch the announcement page to retrieve current semester information.
      final responseBody = await crsselCrawler.getAnouncementPage();
      // Parse the response body to extract the current semester.
      final semester = CourseSelectParser.parseCurrentSemester(responseBody);
      // Return the current semester as a domain entity.
      return Right(semester.toEntity());
    } on ServerException catch (e) {
      // Handle and return server-related errors.
      return Left(ServerFailure(message: e.message));
    } on SessionExpiredException catch (e) {
      // Handle session expiration and return appropriate failure.
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}'));
    }
  }

  /// Retrieves a list of available semesters.
  ///
  /// This method checks if the session is available and renews it if necessary.
  /// It fetches the course table page using [CourseSelectCrawler] and parses the
  /// list of semesters using [CourseSelectParser]. Returns an [Either] type containing
  /// a [Failure] on error or a list of [Semester] entities on success.
  ///
  /// Returns:
  /// - A [Future<Either<Failure, List<Semester>>>] containing the list of semesters.
  @override
  Future<Either<Failure, List<Semester>>> getSemesterList() async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(
          ident: WebsiteIdentifier.courseSelect); // Renew session if unavailable.
      }
      // Fetch the course table page to retrieve the list of semesters.
      final responseBody = await crsselCrawler.getCourseTablePage(null);
      // Parse the response body to extract the list of semesters.
      final semesterList = CourseSelectParser.parseSemesterList(responseBody);
      // Return the list of semesters as domain entities.
      return Right(semesterList.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      // Handle and return server-related errors.
      return Left(ServerFailure(message: e.message));
    } on SessionExpiredException catch (e) {
      // Handle session expiration and return appropriate failure.
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}'));
    }
  }

  /// Checks if the current session is available.
  ///
  /// This method uses [CourseSelectCrawler] to determine if the session
  /// is still valid and accessible. It returns a boolean indicating session
  /// availability.
  ///
  /// Returns:
  /// - A [Future<bool>] indicating whether the current session is valid.
  Future<bool> sessionIsAvaliable() async {
    return await crsselCrawler.sessionIsAvailiable(); // Check session availability.
  }
}
