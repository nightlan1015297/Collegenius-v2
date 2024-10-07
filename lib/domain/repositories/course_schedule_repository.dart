import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/domain/entities/course_schedule.dart';
import 'package:collegenius/domain/entities/semester.dart';
import 'package:either_dart/either.dart';

/// Abstract class representing the course schedule repository.
/// 
/// This repository serves as a contract for retrieving course schedules 
/// and semester information from the data source. Implementations of this 
/// repository will handle the underlying data retrieval and error management.
abstract class CourseScheduleRepository {
  
  /// Retrieves the course schedule.
  /// 
  /// This method returns an [Either] type that contains a [Failure] 
  /// in case of an error, or a [CourseSchedule] object if successful.
  Future<Either<Failure, CourseSchedule>> getCourseSchedule();

  /// Retrieves the current semester information.
  /// 
  /// This method returns an [Either] type that contains a [Failure] 
  /// in case of an error, or a [Semester] object representing the 
  /// current semester if successful.
  Future<Either<Failure, Semester>> getCurrentSemester();

  /// Retrieves a list of semesters.
  /// 
  /// This method returns an [Either] type that contains a [Failure] 
  /// in case of an error, or a list of [Semester] objects if successful.
  Future<Either<Failure, List<Semester>>> getSemesterList();
}
