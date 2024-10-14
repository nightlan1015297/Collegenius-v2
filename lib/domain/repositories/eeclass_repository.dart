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
import 'package:collegenius/domain/entities/semester.dart';
import 'package:either_dart/either.dart';

/// Abstract class representing the course schedule repository.
///
/// This repository serves as a contract for retrieving course schedules
/// and semester information from the data source. Implementations of this
/// repository will handle the underlying data retrieval and error management.
abstract class CourseSelectRepository {
  /// Retrieves the current semester information.
  ///
  /// This method returns an [Either] type that contains a [Failure]
  /// in case of an error, or a [Semester] object representing the
  /// current semester if successful.
  Future<Either<Failure, Semester>> getAvalibleSemester();

  Future<Either<Failure, EeclssCourseInfo>> getCourseList({
    required String semester,
  });

  Future<Either<Failure, List<EeclassCourse>>> getCourse({
    required String courseSerial,
  });

  Future<Either<Failure, List<EeclassBulletinInfo>>> getBulletinList({
    required String courseSerial,
    required int page,
  });

  Future<Either<Failure, List<EeclassBulletin>>> getBullitin({
    required String bullitinUrl,
  });

  Future<Either<Failure, List<EeclassMaterialInfo>>> getMaterialList({
    required String courseSerial,
  });

  Future<Either<Failure, EeclassMaterial>> getMaterial({
    required String type,
    required String materialUrl,
  });

  Future<Either<Failure, List<EeclassAssignmentInfo>>> getAssignmentList({
    required String courseSerial,
  });

  Future<Either<Failure, EeclassAssignment>> getAssignment({
    required String assignmentUrl,
  });

  Future<Either<Failure, EeclassQuizInfo>> getQuizList({
    required String courseSerial,
  });

  Future<Either<Failure, EeclassQuiz>> getQuiz({
    required String quizUrl,
  });
}
