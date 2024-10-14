// material_model.dart
import 'package:collegenius/core/constants.dart';
import 'package:collegenius/domain/entities/eeclass_material_info.dart';

/// Data model class for EE Class material information.
///
/// This model represents details about a material item in EE Class,
/// with methods to convert from raw data formats and to domain entities.
class EeclassMaterialInfoModel {
  /// Title of the material.
  final String title;

  /// URL link to the material.
  final String url;

  /// Type of the material (e.g., document, video).
  final EeclassMaterialType type;

  /// Author of the material.
  final String author;

  /// Read count for the material.
  final String readCount;

  /// Discussion details related to the material.
  final String discussion;

  /// Last update date for the material.
  final String updateDate;

  /// Constructs an instance of [EeclassMaterialInfoModel].
  EeclassMaterialInfoModel({
    required this.title,
    required this.url,
    required this.type,
    required this.author,
    required this.readCount,
    required this.discussion,
    required this.updateDate,
  });

  /// Factory constructor that creates an [EeclassMaterialInfoModel] from a [Map].
  ///
  /// This method converts raw data (e.g., JSON) into an instance of the model,
  /// ensuring proper type checking and conversion.
  factory EeclassMaterialInfoModel.fromMap(Map<String, dynamic> map) {
    return EeclassMaterialInfoModel(
      title: map['title'] as String? ?? '',
      url: map['url'] as String? ?? '',
      type: map['type'] as EeclassMaterialType? ?? EeclassMaterialType.unknown,
      author: map['author'] as String? ?? '',
      readCount: map['readCount'] as String? ?? '0',
      discussion: map['discussion'] as String? ?? '',
      updateDate: map['updateDate'] as String? ?? '',
    );
  }

  /// Converts this [EeclassMaterialInfoModel] into a [Map].
  ///
  /// This method is useful for converting the model data back into a
  /// format suitable for storage or serialization.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'type': type.name, // Convert enum to a string representation.
      'author': author,
      'readCount': readCount,
      'discussion': discussion,
      'updateDate': updateDate,
    };
  }

  /// Converts this [EeclassMaterialInfoModel] into a domain entity.
  ///
  /// This method maps the data held in this model into the corresponding
  /// [EeclassMaterialInfo] domain entity, used throughout the application.
  EeclassMaterialInfo toEntity() {
    return EeclassMaterialInfo(
      title: title,
      url: url,
      type: type,
      readCount: readCount,
      discussion: discussion,
      updateDate: updateDate,
      author: author,
    );
  }
}
