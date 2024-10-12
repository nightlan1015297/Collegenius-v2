
///  class representing a semester.
/// 
/// This class encapsulates the details of a semester, including its 
/// year and name. It provides methods to create a Semester from 
/// a string representation and convert it to a corresponding Semester entity.
class EeclassSemester {
  final String id; // The year of the semester.
  final String semesterName; // The name of the semester (e.g., "1101, 1102...etc").

  /// Constructor for initializing Semester with a year and name.
  EeclassSemester({required this.id, required this.semesterName});

  bool get isEmpty => id.isEmpty && semesterName.isEmpty;

  factory EeclassSemester.empty() {
    return EeclassSemester(id: '', semesterName: '');
  }
}
