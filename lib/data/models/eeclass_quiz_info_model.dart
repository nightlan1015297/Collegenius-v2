class EeclassQuizInfoModel {
  final String title;
  final String url;
  final String deadLine;
  final double score;

  EeclassQuizInfoModel(
      {required this.title,
      required this.url,
      required this.deadLine,
      required this.score,});
  factory EeclassQuizInfoModel.fromMap(Map<String, dynamic> map) {
    return EeclassQuizInfoModel(
      title: map['title'],
      url: map['url'],
      deadLine: map['deadLine'],
      score: map['score'],
    );
  }
}
