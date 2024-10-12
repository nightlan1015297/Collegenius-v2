
/// Model class representing a semester.
/// 
/// This class encapsulates the details of a semester, including its 
/// year and name. It provides methods to create a SemesterModel from 
/// a string representation and convert it to a corresponding Semester entity.
class EeclassSemesterModel {
  final String id; // The year of the semester.
  final String semesterName; // The name of the semester (e.g., "1101, 1102...etc").

  /// Constructor for initializing SemesterModel with a year and name.
  EeclassSemesterModel({required this.id, required this.semesterName});

  bool get isEmpty => id.isEmpty && semesterName.isEmpty;

  factory EeclassSemesterModel.empty() {
    return EeclassSemesterModel(id: '', semesterName: '');
  }
}
