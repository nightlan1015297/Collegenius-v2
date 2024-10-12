import 'package:collegenius/data/models/eeclass_file_model.dart';

class EeclassBulletinModel{
  final String content;
  final List<EeclassFileModel> files;

  EeclassBulletinModel({required this.content, required this.files});

  factory EeclassBulletinModel.fromMap(Map<String, dynamic> map){
    return EeclassBulletinModel(
      content: map['content'] ?? '',
      files: List<EeclassFileModel>.from(map['files'] ?? []),
    );
  }
}