import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/core/usecases/usecase.dart';
import 'package:collegenius/domain/entities/eeclass_course.dart';
import 'package:collegenius/domain/repositories/eeclass_repository.dart';
import 'package:either_dart/either.dart';

class GetEeclassCourse implements UseCase<EeclassCourse, GetCourseParams> {
  final EeclassRepository repository;

  GetEeclassCourse({required this.repository});
  
  @override
  Future<Either<Failure, EeclassCourse>> call(GetCourseParams params) async {
    return await repository.getCourse(courseSerial: params.courseSerial);
  }
}

class GetCourseParams {
  final String courseSerial;
  GetCourseParams({required this.courseSerial});
}

