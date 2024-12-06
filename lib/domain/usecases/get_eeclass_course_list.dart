import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/core/usecases/usecase.dart';
import 'package:collegenius/domain/entities/eeclass_course_info.dart';
import 'package:collegenius/domain/repositories/eeclass_repository.dart';
import 'package:either_dart/either.dart';

class GetEeclassCourseList implements UseCase<List<EeclassCourseInfo>, GetCourseListParams> {
  final EeclassRepository repository;

  GetEeclassCourseList({required this.repository});
  
  @override
  Future<Either<Failure, List<EeclassCourseInfo>>> call(GetCourseListParams params) async {
    return await repository.getCourseList(semester:params.semesterId);
  }
}

class GetCourseListParams {
  final String semesterId;
  GetCourseListParams({required this.semesterId});
}