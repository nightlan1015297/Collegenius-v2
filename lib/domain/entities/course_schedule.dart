import 'package:collegenius/data/models/course_schedule_model.dart';
import 'package:collegenius/data/models/daily_course_model.dart';
import 'package:collegenius/domain/entities/course.dart';
import 'package:collegenius/domain/entities/daily_course.dart';

/// Represents the course schedule for a week, categorized by weekdays.
class CourseSchedule {
  final Map<WeekDay, DailyCourse> schedule;

  CourseSchedule({required this.schedule});

  /// Checks if the schedule is empty (i.e., all daily courses are empty).
  bool get isEmpty {
    return schedule.values.every((dailyCourse) => dailyCourse.isEmpty);
  }

  /// Adds a course to the specified weekday.
  void addCourse(WeekDay weekDay, TimeCode timeCode ,Course course) {
    if (schedule.containsKey(weekDay)) {
      schedule[weekDay]!.addCourse(code:timeCode,course: course);
    } else {
      // Handle the case where the weekday is not found (optional)
      throw Exception("Invalid weekday: $weekDay");
    }
  }

  /// Gets courses for a specific weekday.
  DailyCourse getCoursesForDay(WeekDay weekDay) {
    return schedule[weekDay]!; 
  }

  @override
  String toString() {
    String result = '';
    for (var timeCode in TimeCode.values) {
      /// add spaces to make each time code same length
      /// for better alignment
      result += '|${timeCode.toString().padRight(15)}|';
      schedule.forEach((weekDay, dailyCourse) {
        result += '| ${dailyCourse.schedule[timeCode]!.name} |';
      });
      result += '\n';
    }
    return result;
  }
}
