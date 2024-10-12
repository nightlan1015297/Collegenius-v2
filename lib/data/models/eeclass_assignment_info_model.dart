class EeclassAssignmentInfoModel {
  final String title;
  final String url;
  final bool isTeamHomework;
  final String startHandInDate;
  final String deadline;
  final bool isHandedOn;
  final double score;

  EeclassAssignmentInfoModel({
    required this.title,
    required this.url,
    required this.isTeamHomework,
    required this.startHandInDate,
    required this.deadline,
    required this.isHandedOn,
    required this.score,
  });

  factory EeclassAssignmentInfoModel.fromMap(Map<String, dynamic> map) {
    return EeclassAssignmentInfoModel(
      title: map['title'],
      url: map['url'],
      isTeamHomework: map['isTeamHomework'],
      startHandInDate: map['startHandInDate'],
      deadline: map['deadline'],
      isHandedOn: map['isHandedOn'],
      score: map['score'],
    );
  }
}
