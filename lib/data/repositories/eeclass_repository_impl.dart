
import 'package:collegenius/core/constants.dart';
import 'package:collegenius/core/error/exceptions.dart';
import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/data/data_sources/crawlers/eeclass_crawler.dart';
import 'package:collegenius/data/data_sources/parsers/eeclass_parser.dart';
import 'package:collegenius/domain/entities/eeclass_assignment.dart';
import 'package:collegenius/domain/entities/eeclass_assignment_info.dart';
import 'package:collegenius/domain/entities/eeclass_bulletin_info.dart';
import 'package:collegenius/domain/entities/eeclass_bullitin.dart';
import 'package:collegenius/domain/entities/eeclass_course.dart';
import 'package:collegenius/domain/entities/eeclass_course_info.dart';
import 'package:collegenius/domain/entities/eeclass_material.dart';
import 'package:collegenius/domain/entities/eeclass_material_info.dart';
import 'package:collegenius/domain/entities/eeclass_quiz.dart';
import 'package:collegenius/domain/entities/eeclass_quiz_info.dart';
import 'package:collegenius/domain/entities/eeclass_semester.dart';
import 'package:collegenius/domain/repositories/auth_repository.dart';
import 'package:collegenius/domain/repositories/eeclass_repository.dart';
import 'package:either_dart/either.dart';

class EeclassRepositoryImpl implements EeclassRepository {
  /// Repository for authentication management.
  ///
  /// This handles session-related tasks, such as renewing sessions when they expire.
  final AuthRepository authRepository;
  final EeclassCrawler eeclassCrawler;

  EeclassRepositoryImpl({
    required this.authRepository,
    required this.eeclassCrawler,
  });

