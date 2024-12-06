import 'package:collegenius/domain/entities/eeclass_bulletin_info.dart';
import 'package:collegenius/domain/entities/eeclass_bullitin.dart';
import 'package:collegenius/domain/entities/eeclass_file.dart';

class EeclassCombinedBulletin {
  final String readCount;
  final String author;
  final String date;
  final String title;
  final String url;
  final String content;
  final List<EeclassFile> files;

  EeclassCombinedBulletin({
    required this.readCount,
    required this.author,
    required this.date,
    required this.title,
    required this.url,
    required this.content,
    required this.files,
  });

  factory EeclassCombinedBulletin.fromMultipleEntities({
    required EeclassBulletin bulletin,
    required EeclassBulletinInfo bulletinInfo,
  }) {
    return EeclassCombinedBulletin(
      readCount: bulletinInfo.readCount,
      author: bulletinInfo.author,
      date: bulletinInfo.date,
      title: bulletinInfo.title,
      url: bulletinInfo.url,
      content: bulletin.content,
      files: bulletin.files,
    );
  }
}
