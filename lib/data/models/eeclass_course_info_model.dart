import 'package:collegenius/domain/entities/eeclass_course_info.dart';

/// Data model for EE Class course information.
///
/// This model is used to map course data fetched from external sources
/// into a structured format, making it easy to convert to and from domain entities.
class EeclassCourseInfoModel {
  /// Semester during which the course is offered.
  final String semester;

  /// Code representing the course.
  final String courseCode;

  /// Name of the course.
  final String name;

  /// Name of the professor teaching the course.
  final String professor;

  /// Number of credits for the course.
  final String credit;

  /// Grade level targeted by the course.
  final String grade;

  /// Type of class (e.g., lecture, lab).
  final String classType;

  /// Unique identifier for the course.
  final String courseSerial;

  /// Constructs an instance of [EeclassCourseInfoModel].
  EeclassCourseInfoModel({
    required this.semester,
    required this.courseCode,
    required this.name,
    required this.professor,
    required this.credit,
    required this.grade,
    required this.classType,
    required this.courseSerial,
  });

  /// Factory constructor that creates an [EeclassCourseInfoModel] from a [Map].
  ///
  /// This method is used to convert raw data (e.g., JSON) into an instance of the model.
  factory EeclassCourseInfoModel.fromMap(Map<String, String?> map) {
    return EeclassCourseInfoModel(
      semester: map['semester'] ?? '',
      courseCode: map['courseCode'] ?? '',
      name: map['name'] ?? '',
      professor: map['professor'] ?? '',
      credit: map['credit'] ?? '',
      grade: map['grade'] ?? '',
      classType: map['classType'] ?? '',
      courseSerial: map['courseSerial'] ?? '',
    );
  }

  /// Converts this [EeclassCourseInfoModel] into a domain entity.
  ///
  /// This method maps the data held in this model into the corresponding
  /// [EeclassCourseInfo] domain entity, used throughout the application.
  EeclassCourseInfo toEntity() {
    return EeclassCourseInfo(
      semester: semester,
      courseCode: courseCode,
      name: name,
      professor: professor,
      credit: credit,
      grade: grade,
      classType: classType,
      courseSerial: courseSerial,
    );
  }
}
