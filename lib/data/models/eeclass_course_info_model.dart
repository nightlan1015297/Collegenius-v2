class EeclssCourseInfoModel {
  final String semester;
  final String courseCode;
  final String name;
  final String professor;
  final String credit;
  final String grade;
  final String classType;
  final String courseSerial;

  EeclssCourseInfoModel({
    required this.semester,
    required this.courseCode,
    required this.name,
    required this.professor,
    required this.credit,
    required this.grade,
    required this.classType,
    required this.courseSerial,
  });

  factory EeclssCourseInfoModel.fromMap(Map<String, String> map) {
    return EeclssCourseInfoModel(
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