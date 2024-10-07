import 'package:collegenius/data/models/course_model.dart';
import 'package:collegenius/data/models/daily_course_model.dart';
import 'package:collegenius/domain/entities/course_schedule.dart';

/// Enumeration representing the days of the week.
enum WeekDay { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

/// Mapping from integer indices to corresponding weekdays.
Map<int, WeekDay> mapIndexToWeekDay = {
  1: WeekDay.monday,
  2: WeekDay.tuesday,
  3: WeekDay.wednesday,
  4: WeekDay.thursday,
  5: WeekDay.friday,
  6: WeekDay.saturday,
  7: WeekDay.sunday,
};

/// Mapping from weekdays to corresponding integer indices.
Map<WeekDay, int> mapWeekDaytoIndex = {
  WeekDay.monday: 1,
  WeekDay.tuesday: 2,
  WeekDay.wednesday: 3,
  WeekDay.thursday: 4,
  WeekDay.friday: 5,
  WeekDay.saturday: 6,
  WeekDay.sunday: 7,
};

/// Model representing the course schedule for a week.
class CourseScheduleModel {
  
  /// A mapping of weekdays to daily course schedules.
  Map<WeekDay, DailyCourseModel> schedule;

  /// Constructs a [CourseScheduleModel] instance with a given schedule.
  CourseScheduleModel({required this.schedule}); 

  /// Creates an empty [CourseScheduleModel] instance.
  factory CourseScheduleModel.empty() {
    return CourseScheduleModel(schedule: {
      WeekDay.monday: DailyCourseModel.empty(), 
      WeekDay.tuesday: DailyCourseModel.empty(),
      WeekDay.wednesday: DailyCourseModel.empty(),
      WeekDay.thursday: DailyCourseModel.empty(),
      WeekDay.friday: DailyCourseModel.empty(),
      WeekDay.saturday: DailyCourseModel.empty(),
      WeekDay.sunday: DailyCourseModel.empty(),
    });
  }

  /// Adds a course to the specified day and time code.
  /// 
  /// This method updates the daily course schedule for the given [day]
  /// by adding the provided [course] at the specified [code].
  void addCourse({
    required WeekDay day, 
    required TimeCode code, 
    required CourseModel course
  }) {
    schedule[day]!.addCourse(code: code, course: course);
  }

  /// Converts the [CourseScheduleModel] to a [CourseSchedule] entity.
  /// 
  /// This method maps each daily course model to its corresponding entity 
  /// representation, allowing for integration with the rest of the domain logic.
  CourseSchedule toEntity() {
    return CourseSchedule(
      schedule: schedule.map((key, value) => MapEntry(key, value.toEntity()))
    );
  }
}
