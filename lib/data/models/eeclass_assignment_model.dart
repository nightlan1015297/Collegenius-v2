import 'package:collegenius/data/models/eeclass_file_model.dart';
import 'package:collegenius/domain/entities/eeclass_assignment.dart';

/// Data model class for EE Class assignment details.
///
/// This model represents the assignment details and provides methods
/// to convert from raw data formats such as maps and to the domain entities.
class EeclassAssignmentModel {
  /// Date when upload is allowed for the assignment.
  final String allowUploadDate;

  /// Number of people who have uploaded their work.
  final String hasUploadedPeople;

  /// The deadline for submitting the assignment.
  final String deadline;

  /// Indicates if delayed submissions are allowed.
  final bool canDelay;

  /// Grade percentage assigned to this assignment.
  final String gradePercentage;

  /// The grading method for the assignment.
  final String gradingMethod;

  /// Description of the assignment.
  final String description;

  /// List of files related to the assignment.
  final List<EeclassFileModel> fileList;

  /// Constructs an instance of [EeclassAssignmentModel].
  EeclassAssignmentModel({
    required this.allowUploadDate,
    required this.hasUploadedPeople,
    required this.deadline,
    required this.canDelay,
    required this.gradePercentage,
    required this.gradingMethod,
    required this.description,
    required this.fileList,
  });

  /// Factory constructor that creates an [EeclassAssignmentModel] from a [Map].
  ///
  /// This method converts raw data (e.g., JSON) into an instance of this model,
  /// ensuring proper type checking and conversion.
  factory EeclassAssignmentModel.fromMap(Map<String, dynamic> map) {
    return EeclassAssignmentModel(
      allowUploadDate: map['allowUploadDate'] as String? ?? '',
      hasUploadedPeople: map['hasUploadedPeople'] as String? ?? '',
      deadline: map['deadline'] as String? ?? '',
      canDelay: map['canDelay'] as bool? ?? false,
      gradePercentage: map['gradePercentage'] as String? ?? '',
      gradingMethod: map['gradingMethod'] as String? ?? '',
      description: map['description'] as String? ?? '',
      fileList: (map['fileList'] as List<EeclassFileModel>?) ?? [],
    );
  }

  /// Converts this [EeclassAssignmentModel] into a domain entity.
  ///
  /// This method maps the data held in this model into the corresponding
  /// [EeclassAssignment] domain entity, used throughout the application.
  EeclassAssignment toEntity() {
    return EeclassAssignment(
      allowUploadDate: allowUploadDate,
      hasUploadedPeople: hasUploadedPeople,
      deadline: deadline,
      canDelay: canDelay,
      gradePercentage: gradePercentage,
      gradingMethod: gradingMethod,
      description: description,
      fileList: fileList.map((file) => file.toEntity()).toList(),
    );
  }
}
