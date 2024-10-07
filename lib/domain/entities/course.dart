import 'package:equatable/equatable.dart';

/// Represents a course with its details including name, classroom, and professor.
class Course extends Equatable {
  final String name;
  final String classroom;
  final String professor;

  const Course({
    required this.name,
    required this.classroom,
    required this.professor,
  });

  /// Factory constructor for creating an empty course instance.
  factory Course.empty() {
    return const Course(
      name: '',
      classroom: '',
      professor: '',
    );
  }

  /// Checks if the course is empty.
  bool get isEmpty => name.isEmpty && classroom.isEmpty && professor.isEmpty;

  @override
  List<Object?> get props => [name, classroom, professor];

  /// Returns a string representation of the course.
  @override
  String toString() {
    return 'Course{name: $name, classroom: $classroom, professor: $professor}';
  }
}
