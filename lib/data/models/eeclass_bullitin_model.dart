import 'package:collegenius/data/models/eeclass_file_model.dart';
import 'package:collegenius/domain/entities/eeclass_bullitin.dart';

/// Data model for EE Class bulletin details.
///
/// This model represents a bulletin, containing the main content and
/// any attached files, and provides methods for conversion to/from domain entities.
class EeclassBulletinModel {
  /// The main content of the bulletin.
  final String content;

  /// List of files attached to the bulletin.
  final List<EeclassFileModel> files;

  /// Constructs an instance of [EeclassBulletinModel].
  EeclassBulletinModel({
    required this.content,
    required this.files,
  });

  /// Factory constructor that creates an [EeclassBulletinModel] from a [Map].
  ///
  /// This method converts raw data (e.g., JSON) into an instance of this model.
  factory EeclassBulletinModel.fromMap(Map<String, dynamic> map) {
    return EeclassBulletinModel(
      content: map['content'] as String? ?? '',
      files: (map['files'] as List<EeclassFileModel>?) ?? [],
    );
  }

  /// Converts this [EeclassBulletinModel] into a domain entity.
  ///
  /// This method maps the data held in this model into the corresponding
  /// [EeclassBulletin] domain entity, used throughout the application.
  EeclassBulletin toEntity() {
    return EeclassBulletin(
      content: content,
      files: files.map((file) => file.toEntity()).toList(),
    );
  }
}
