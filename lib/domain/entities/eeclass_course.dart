class EeclassCourse {
  final String classCode;
  final String name;
  final int credit;
  final String semester;
  final String division;
  final String classes;
  final int members;
  final List<String> instructors;
  final List<String> assistants;
  final String description;
  final String syllabus;
  final String textbooks;
  final String gradingDescription;

  EeclassCourse(
      {required this.classCode,
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
      required this.gradingDescription});

  factory EeclassCourse.empty() {
    return EeclassCourse(
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

  factory EeclassCourse.fromMap(Map<String, dynamic> map) {
    return EeclassCourse(
      classCode: map['classCode'],
      name: map['name'],
      credit: map['credit'],
      semester: map['semester'],
      division: map['division'],
      classes: map['classes'],
      members: map['members'],
      instructors: map['instructors'],
      assistants: map['assistants'],
      description: map['description'],
      syllabus: map['syllabus'],
      textbooks: map['textbooks'],
      gradingDescription: map['gradingDescription'],
    );
  }


}
