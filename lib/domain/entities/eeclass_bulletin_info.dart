class EeclassBulletinInfo {
  final String readCount;
  final String auther;
  final String date;
  final String title;
  final String url;

  EeclassBulletinInfo({
    required this.readCount,
    required this.auther,
    required this.date,
    required this.title,
    required this.url,
  });

  factory EeclassBulletinInfo.fromMap(Map<String, String?> map) {
    return EeclassBulletinInfo(
      readCount: map['readCount'] ?? '',
      auther: map['auther'] ?? '',
      date: map['date'] ?? '',
      title: map['title'] ?? '',
      url: map['url'] ?? '',
    );
  }
}
