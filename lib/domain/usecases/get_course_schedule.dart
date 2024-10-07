import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/core/usecases/usecase.dart';
import 'package:collegenius/domain/entities/course_schedule.dart';
import 'package:collegenius/domain/repositories/course_select_repository.dart';
import 'package:either_dart/either.dart';


class GetCourseSchedule implements UseCase<CourseSchedule, NoParams> {
  final CourseSelectRepository repository;

  GetCourseSchedule({required this.repository});
  
  @override
  Future<Either<Failure, CourseSchedule>> call(NoParams params) async {
    return await repository.getCourseSchedule();
  }
}