  @override
  Future<Either<Failure, EeclassAssignment>> getAssignment(
      {required String assignmentUrl}) async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(
            ident: WebsiteIdentifier.eeclass); // Renew session if unavailable.
      }
      final String responseBody =
          await eeclassCrawler.getAssignment(assignmentUrl: assignmentUrl);
      final EeclassAssignment assignment =
          EeclassParser.parseAssignment(responseBody).toEntity();
      return Right(assignment);
    } on ServerException catch (e) {
      // Handle and return server-related errors.
      return Left(ServerFailure(message: e.message));
    } on SessionExpiredException catch (e) {
      // Handle session expiration and return appropriate failure.
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}'));
    } on ParserException catch (e) {
      return Left(ParserFailure(
          message:
              "${e.serviceIdent} Parser, ${e.unitIdent} unit parser failed with message: \n ${e.message}"));
    }
  }

  @override
  Future<Either<Failure, List<EeclassAssignmentInfo>>> getAssignmentList(
      {required String courseSerial}) async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(
            ident: WebsiteIdentifier.eeclass); // Renew session if unavailable.
      }
      final String responseBody = await eeclassCrawler
          .getCourseAssignmentListPage(courseSerial: courseSerial);
      final List<EeclassAssignmentInfo> assignmentList =
          EeclassParser.parseAssignmentList(responseBody)
              .map((assignment) => assignment.toEntity())
              .toList();
      // Convert to domain entities.
      return Right(assignmentList);
    } on ServerException catch (e) {
      // Handle and return server-related errors.
      return Left(ServerFailure(message: e.message));
    } on SessionExpiredException catch (e) {
      // Handle session expiration and return appropriate failure.
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}'));
    } on ParserException catch (e) {
      return Left(ParserFailure(
          message:
              "${e.serviceIdent} Parser, ${e.unitIdent} unit parser failed with message: \n ${e.message}"));
    }
  }

  @override
  Future<Either<Failure, List<EeclassSemester>>> getAvalibleSemester() async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(
            ident: WebsiteIdentifier.eeclass); // Renew session if unavailable.
      }
      final String responseBody = await eeclassCrawler.getHistoryCoursePage();
      final List<EeclassSemester> semesterList =
          EeclassParser.parseAvailiableSemester(responseBody)
              .map((semester) => semester.toEntity())
              .toList();

      return Right(semesterList);
    } on ServerException catch (e) {
      // Handle and return server-related errors.
      return Left(ServerFailure(message: e.message));
    } on SessionExpiredException catch (e) {
      // Handle session expiration and return appropriate failure.
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}'));
    } on ParserException catch (e) {
      return Left(ParserFailure(
          message:
              "${e.serviceIdent} Parser, ${e.unitIdent} unit parser failed with message: \n ${e.message}"));
    }
  }

  @override
  Future<Either<Failure, List<EeclassBulletinInfo>>> getBulletinList(
      {required String courseSerial, required int page}) async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(
            ident: WebsiteIdentifier.eeclass); // Renew session if unavailable.
      }
      final String responseBody = await eeclassCrawler
          .getCourseBulletinsListPage(courseSerial: courseSerial, page: page);
      final List<EeclassBulletinInfo> bullitinList =
          EeclassParser.parseBulletinList(responseBody)
              .map((semester) => semester.toEntity())
              .toList();

      return Right(bullitinList);
    } on ServerException catch (e) {
      // Handle and return server-related errors.
      return Left(ServerFailure(message: e.message));
    } on SessionExpiredException catch (e) {
      // Handle session expiration and return appropriate failure.
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}'));
    } on ParserException catch (e) {
      return Left(ParserFailure(
          message:
              "${e.serviceIdent} Parser, ${e.unitIdent} unit parser failed with message: \n ${e.message}"));
    }
  }

  @override
  Future<Either<Failure, EeclassBulletin>> getBullitin(
      {required String bullitinUrl}) async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(
            ident: WebsiteIdentifier.eeclass); // Renew session if unavailable.
      }
      final String responseBody =
          await eeclassCrawler.getBullitin(bulletinUrl: bullitinUrl);
      final EeclassBulletin bullitin =
          EeclassParser.parseBulletin(responseBody).toEntity();

      return Right(bullitin);
    } on ServerException catch (e) {
      // Handle and return server-related errors.
      return Left(ServerFailure(message: e.message));
    } on SessionExpiredException catch (e) {
      // Handle session expiration and return appropriate failure.
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}'));
    } on ParserException catch (e) {
      return Left(ParserFailure(
          message:
              "${e.serviceIdent} Parser, ${e.unitIdent} unit parser failed with message: \n ${e.message}"));
    }
  }

  @override
  Future<Either<Failure, EeclassCourse>> getCourse(
      {required String courseSerial}) async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(
            ident: WebsiteIdentifier.eeclass); // Renew session if unavailable.
      }
      // Get course page.
      final String responseBody =
          await eeclassCrawler.getCourseInfoPage(courseSerial: courseSerial);
      // Parse course page.
      final EeclassCourse course =
          EeclassParser.parseCourse(responseBody).toEntity();
      // Convert to domain entities.
      return Right(course);
    } on ServerException catch (e) {
      // Handle and return server-related errors.
      return Left(ServerFailure(message: e.message));
    } on SessionExpiredException catch (e) {
      // Handle session expiration and return appropriate failure.
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}'));
    } on ParserException catch (e) {
      return Left(ParserFailure(
          message:
              "${e.serviceIdent} Parser, ${e.unitIdent} unit parser failed with message: \n ${e.message}"));
    }
  }

  @override
  Future<Either<Failure, List<EeclssCourseInfo>>> getCourseList(
      {required String semester}) async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(
            ident: WebsiteIdentifier.eeclass); // Renew session if unavailable.
      }
      // Get course page.
      final String responseBody =
          await eeclassCrawler.getCoursesListPage(semester: semester);
      // Parse course page.
      final List<EeclssCourseInfo> courseList =
          EeclassParser.parseCourseList(responseBody)
              .map((e) => e.toEntity())
              .toList();
      // Convert to domain entities.
      return Right(courseList);
    } on ServerException catch (e) {
      // Handle and return server-related errors.
      return Left(ServerFailure(message: e.message));
    } on SessionExpiredException catch (e) {
      // Handle session expiration and return appropriate failure.
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}'));
    } on ParserException catch (e) {
      return Left(ParserFailure(
          message:
              "${e.serviceIdent} Parser, ${e.unitIdent} unit parser failed with message: \n ${e.message}"));
    }
  }

  @override
  Future<Either<Failure, EeclassMaterial>> getMaterial(
      {required EeclassMaterialType type, required String materialUrl}) async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(
            ident: WebsiteIdentifier.eeclass); // Renew session if unavailable.
      }
      // Get course page.
      final String responseBody =
          await eeclassCrawler.getCourseMaterial(materialUrl: materialUrl);
      // Parse course page.
      final EeclassMaterial material =
          EeclassParser.parseMaterial(responseBody,type).toEntity();
      // Convert to domain entities.
      return Right(material);
    } on ServerException catch (e) {
      // Handle and return server-related errors.
      return Left(ServerFailure(message: e.message));
    } on SessionExpiredException catch (e) {
      // Handle session expiration and return appropriate failure.
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}'));
    } on ParserException catch (e) {
      return Left(ParserFailure(
          message:
              "${e.serviceIdent} Parser, ${e.unitIdent} unit parser failed with message: \n ${e.message}"));
    }
  }

  @override
  Future<Either<Failure, List<EeclassMaterialInfo>>> getMaterialList(
      {required String courseSerial}) async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(
            ident: WebsiteIdentifier.eeclass); // Renew session if unavailable.
      }
      // Get course page.
      final String responseBody =
          await eeclassCrawler.getCourseMaterialListPage(courseSerial: courseSerial);
      // Parse course page.
      final List<EeclassMaterialInfo> materialList =
          EeclassParser.parseMaterialList(responseBody).map((e) => e.toEntity()).toList();
      // Convert to domain entities.
      return Right(materialList);
    } on ServerException catch (e) {
      // Handle and return server-related errors.
      return Left(ServerFailure(message: e.message));
    } on SessionExpiredException catch (e) {
      // Handle session expiration and return appropriate failure.
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}'));
    } on ParserException catch (e) {
      return Left(ParserFailure(
          message:
              "${e.serviceIdent} Parser, ${e.unitIdent} unit parser failed with message: \n ${e.message}"));
    }
  }

  @override
  Future<Either<Failure, EeclassQuiz>> getQuiz({required String quizUrl}) async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(
            ident: WebsiteIdentifier.eeclass); // Renew session if unavailable.
      }
      // Get course page.
      final String responseBody =
          await eeclassCrawler.getQuiz(quizUrl: quizUrl);
      // Parse course page.
      final EeclassQuiz quiz =
          EeclassParser.parseQuiz(responseBody).toEntity();
      // Convert to domain entities.
      return Right(quiz);
    } on ServerException catch (e) {
      // Handle and return server-related errors.
      return Left(ServerFailure(message: e.message));
    } on SessionExpiredException catch (e) {
      // Handle session expiration and return appropriate failure.
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}'));
    } on ParserException catch (e) {
      return Left(ParserFailure(
          message:
              "${e.serviceIdent} Parser, ${e.unitIdent} unit parser failed with message: \n ${e.message}"));
    }
  }

  @override
  Future<Either<Failure, List<EeclassQuizInfo>>> getQuizList(
      {required String courseSerial}) async {
    try {
      final isAvail = await sessionIsAvaliable(); // Check session availability.
      if (!isAvail) {
        authRepository.renewSession(
            ident: WebsiteIdentifier.eeclass); // Renew session if unavailable.
      }
      // Get course page.
      final String responseBody =
          await eeclassCrawler.getCourseQuizListPage(courseSerial: courseSerial);
      // Parse course page.
      final List<EeclassQuizInfo> quizList =
          EeclassParser.parseQuizList(responseBody).map((e)=>e.toEntity()).toList();
      // Convert to domain entities.
      return Right(quizList);
    } on ServerException catch (e) {
      // Handle and return server-related errors.
      return Left(ServerFailure(message: e.message));
    } on SessionExpiredException catch (e) {
      // Handle session expiration and return appropriate failure.
      return Left(SessionExpiredFailure(
          message:
              'Could not renew session on ${e.ident} with following error \n ${e.message}'));
    } on ParserException catch (e) {
      return Left(ParserFailure(
          message:
              "${e.serviceIdent} Parser, ${e.unitIdent} unit parser failed with message: \n ${e.message}"));
    }
  }

  /// Checks if the current session is available.
  ///
  /// This method uses [EeclassCrawler] to determine if the session
  /// is still valid and accessible. It returns a boolean indicating session
  /// availability.
  ///
  /// Returns:
  /// - A [Future<bool>] indicating whether the current session is valid.
  Future<bool> sessionIsAvaliable() async {
    return await eeclassCrawler
        .sessionIsAvailiable(); // Check session availability.
  }
}
