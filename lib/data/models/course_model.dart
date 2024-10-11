import 'package:collegenius/core/constants.dart';
import 'package:collegenius/domain/entities/course.dart';

/// Represents a course with its name, classroom location, and the professor.
/// 
/// This class serves as a Data Transfer Object (DTO) for course-related 
/// data, encapsulating the essential details of a course. It includes 
/// methods for creating an empty instance and converting the DTO 
/// into a domain entity, promoting separation of concerns between 
/// data representation and business logic.
class CourseModel {
  /// The name of the course (e.g., "Physics 101").
  final String name;

  /// The classroom where the course is held (e.g., "Room A204").
  final String classroom;

  /// The professor teaching the course (e.g., "Dr. John Doe").
  final String professor;

  /// The time slot for the course, represented by a [TimeCode] value.
  final TimeCode timeCode;

  /// Constructs a [CourseModel] instance.
  ///
  /// The [name], [classroom], [professor], and [timeCode] are all required fields.
  CourseModel({
    required this.name,
    required this.classroom,
    required this.professor, 
    required this.timeCode,
  });

  /// Creates an empty instance of [CourseModel].
  /// 
  /// This factory method returns a [CourseModel] with empty strings 
  /// for all fields and a default [TimeCode], useful for initializing 
  /// forms or providing default values for optional course data.
  factory CourseModel.empty({TimeCode? timeCode}) {
    return CourseModel(
      name: '',
      classroom: '',
      professor: '',
      timeCode: timeCode ?? TimeCode.A,
    );
  }

  /// Converts this [CourseModel] to a [Course] entity.
  /// 
  /// This method maps the data contained in the [CourseModel] 
  /// to the corresponding [Course] entity in the domain layer, 
  /// facilitating the use of business logic while keeping the 
  /// data source layer separate.
  Course toEntity() {
    return Course(
      name: name,
      classroom: classroom,
      professor: professor,
      timeCode: timeCode,
    );
  }
}
