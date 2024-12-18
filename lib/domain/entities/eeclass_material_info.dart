// material_model.dart
import 'package:collegenius/core/constants.dart';

class EeclassMaterialInfo {
  final String title;
  final String url;
  final EeclassMaterialType type;
  final String author;
  final String readCount;
  final String discussion;
  final String updateDate;

  EeclassMaterialInfo({
    required this.title,
    required this.url,
    required this.type,
    required this.author,
    required this.readCount,
    required this.discussion,
    required this.updateDate,
  });

  factory EeclassMaterialInfo.fromMap(Map<String, dynamic> map) {
    return EeclassMaterialInfo(
      title: map['title'] ?? '',
      url: map['url'] ?? '',
      type: map['type'] ?? 'unknown',
      author: map['author'] ?? '',
      readCount: map['readCount'] ?? '0',
      discussion: map['discussion'] ?? '',
      updateDate: map['updateDate'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'type': type,
      'author': author,
      'readCount': readCount,
      'discussion': discussion,
      'updateDate': updateDate,
    };
  }
}