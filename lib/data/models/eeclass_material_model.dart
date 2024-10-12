import 'package:collegenius/core/constants.dart';
import 'package:collegenius/data/models/eeclass_file_model.dart';

class EeclassMaterialModel {
  final EeclassMaterialType type;
  final List<EeclassFileModel>? fileLst;
  final String? description;
  final String? source;

  EeclassMaterialModel({
    required this.type,
    this.fileLst,
    this.description,
    this.source,
  });
}
