import 'package:collegenius/domain/entities/eeclass_bulletin_info.dart';

/// Data model class for EE Class bulletin information.
///
/// This model is used to map bulletin data fetched from external sources
/// into a structured format, making it easy to convert to and from domain entities.
class EeclassBulletinInfoModel {
  /// Number of times the bulletin has been read.
  final String readCount;

  /// Author of the bulletin.
  final String author;

  /// Date when the bulletin was published.
  final String date;

  /// Title of the bulletin.
  final String title;

  /// URL link to the bulletin.
  final String url;

  /// Constructs an instance of [EeclassBulletinInfoModel].
  EeclassBulletinInfoModel({
    required this.readCount,
    required this.author,
    required this.date,
    required this.title,
    required this.url,
  });

  /// Factory constructor that creates an [EeclassBulletinInfoModel] from a [Map].
  ///
  /// This method is used to convert raw data (e.g., JSON) into an instance of the model.
  factory EeclassBulletinInfoModel.fromMap(Map<String, String?> map) {
    return EeclassBulletinInfoModel(
      readCount: map['readCount'] ?? '',
      author: map['author'] ?? '',
      date: map['date'] ?? '',
      title: map['title'] ?? '',
      url: map['url'] ?? '',
    );
  }

  /// Converts this [EeclassBulletinInfoModel] into a domain entity.
  ///
  /// This method maps the data held in this model into the corresponding
  /// [EeclassBulletinInfo] domain entity, used throughout the application.
  EeclassBulletinInfo toEntity() {
    return EeclassBulletinInfo(
      readCount: readCount,
      author: author,
      date: date,
      title: title,
      url: url,
    );
  }
}
