import 'package:collegenius/data/models/semester_model.dart';
import 'package:equatable/equatable.dart';

/// Represents an academic semester.
///
/// This class holds information about a specific semester, including its
/// numeric identifier and name (e.g., "2024 Fall"). It extends [Equatable]
/// to allow for value comparison, making it easier to work with in lists
/// or other collections that require equality checks.
class Semester extends Equatable {
  /// The numeric identifier for the semester.
  final int id;

  /// The name of the semester (e.g., "2024 Spring", "2024 Fall").
  final String semesterName;

  /// Constructs a [Semester] instance with the given [semester] and [semesterName].
  const Semester({required this.id, required this.semesterName});

  SemesterModel toModel() {
    return SemesterModel(id: id, semesterName: semesterName);
  }
  
  @override
  List<Object?> get props => [id];
}
