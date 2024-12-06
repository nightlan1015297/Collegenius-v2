import 'package:collegenius/domain/entities/eeclass_course.dart';
import 'package:collegenius/domain/entities/eeclass_course_info.dart';

class EeclassCombinedCourse {
  final String semester;
  final String courseCode;
  final String name;
  final String professor;
  final String credit;
  final String grade;
  final String classType;
  final String courseSerial;
  final String classCode;
  final String division;
  final String classes;
  final int members;
  final List<String> instructors;
  final List<String> assistants;
  final String description;
  final String syllabus;
  final String textbooks;
  final String gradingDescription;

  EeclassCombinedCourse({
    required this.semester,
    required this.courseCode,
    required this.name,
    required this.professor,
    required this.credit,
    required this.grade,
    required this.classType,
    required this.courseSerial,
    required this.classCode,
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

  factory EeclassCombinedCourse.fromMultipleEntities({
    required EeclassCourse course,
    required EeclassCourseInfo courseInfo,
  }) {
    return EeclassCombinedCourse(
      semester: course.semester,
      courseCode: courseInfo.courseCode,
      name: course.name,
      professor: courseInfo.professor,
      credit: courseInfo.credit,
      grade: courseInfo.grade,
      classType: courseInfo.classType,
      courseSerial: courseInfo.courseSerial,
      classCode: course.classCode,
      division: course.division,
      classes: course.classes,
      members: course.members,
      instructors: course.instructors,
      assistants: course.assistants,
      description: course.description,
      syllabus: course.syllabus,
      textbooks: course.textbooks,
      gradingDescription: course.gradingDescription,
    );
  }
}
