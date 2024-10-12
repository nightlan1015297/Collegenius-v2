class EeclassQuizInfo {
  final String title;
  final String url;
  final String deadLine;
  final double score;

  EeclassQuizInfo(
      {required this.title,
      required this.url,
      required this.deadLine,
      required this.score,});
  factory EeclassQuizInfo.fromMap(Map<String, dynamic> map) {
    return EeclassQuizInfo(
      title: map['title'],
      url: map['url'],
      deadLine: map['deadLine'],
      score: map['score'],
    );
  }
}
