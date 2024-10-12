
import 'package:collegenius/core/constants.dart';
import 'package:collegenius/domain/entities/eeclass_file.dart';

class EeclassMaterial {
  final EeclassMaterialType type;
  final List<EeclassFile>? fileLst;
  final String? description;
  final String? source;

  EeclassMaterial({
    required this.type,
    this.fileLst,
    this.description,
    this.source,
  });
}
