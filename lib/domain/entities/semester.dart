import 'package:equatable/equatable.dart';

/// Represents an academic semester.
///
/// This class holds information about a specific semester, including its
/// numeric identifier and name (e.g., "2024 Fall"). It extends [Equatable]
/// to allow for value comparison, making it easier to work with in lists
/// or other collections that require equality checks.
class Semester extends Equatable {
  /// The numeric identifier for the semester (e.g., 1 for Spring, 2 for Fall).
  final int semester;

  /// The name of the semester (e.g., "2024 Spring", "2024 Fall").
  final String semesterName;

  /// Constructs a [Semester] instance with the given [semester] and [semesterName].
  const Semester({required this.semester, required this.semesterName});

  @override
  List<Object?> get props => [semester];
}
