import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/core/usecases/usecase.dart';
import 'package:collegenius/domain/entities/course_schedule.dart';
import 'package:collegenius/domain/entities/semester.dart';
import 'package:collegenius/domain/repositories/course_select_repository.dart';
import 'package:either_dart/either.dart';

/// Use case to get the course schedule for a specific semester.
///
/// This use case class interacts with the [CourseSelectRepository] to 
/// fetch the [CourseSchedule] for a given semester. It extends [UseCase],
/// providing a standard interface for fetching the data.
class GetCourseSchedule implements UseCase<CourseSchedule, ScheduleParams> {
  /// The repository instance used for accessing course selection data.
  ///
  /// This repository is injected through the constructor to follow dependency
  /// injection principles, making the code more modular and testable.
  final CourseSelectRepository repository;

  /// Constructs a [GetCourseSchedule] instance.
  ///
  /// Requires the [repository] that provides methods to access the data 
  /// from the course selection system.
  GetCourseSchedule({required this.repository});
  
  /// Calls the repository to get the course schedule.
  ///
  /// This method takes [ScheduleParams] as input, which includes information
  /// about the [semester] for which the course schedule is being requested.
  /// It returns a [Future] that either contains a [Failure] or the [CourseSchedule].
  ///
  /// Parameters:
  /// - [params]: The parameters required to identify the semester, encapsulated
  ///   in a [ScheduleParams] object.
  ///
  /// Returns:
  /// - A [Future<Either<Failure, CourseSchedule>>] indicating either a failure
  ///   or a successful retrieval of the course schedule.
  @override
  Future<Either<Failure, CourseSchedule>> call(ScheduleParams params) async {
    return await repository.getCourseSchedule(semester: params.semester.id.toString());
  }
}

/// Class representing the parameters needed to get a course schedule.
///
/// This class encapsulates the parameters needed by the [GetCourseSchedule] use case.
/// Specifically, it includes the [semester] for which the schedule is being requested.
class ScheduleParams {
  /// The [Semester] for which the course schedule is needed.
  ///
  /// This contains information such as the semester ID, which is used to
  /// uniquely identify the specific semester.
  final Semester semester;

  /// Constructs a [ScheduleParams] instance.
  ///
  /// Requires the [semester] parameter to specify the target semester for 
  /// which the course schedule is to be fetched.
  ScheduleParams({
    required this.semester,
  });
}
