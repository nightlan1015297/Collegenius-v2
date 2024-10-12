
import 'package:collegenius/domain/entities/eeclass_file.dart';

class EeclassQuiz {
  final double score;
  final bool isPaperQuiz;
  final String quizTitle;
  final String timeDuration;
  final String percentage;
  final double fullMarks;
  final double passingMarks;
  final String? timeLimit;
  final String description;
  final List<EeclassFile> attachments;
  final String? scoreDistributionUrl;
  final String? quizRecordUrl;
  final String? answerUrl;

  EeclassQuiz(
      {required this.score,
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
      this.answerUrl});

  factory EeclassQuiz.fromMap(Map<String, dynamic> map) {
    return EeclassQuiz(
      score: map['score'],
      isPaperQuiz: map['isPaperQuiz'],
      quizTitle: map['quizTitle'],
      timeDuration: map['timeDuration'],
      percentage: map['percentage'],
      fullMarks: map['fullMarks'],
      passingMarks: map['passingMarks'],
      timeLimit: map['timeLimit'],
      description: map['description'],
      attachments: map['attachments'],
      scoreDistributionUrl: map['scoreDistributionUrl'],
      quizRecordUrl: map['quizRecordUrl'],
      answerUrl: map['answerUrl'],
    );
  }
}
