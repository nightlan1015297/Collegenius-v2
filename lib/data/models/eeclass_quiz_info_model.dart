import 'package:collegenius/domain/entities/eeclass_quiz_info.dart';

/// Data model class for EE Class quiz information.
///
/// This model represents the details about a quiz in EE Class,
/// such as its title, URL, deadline, and score.
class EeclassQuizInfoModel {
  /// Title of the quiz.
  final String title;

  /// URL link to the quiz.
  final String url;

  /// Deadline for the quiz submission.
  final String deadLine;

  /// Score received for the quiz (if graded).
  final double score;

  /// Constructs an instance of [EeclassQuizInfoModel].
  EeclassQuizInfoModel({
    required this.title,
    required this.url,
    required this.deadLine,
    required this.score,
  });

  /// Factory constructor that creates an [EeclassQuizInfoModel] from a [Map].
  ///
  /// This method is used to convert raw data (e.g., JSON) into an instance of the model,
  /// ensuring proper type checking and conversion.
  factory EeclassQuizInfoModel.fromMap(Map<String, dynamic> map) {
    return EeclassQuizInfoModel(
      title: map['title'] as String? ?? '',
      url: map['url'] as String? ?? '',
      deadLine: map['deadLine'] as String? ?? '',
      score: (map['score'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// Converts this [EeclassQuizInfoModel] into a domain entity.
  ///
  /// This method maps the data held in this model into the corresponding
  /// [EeclassQuizInfo] domain entity, used throughout the application.
  EeclassQuizInfo toEntity() {
    return EeclassQuizInfo(
      title: title,
      url: url,
      deadLine: deadLine,
      score: score,
    );
  }
}
