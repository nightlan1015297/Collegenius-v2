import 'package:collegenius/domain/entities/semester.dart';

/// Model class representing a semester.
/// 
/// This class encapsulates the details of a semester, including its 
/// year and name. It provides methods to create a SemesterModel from 
/// a string representation and convert it to a corresponding Semester entity.
class SemesterModel {
  int id; // The year of the semester.
  String semesterName; // The name of the semester (e.g., "2023 Fall").

  /// Constructor for initializing SemesterModel with a year and name.
  SemesterModel({required this.id, required this.semesterName});

  /// Factory method to create a SemesterModel from a string representation.
  /// 
  /// The input string is expected to have four characters: the first 
  /// three represent the year, and the last one indicates the semester 
  /// (1 for Fall, 2 for Spring).
  factory SemesterModel.fromString({required String str}) {
    int id = int.parse(str);     // Extracting the year from the string.
    // Semester string has four numbers:
    // The first three numbers are the year and the last number indicates Spring or Fall.
    int year = int.parse(str.substring(0, 3));     // Extracting the year from the string.
    int semester = int.parse(str.substring(3, 4)); // Extracting the semester indicator.
    
    // Determining the semester name based on the semester indicator.
    String temp = semester == 1 ? 'Fall' : 'Spring'; 
    String semesterName = '$year $temp'; // Forming the complete semester name.
    
    // Returning a new instance of SemesterModel.
    return SemesterModel(id: id, semesterName: semesterName);
  }

  /// Converts the SemesterModel to a corresponding Semester entity.
  /// 
  /// This method allows for the transformation of the model into an 
  /// entity format, making it suitable for further processing or storage.
  Semester toEntity() {
    return Semester(
      id: id,
      semesterName: semesterName,
    );
  }
}
