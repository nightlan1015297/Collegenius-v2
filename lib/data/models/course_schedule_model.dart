import 'package:collegenius/data/models/course_model.dart';
import 'package:collegenius/core/constants.dart';
import 'package:collegenius/data/models/daily_course_model.dart';
import 'package:collegenius/domain/entities/course_schedule.dart';

/// Model representing the course schedule for a week.
/// 
/// This model encapsulates a weekly course schedule, with each day represented
/// by a [DailyCourseModel]. It provides methods to create an empty schedule,
/// add courses to specific days, and convert to a domain entity for integration
/// with the rest of the application's business logic.
class CourseScheduleModel {
  /// A mapping of weekdays to daily course schedules.
  ///
  /// Each entry in the map represents a [WeekDay] and its corresponding
  /// [DailyCourseModel], which contains the detailed schedule for that day.
  Map<WeekDay, DailyCourseModel> schedule;

  /// Constructs a [CourseScheduleModel] instance with a given schedule.
  ///
  /// The [schedule] is required and represents the mapping of each weekday
  /// to its respective daily course schedule.
  CourseScheduleModel({required this.schedule});

  /// Creates an empty [CourseScheduleModel] instance.
  ///
  /// This factory method initializes the schedule with empty daily course models
  /// for each day of the week, providing a clean state for adding courses.
  factory CourseScheduleModel.empty() {
    return CourseScheduleModel(schedule: {
      WeekDay.monday: DailyCourseModel.empty(day: WeekDay.monday),
      WeekDay.tuesday: DailyCourseModel.empty(day: WeekDay.tuesday),
      WeekDay.wednesday: DailyCourseModel.empty(day: WeekDay.wednesday),
      WeekDay.thursday: DailyCourseModel.empty(day: WeekDay.thursday),
      WeekDay.friday: DailyCourseModel.empty(day: WeekDay.friday),
      WeekDay.saturday: DailyCourseModel.empty(day: WeekDay.saturday),
      WeekDay.sunday: DailyCourseModel.empty(day: WeekDay.sunday),
    });
  }

  /// Adds a course to the specified day and time code.
  ///
  /// This method updates the daily course schedule for the given [day]
  /// by adding the provided [course] at the specified [code]. If the time
  /// slot is already occupied, it may be overwritten by the new [course].
  /// 
  /// Parameters:
  /// - [day]: The day of the week to which the course should be added.
  /// - [code]: The time code specifying the time slot for the course.
  /// - [course]: The [CourseModel] instance representing the course to be added.
  void addCourse(
      {required WeekDay day,
      required TimeCode code,
      required CourseModel course}) {
    schedule[day]!.addCourse(code: code, course: course);
  }

  /// Converts the [CourseScheduleModel] to a [CourseSchedule] entity.
  ///
  /// This method maps each daily course model to its corresponding entity
  /// representation, allowing for integration with the rest of the domain logic.
  /// This promotes separation between data and business logic layers.
  CourseSchedule toEntity() {
    return CourseSchedule(
        schedule:
            schedule.map((key, value) => MapEntry(key, value.toEntity())));
  }
}
