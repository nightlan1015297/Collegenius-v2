import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/core/usecases/usecase.dart';
import 'package:collegenius/domain/entities/semester.dart';
import 'package:collegenius/domain/repositories/course_select_repository.dart';
import 'package:either_dart/either.dart';

class GetSemesterList implements UseCase<List<Semester>, NoParams> {
  final CourseSelectRepository repository;

  GetSemesterList({required this.repository});
  
  @override
  Future<Either<Failure, List<Semester>>> call(NoParams params) async {
    return await repository.getSemesterList();
  }
}