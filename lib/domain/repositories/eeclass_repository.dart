import 'package:collegenius/core/constants.dart';
import 'package:collegenius/core/error/failures.dart';
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
import 'package:either_dart/either.dart';

/// Abstract class representing the EE Class repository.
///
/// This repository serves as a contract for interacting with EE Class
/// data such as courses, assignments, materials, quizzes, and bulletins.
/// The implementation of this repository will handle data retrieval and
/// error management, allowing for dependency inversion and easier testing.
abstract class EeclassRepository {
  /// Retrieves a list of available semesters.
  ///
  /// Returns an [Either] containing either a [Failure] if an error occurs,
  /// or a list of [EeclassSemester] representing the available semesters.
  Future<Either<Failure, List<EeclassSemester>>> getAvailableSemester();

  /// Retrieves a list of course information for a given semester.
  ///
  /// Parameters:
  /// - [semester]: The identifier for the semester for which to fetch course list.
  ///
  /// Returns an [Either] with a [Failure] on error or a list of [EeclssCourseInfo]
  /// containing the available courses for the specified semester.
  Future<Either<Failure, List<EeclssCourseInfo>>> getCourseList({
    required String semester,
  });

  /// Retrieves detailed information about a specific course.
  ///
  /// Parameters:
  /// - [courseSerial]: The unique identifier for the course.
  ///
  /// Returns an [Either] with a [Failure] on error or an [EeclassCourse] object
  /// representing the full details of the specified course.
  Future<Either<Failure, EeclassCourse>> getCourse({
    required String courseSerial,
  });

  /// Retrieves a list of bulletin information for a specific course.
  ///
  /// Parameters:
  /// - [courseSerial]: The unique identifier for the course.
  /// - [page]: The page number for pagination purposes.
  ///
  /// Returns an [Either] with a [Failure] on error or a list of [EeclassBulletinInfo]
  /// containing information about the bulletins for the course.
  Future<Either<Failure, List<EeclassBulletinInfo>>> getBulletinList({
    required String courseSerial,
    required int page,
  });

  /// Retrieves detailed bulletin content based on the bulletin URL.
  ///
  /// Parameters:
  /// - [bullitinUrl]: The URL of the bulletin to be retrieved.
  ///
  /// Returns an [Either] with a [Failure] on error or an [EeclassBulletin] containing
  /// the details of the specified bulletin.
  Future<Either<Failure, EeclassBulletin>> getBullitin({
    required String bullitinUrl,
  });

  /// Retrieves a list of materials for a specific course.
  ///
  /// Parameters:
  /// - [courseSerial]: The unique identifier for the course.
  ///
  /// Returns an [Either] with a [Failure] on error or a list of [EeclassMaterialInfo]
  /// containing information about the available course materials.
  Future<Either<Failure, List<EeclassMaterialInfo>>> getMaterialList({
    required String courseSerial,
  });

  /// Retrieves specific course material based on type and URL.
  ///
  /// Parameters:
  /// - [type]: The type of material (e.g., PDF, video).
  /// - [materialUrl]: The URL of the material to be fetched.
  ///
  /// Returns an [Either] with a [Failure] on error or an [EeclassMaterial] containing
  /// the material details.
  Future<Either<Failure, EeclassMaterial>> getMaterial({
    required EeclassMaterialType type,
    required String materialUrl,
  });

  /// Retrieves a list of assignments for a specific course.
  ///
  /// Parameters:
  /// - [courseSerial]: The unique identifier for the course.
  ///
  /// Returns an [Either] with a [Failure] on error or a list of [EeclassAssignmentInfo]
  /// containing information about the available assignments for the course.
  Future<Either<Failure, List<EeclassAssignmentInfo>>> getAssignmentList({
    required String courseSerial,
  });

  /// Retrieves specific assignment details based on the assignment URL.
  ///
  /// Parameters:
  /// - [assignmentUrl]: The URL of the assignment to be retrieved.
  ///
  /// Returns an [Either] with a [Failure] on error or an [EeclassAssignment] containing
  /// the details of the specified assignment.
  Future<Either<Failure, EeclassAssignment>> getAssignment({
    required String assignmentUrl,
  });

  /// Retrieves a list of quizzes for a specific course.
  ///
  /// Parameters:
  /// - [courseSerial]: The unique identifier for the course.
  ///
  /// Returns an [Either] with a [Failure] on error or a list of [EeclassQuizInfo]
  /// containing information about the available quizzes for the course.
  Future<Either<Failure, List<EeclassQuizInfo>>> getQuizList({
    required String courseSerial,
  });

  /// Retrieves specific quiz details based on the quiz URL.
  ///
  /// Parameters:
  /// - [quizUrl]: The URL of the quiz to be retrieved.
  ///
  /// Returns an [Either] with a [Failure] on error or an [EeclassQuiz] containing
  /// the details of the specified quiz.
  Future<Either<Failure, EeclassQuiz>> getQuiz({
    required String quizUrl,
  });
}
