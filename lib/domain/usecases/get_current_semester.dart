import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/core/usecases/usecase.dart';
import 'package:collegenius/domain/entities/semester.dart';
import 'package:collegenius/domain/repositories/course_select_repository.dart';
import 'package:either_dart/either.dart';

class GetCurrentSemester implements UseCase<Semester, NoParams> {
  final CourseSelectRepository repository;

  GetCurrentSemester({required this.repository});
  
  @override
  Future<Either<Failure, Semester>> call(NoParams params) async {
    return  await repository.getCurrentSemester();
  }
}