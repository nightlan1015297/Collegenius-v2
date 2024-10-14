import 'package:collegenius/data/models/eeclass_file_model.dart';
import 'package:collegenius/domain/entities/eeclass_quiz.dart';

/// Data model class for EE Class quiz details.
///
/// This model is used to represent detailed information about a quiz,
/// and provides methods to convert from raw data formats and to domain entities.
class EeclassQuizModel {
  /// Score obtained in the quiz.
  final double score;

  /// Indicates if the quiz is a paper-based quiz.
  final bool isPaperQuiz;

  /// Title of the quiz.
  final String quizTitle;

  /// Time duration for the quiz.
  final String timeDuration;

  /// Percentage weight of the quiz in the course.
  final String percentage;

  /// Full marks available for the quiz.
  final double fullMarks;

  /// Passing marks for the quiz.
  final double passingMarks;

  /// Time limit for the quiz (optional).
  final String? timeLimit;

  /// Description of the quiz.
  final String description;

  /// List of files attached to the quiz.
  final List<EeclassFileModel> attachments;

  /// URL for score distribution details (optional).
  final String? scoreDistributionUrl;

  /// URL for the quiz record (optional).
  final String? quizRecordUrl;

  /// URL for the answer details (optional).
  final String? answerUrl;

  /// Constructs an instance of [EeclassQuizModel].
  EeclassQuizModel({
    required this.score,
    required this.isPaperQuiz,
    required this.quizTitle,
    required this.timeDuration,
    required this.percentage,
    required this.fullMarks,
    required this.passingMarks,
    this.timeLimit,
    required this.description,
    required this.attachments,
    this.scoreDistributionUrl,
    this.quizRecordUrl,
    this.answerUrl,
  });

  /// Factory constructor that creates an [EeclassQuizModel] from a [Map].
  ///
  /// This method converts raw data (e.g., JSON) into an instance of the model,
  /// ensuring proper type checking and conversion.
  factory EeclassQuizModel.fromMap(Map<String, dynamic> map) {
    return EeclassQuizModel(
      score: (map['score'] as num?)?.toDouble() ?? 0.0,
      isPaperQuiz: map['isPaperQuiz'] as bool? ?? false,
      quizTitle: map['quizTitle'] as String? ?? '',
      timeDuration: map['timeDuration'] as String? ?? '',
      percentage: map['percentage'] as String? ?? '',
      fullMarks: (map['fullMarks'] as num?)?.toDouble() ?? 0.0,
      passingMarks: (map['passingMarks'] as num?)?.toDouble() ?? 0.0,
      timeLimit: map['timeLimit'] as String?,
      description: map['description'] as String? ?? '',
      attachments: (map['attachments'] as List<EeclassFileModel>?) ?? [],
      scoreDistributionUrl: map['scoreDistributionUrl'] as String?,
      quizRecordUrl: map['quizRecordUrl'] as String?,
      answerUrl: map['answerUrl'] as String?,
    );
  }

  /// Converts this [EeclassQuizModel] into a domain entity.
  ///
  /// This method maps the data held in this model into the corresponding
  /// [EeclassQuiz] domain entity, used throughout the application.
  EeclassQuiz toEntity() {
    return EeclassQuiz(
      score: score,
      isPaperQuiz: isPaperQuiz,
      quizTitle: quizTitle,
      timeDuration: timeDuration,
      percentage: percentage,
      fullMarks: fullMarks,
      passingMarks: passingMarks,
      timeLimit: timeLimit,
      description: description,
      attachments: attachments.map((e) => e.toEntity()).toList(),
      scoreDistributionUrl: scoreDistributionUrl,
      quizRecordUrl: quizRecordUrl,
      answerUrl: answerUrl,
    );
  }
}
