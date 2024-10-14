import 'package:collegenius/domain/entities/eeclass_assignment_info.dart';

/// Data model class for EE Class assignment information.
///
/// This model is used to map assignment data fetched from external sources
/// into a structured format, making it easy to convert to and from domain entities.
class EeclassAssignmentInfoModel {
  /// Title of the assignment.
  final String title;

  /// URL link to the assignment.
  final String url;

  /// Indicates whether the assignment is a team homework.
  final bool isTeamHomework;

  /// The start date for handing in the assignment.
  final String startHandInDate;

  /// The deadline for submitting the assignment.
  final String deadline;

  /// Indicates whether the assignment has been handed in.
  final bool isHandedOn;

  /// The score received for the assignment (if graded).
  final double score;

  /// Constructs an instance of [EeclassAssignmentInfoModel].
  EeclassAssignmentInfoModel({
    required this.title,
    required this.url,
    required this.isTeamHomework,
    required this.startHandInDate,
    required this.deadline,
    required this.isHandedOn,
    required this.score,
  });

  /// Factory constructor that creates an [EeclassAssignmentInfoModel] from a [Map].
  ///
  /// This method is used to convert raw data (e.g., JSON) into an instance
  /// of the model. It includes type checks to ensure the data is in the correct format.
  factory EeclassAssignmentInfoModel.fromMap(Map<String, dynamic> map) {
    return EeclassAssignmentInfoModel(
      title: map['title'] as String? ?? '', // Provide default value if null.
      url: map['url'] as String? ?? '',
      isTeamHomework: map['isTeamHomework'] as bool? ?? false,
      startHandInDate: map['startHandInDate'] as String? ?? '',
      deadline: map['deadline'] as String? ?? '',
      isHandedOn: map['isHandedOn'] as bool? ?? false,
      score: (map['score'] as num?)?.toDouble() ?? 0.0, // Ensure score is double.
    );
  }

  /// Converts this [EeclassAssignmentInfoModel] instance into a domain entity.
  ///
  /// This method maps the model data into the corresponding domain-level
  /// entity used throughout the application.
  EeclassAssignmentInfo toEntity() {
    return EeclassAssignmentInfo(
      title: title,
      url: url,
      isTeamHomework: isTeamHomework,
      startHandInDate: startHandInDate,
      deadline: deadline,
      isHandedOn: isHandedOn,
      score: score,
    );
  }
}
