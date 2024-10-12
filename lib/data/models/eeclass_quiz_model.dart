import 'package:collegenius/data/models/eeclass_file_model.dart';

class EeclassQuizModel {
  final double score;
  final bool isPaperQuiz;
  final String quizTitle;
  final String timeDuration;
  final String percentage;
  final double fullMarks;
  final double passingMarks;
  final String? timeLimit;
  final String description;
  final List<EeclassFileModel> attachments;
  final String? scoreDistributionUrl;
  final String? quizRecordUrl;
  final String? answerUrl;

  EeclassQuizModel(
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

  factory EeclassQuizModel.fromMap(Map<String, dynamic> map) {
    return EeclassQuizModel(
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
