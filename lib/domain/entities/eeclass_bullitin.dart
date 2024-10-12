
import 'package:collegenius/domain/entities/eeclass_file.dart';

class EeclassBulletin{
  final String content;
  final List<EeclassFile> files;

  EeclassBulletin({required this.content, required this.files});

  factory EeclassBulletin.fromMap(Map<String, dynamic> map){
    return EeclassBulletin(
      content: map['content'] ?? '',
      files: List<EeclassFile>.from(map['files'] ?? []),
    );
  }
}