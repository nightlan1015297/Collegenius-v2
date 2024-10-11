import 'package:collegenius/core/constants.dart';
import 'package:collegenius/domain/entities/course.dart';

/// Represents a daily course schedule.
///
/// The [DailyCourse] class manages a schedule of courses for a single day,
/// allowing for adding and removing courses at specific time slots.
class DailyCourse {
  /// A map that associates [TimeCode] with corresponding [Course].
  Map<TimeCode, Course> schedule;

  WeekDay day;
  /// Constructs a [DailyCourse] instance with the provided [schedule].
  ///
  /// The [schedule] parameter is required and defines the initial courses 
  /// for the day.
  DailyCourse({
    required this.schedule,
    required this.day,
  });

  /// Adds a course to the schedule at the specified [code].
  ///
  /// The [code] parameter represents the time slot, and the [course] 
  /// parameter is the [Course] instance to be added to the schedule.
  void addCourse({required TimeCode code, required Course course}) {
    schedule[code] = course;
  }

  /// Removes the course scheduled at the specified [code].
  ///
  /// The [code] parameter identifies the time slot from which the course 
  /// should be removed. It sets the corresponding entry in the schedule 
  /// to an empty course instance.
  void removeCourse({required TimeCode code}) {
    schedule[code] = Course.empty();
  }

  /// Checks if the daily course schedule is empty.
  ///
  /// Returns `true` if all time slots in the schedule are empty 
  /// (i.e., contain an empty course), otherwise returns `false`.
  bool get isEmpty {
    return schedule.values.every((element) => element == Course.empty());
  }

  /// Checks if the daily course schedule is not empty.
  ///
  /// Returns `true` if at least one time slot in the schedule has a 
  /// course, otherwise returns `false`.
  bool get isNotEmpty {
    return !isEmpty;
  }
}
