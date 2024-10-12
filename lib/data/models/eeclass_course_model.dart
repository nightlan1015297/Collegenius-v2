import 'package:collegenius/data/models/eeclass_person_model.dart';

class EeclassCourseModel {
  final String classCode;
  final String name;
  final int credit;
  final String semester;
  final String division;
  final String classes;
  final int members;
  final List<String> instroctors;
  final List<String> assistants;
  final String description;
  final String syllabus;
  final String textbooks;
  final String gradingDescription;

  EeclassCourseModel(
      {required this.classCode,
      required this.name,
      required this.credit,
      required this.semester,
      required this.division,
      required this.classes,
      required this.members,
      required this.instroctors,
      required this.assistants,
      required this.description,
      required this.syllabus,
      required this.textbooks,
      required this.gradingDescription});

  factory EeclassCourseModel.empty() {
    return EeclassCourseModel(
      classCode: '',
      name: '',
      credit: 0,
      semester: '',
      division: '',
      classes: '',
      members: 0,
      instroctors: [],
      assistants: [],
      description: '',
      syllabus: '',
      textbooks: '',
      gradingDescription: '',
    );
  }

  factory EeclassCourseModel.fromMap(Map<String, dynamic> map) {
    return EeclassCourseModel(
      classCode: map['classCode'],
      name: map['name'],
      credit: map['credit'],
      semester: map['semester'],
      division: map['division'],
      classes: map['classes'],
      members: map['members'],
      instroctors: map['instroctors'],
      assistants: map['assistants'],
      description: map['description'],
      syllabus: map['syllabus'],
      textbooks: map['textbooks'],
      gradingDescription: map['gradingDescription'],
    );
  }


}
