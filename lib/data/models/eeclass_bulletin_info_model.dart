class EeclassBulletinInfoModel {
  final String readCount;
  final String auther;
  final String date;
  final String title;
  final String url;

  EeclassBulletinInfoModel({
    required this.readCount,
    required this.auther,
    required this.date,
    required this.title,
    required this.url,
  });

  factory EeclassBulletinInfoModel.fromMap(Map<String, String?> map) {
    return EeclassBulletinInfoModel(
      readCount: map['readCount'] ?? '',
      auther: map['auther'] ?? '',
      date: map['date'] ?? '',
      title: map['title'] ?? '',
      url: map['url'] ?? '',
    );
  }
}
