import 'package:collegenius/domain/entities/eeclass_course.dart';

/// Data model class for EE Class course details.
///
/// This model is used to represent detailed information about a course,
/// and provides methods to convert from raw data formats and to domain entities.
class EeclassCourseModel {
  /// Code for the course.
  final String classCode;

  /// Name of the course.
  final String name;

  /// Number of credits for the course.
  final int credit;

  /// Semester during which the course is offered.
  final String semester;

  /// Division (e.g., department) that offers the course.
  final String division;

  /// Class information.
  final String classes;

  /// Number of members enrolled in the course.
  final int members;

  /// List of instructors for the course.
  final List<String> instructors;

  /// List of assistants for the course.
  final List<String> assistants;

  /// Course description.
  final String description;

  /// Syllabus details for the course.
  final String syllabus;

  /// Textbooks used in the course.
  final String textbooks;

  /// Description of the grading criteria for the course.
  final String gradingDescription;

  /// Constructs an instance of [EeclassCourseModel].
  EeclassCourseModel({
    required this.classCode,
    required this.name,
    required this.credit,
    required this.semester,
    required this.division,
    required this.classes,
    required this.members,
    required this.instructors,
    required this.assistants,
    required this.description,
    required this.syllabus,
    required this.textbooks,
    required this.gradingDescription,
  });

  /// Factory constructor that creates an empty [EeclassCourseModel].
  ///
  /// Useful for initializing empty forms or placeholders.
  factory EeclassCourseModel.empty() {
    return EeclassCourseModel(
      classCode: '',
      name: '',
      credit: 0,
      semester: '',
      division: '',
      classes: '',
      members: 0,
      instructors: [],
      assistants: [],
      description: '',
      syllabus: '',
      textbooks: '',
      gradingDescription: '',
    );
  }

  /// Factory constructor that creates an [EeclassCourseModel] from a [Map].
  ///
  /// This method converts raw data (e.g., JSON) into an instance of the model,
  /// ensuring proper type checking and conversion.
  factory EeclassCourseModel.fromMap(Map<String, dynamic> map) {
    return EeclassCourseModel(
      classCode: map['classCode'] as String? ?? '',
      name: map['name'] as String? ?? '',
      credit: map['credit'] as int? ?? 0,
      semester: map['semester'] as String? ?? '',
      division: map['division'] as String? ?? '',
      classes: map['classes'] as String? ?? '',
      members: map['members'] as int? ?? 0,
      instructors: (map['instructors'] as List<dynamic>?)
              ?.map((instructor) => instructor as String)
              .toList() ??
          [],
      assistants: (map['assistants'] as List<dynamic>?)
              ?.map((assistant) => assistant as String)
              .toList() ??
          [],
      description: map['description'] as String? ?? '',
      syllabus: map['syllabus'] as String? ?? '',
      textbooks: map['textbooks'] as String? ?? '',
      gradingDescription: map['gradingDescription'] as String? ?? '',
    );
  }

  /// Converts this [EeclassCourseModel] into a domain entity.
  ///
  /// This method maps the data held in this model into the corresponding
  /// [EeclassCourse] domain entity, used throughout the application.
  EeclassCourse toEntity() {
    return EeclassCourse(
      classCode: classCode,
      name: name,
      credit: credit,
      semester: semester,
      division: division,
      classes: classes,
      members: members,
      instructors: instructors,
      assistants: assistants,
      description: description,
      syllabus: syllabus,
      textbooks: textbooks,
      gradingDescription: gradingDescription,
    );
  }
}
