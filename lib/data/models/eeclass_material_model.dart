import 'package:collegenius/core/constants.dart';
import 'package:collegenius/data/models/eeclass_file_model.dart';
import 'package:collegenius/domain/entities/eeclass_material.dart';

/// Data model class for EE Class material details.
///
/// This model represents detailed information about EE Class materials,
/// such as type, attached files, description, and source.
class EeclassMaterialModel {
  /// Type of the material (e.g., document, video).
  final EeclassMaterialType type;

  /// List of files attached to the material (optional).
  final List<EeclassFileModel>? fileLst;

  /// Description of the material (optional).
  final String? description;

  /// Source of the material (optional).
  final String? source;

  /// Constructs an instance of [EeclassMaterialModel].
  EeclassMaterialModel({
    required this.type,
    this.fileLst,
    this.description,
    this.source,
  });

  /// Converts this [EeclassMaterialModel] into a domain entity.
  ///
  /// This method maps the data held in this model into the corresponding
  /// [EeclassMaterial] domain entity, used throughout the application.
  EeclassMaterial toEntity() {
    return EeclassMaterial(
      type: type,
      fileLst: fileLst?.map((e) => e.toEntity()).toList() ?? [],
      description: description ?? '',
      source: source ?? '',
    );
  }
}
