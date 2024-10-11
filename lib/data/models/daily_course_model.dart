import 'package:collegenius/core/constants.dart';
import 'package:collegenius/data/models/course_model.dart';
import 'package:collegenius/domain/entities/daily_course.dart';

/// Model class representing the daily course schedule.
/// 
/// This class manages the daily courses by storing them in a schedule 
/// that maps each time slot ([TimeCode]) to a corresponding [CourseModel].
/// It provides methods for adding courses, initializing an empty schedule,
/// and converting the model to a domain entity for business logic usage.
class DailyCourseModel {
  /// Map that holds the course schedule for different time slots.
  ///
  /// This map uses [TimeCode] as keys and associates each time slot with 
  /// a [CourseModel], representing the course assigned at that time.
  Map<TimeCode, CourseModel> schedule;

  /// The day of the week for which this course schedule is applicable.
  ///
  /// This indicates which [WeekDay] the schedule is representing (e.g., Monday).
  final WeekDay day;

  /// Constructor for initializing [DailyCourseModel] with a given schedule.
  ///
  /// Requires a [day] to indicate which day of the week is being represented,
  /// and a [schedule] that contains the mapping of time slots to courses.
  DailyCourseModel({
    required this.day,
    required this.schedule,
  });

  /// Method to add a course to a specific time slot in the schedule.
  /// 
  /// This method takes a [TimeCode] and a [CourseModel] as parameters, 
  /// adding or updating the course in the schedule for the specified time slot.
  /// It facilitates managing the schedule dynamically, allowing courses to be 
  /// updated or newly assigned to a time slot.
  ///
  /// Parameters:
  /// - [code]: The [TimeCode] representing the time slot for the course.
  /// - [course]: The [CourseModel] instance representing the course to be added.
  void addCourse({required TimeCode code, required CourseModel course}) {
    schedule[code] = course; // Add or update the course for the given time code.
  }
  
  /// Factory method to create an empty [DailyCourseModel].
  /// 
  /// This method initializes a [DailyCourseModel] with all time slots set to 
  /// empty [CourseModel] instances, effectively providing a blank schedule 
  /// for a particular day of the week. It is useful for initializing the schedule
  /// with no pre-assigned courses.
  ///
  /// Parameters:
  /// - [day]: The [WeekDay] that the schedule will represent.
  factory DailyCourseModel.empty({required WeekDay day}) {
    return DailyCourseModel(schedule: {
      TimeCode.one: CourseModel.empty(timeCode: TimeCode.one),
      TimeCode.two: CourseModel.empty(timeCode: TimeCode.two),
      TimeCode.three: CourseModel.empty(timeCode: TimeCode.three),
      TimeCode.four: CourseModel.empty(timeCode: TimeCode.four),
      TimeCode.Z: CourseModel.empty(timeCode: TimeCode.Z),
      TimeCode.five: CourseModel.empty(timeCode: TimeCode.five),
      TimeCode.six: CourseModel.empty(timeCode: TimeCode.six),
      TimeCode.seven: CourseModel.empty(timeCode: TimeCode.seven),
      TimeCode.eight: CourseModel.empty(timeCode: TimeCode.eight),
      TimeCode.nine: CourseModel.empty(timeCode: TimeCode.nine),
      TimeCode.A: CourseModel.empty(timeCode: TimeCode.A),
      TimeCode.B: CourseModel.empty(timeCode: TimeCode.B),
      TimeCode.C: CourseModel.empty(timeCode: TimeCode.C),
      TimeCode.D: CourseModel.empty(timeCode: TimeCode.D),
      TimeCode.E: CourseModel.empty(timeCode: TimeCode.E),
      TimeCode.F: CourseModel.empty(timeCode: TimeCode.F),
    }, day: day);
  }

  /// Method to convert [DailyCourseModel] to a corresponding [DailyCourse] entity.
  /// 
  /// This method maps the schedule from [DailyCourseModel] to the 
  /// corresponding [DailyCourse] entity, allowing for easy conversion 
  /// between the model and entity representations. This is especially useful 
  /// for transferring data to the domain layer where business logic is applied.
  DailyCourse toEntity() {
    return DailyCourse(
      day: day,
      schedule: schedule.map((key, value) => MapEntry(key, value.toEntity())),
    );
  }
}