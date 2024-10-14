class EeclassCourseInfo {
  final String semester;
  final String courseCode;
  final String name;
  final String professor;
  final String credit;
  final String grade;
  final String classType;
  final String courseSerial;

  EeclassCourseInfo({
    required this.semester,
    required this.courseCode,
    required this.name,
    required this.professor,
    required this.credit,
    required this.grade,
    required this.classType,
    required this.courseSerial,
  });

  factory EeclassCourseInfo.fromMap(Map<String, String> map) {
    return EeclassCourseInfo(
      semester: map['semester']!,
      courseCode: map['courseCode']!,
      name: map['name']!,
      professor: map['professor']!,
      credit: map['credit']!,
      grade: map['grade']!,
      classType: map['classType']!,
      courseSerial: map['courseSerial']!,
    );
  }
}