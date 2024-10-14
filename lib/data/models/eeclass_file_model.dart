import 'package:collegenius/domain/entities/eeclass_file.dart';

/// Data model class for EE Class file details.
///
/// This model is used to represent a file from EE Class, with methods
/// to convert from raw data formats and to domain entities.
class EeclassFileModel {
  /// Name of the file.
  final String fileName;

  /// URL link to the file.
  final String url;

  /// Constructs an instance of [EeclassFileModel].
  EeclassFileModel({
    required this.fileName,
    required this.url,
  });

  /// Factory constructor that creates an [EeclassFileModel] from a [Map].
  ///
  /// This method is used to convert raw data (e.g., JSON) into an instance of the model.
  factory EeclassFileModel.fromMap(Map<String, dynamic> map) {
    return EeclassFileModel(
      fileName: map['fileName'] as String? ?? '',
      url: map['url'] as String? ?? '',
    );
  }

  /// Converts this [EeclassFileModel] into a domain entity.
  ///
  /// This method maps the data held in this model into the corresponding
  /// [EeclassFile] domain entity, used throughout the application.
  EeclassFile toEntity() {
    return EeclassFile(
      fileName: fileName,
      url: url,
    );
  }
}
