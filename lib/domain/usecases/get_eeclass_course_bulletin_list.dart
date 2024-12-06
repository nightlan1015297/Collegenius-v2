import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/core/usecases/usecase.dart';
import 'package:collegenius/domain/entities/eeclass_bulletin_info.dart';
import 'package:collegenius/domain/repositories/eeclass_repository.dart';
import 'package:either_dart/either.dart';

class GetEeclassCourseBulletinList
    implements UseCase<List<EeclassBulletinInfo>, GetBulletinListParams> {
  final EeclassRepository repository;

  GetEeclassCourseBulletinList({required this.repository});

  @override
  Future<Either<Failure, List<EeclassBulletinInfo>>> call(
      GetBulletinListParams params) async {
    return await repository.getBulletinList(
      courseSerial: params.courseSerial,
      page: params.page,
    );
  }
}

class GetBulletinListParams {
  final String courseSerial;
  final int page;
  GetBulletinListParams({
    required this.courseSerial,
    required this.page,
  });
}
