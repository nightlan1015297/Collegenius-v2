import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/core/usecases/usecase.dart';
import 'package:collegenius/domain/entities/eeclass_assignment_info.dart';
import 'package:collegenius/domain/repositories/eeclass_repository.dart';
import 'package:either_dart/either.dart';

class GetEeclassCourseAssignmentList
    implements UseCase<List<EeclassAssignmentInfo>, GetAssignmentListParams> {
  final EeclassRepository repository;

  GetEeclassCourseAssignmentList({required this.repository});

  @override
  Future<Either<Failure, List<EeclassAssignmentInfo>>> call(
      GetAssignmentListParams params) async {
    return await repository.getAssignmentList(
      courseSerial: params.courseSerial,
    );
  }
}

class GetAssignmentListParams {
  final String courseSerial;
  GetAssignmentListParams({
    required this.courseSerial,
  });
}
