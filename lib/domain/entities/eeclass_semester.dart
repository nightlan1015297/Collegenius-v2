
import 'package:equatable/equatable.dart';

///  class representing a semester.
/// 
/// This class encapsulates the details of a semester, including its 
/// year and name. It provides methods to create a Semester from 
/// a string representation and convert it to a corresponding Semester entity.
class EeclassSemester extends Equatable {
  final String id; // The year of the semester.
  final String semesterName; // The name of the semester (e.g., "1101, 1102...etc").

  /// Constructor for initializing Semester with a year and name.
  const EeclassSemester({required this.id, required this.semesterName});

  bool get isEmpty => id.isEmpty && semesterName.isEmpty;

  factory EeclassSemester.empty() {
    return const EeclassSemester(id: '', semesterName: '');
  }

  @override
  List<Object?> get props => [id, semesterName];
}
