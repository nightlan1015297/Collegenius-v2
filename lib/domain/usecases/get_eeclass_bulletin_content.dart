import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/core/usecases/usecase.dart';
import 'package:collegenius/domain/entities/eeclass_bullitin.dart';
import 'package:collegenius/domain/repositories/eeclass_repository.dart';
import 'package:either_dart/either.dart';

class GetEeclassBulletinContent
    extends UseCase<EeclassBulletin, GetBulletinParams> {
  final EeclassRepository repository;

  GetEeclassBulletinContent({required this.repository});
  @override
  Future<Either<Failure, EeclassBulletin>> call(params) async {
    return await repository.getBulletin(bullitinUrl: params.bulletinUrl);
  }
}

class GetBulletinParams {
  final String bulletinUrl;
  GetBulletinParams({required this.bulletinUrl});
}
