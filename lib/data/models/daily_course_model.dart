import 'package:collegenius/data/models/course_model.dart';
import 'package:collegenius/domain/entities/daily_course.dart';

/// Enum representing different time slots for courses.
/// 
/// This enumeration defines various time codes used to identify specific 
/// time slots in a daily course schedule.
enum TimeCode {
  one,
  two,
  three,
  four,
  Z,
  five,
  six,
  seven,
  eight,
  nine,
  A,
  B,
  C,
  D,
  E,
  F,
}

/// Mapping of integer indices to corresponding TimeCode values.
/// 
/// This map is used to convert integer indices (e.g., from database or API) 
/// into the respective TimeCode for easier management of course schedules.
Map<int, TimeCode> mapIndexToTimeCode = {
  1: TimeCode.one,
  2: TimeCode.two,
  3: TimeCode.three,
  4: TimeCode.four,
  5: TimeCode.Z,
  6: TimeCode.five,
  7: TimeCode.six,
  8: TimeCode.seven,
  9: TimeCode.eight,
  10: TimeCode.nine,
  11: TimeCode.A,
  12: TimeCode.B,
  13: TimeCode.C,
  14: TimeCode.D,
  15: TimeCode.E,
  16: TimeCode.F,
};

/// Mapping of TimeCode values to corresponding integer indices.
/// 
/// This map serves as a reverse lookup for converting TimeCode values back 
/// into their respective integer indices for data processing or storage.
Map<TimeCode, int> mapTimeCodetoIndex = {
  TimeCode.one: 1,
  TimeCode.two: 2,
  TimeCode.three: 3,
  TimeCode.four: 4,
  TimeCode.Z: 5,
  TimeCode.five: 6,
  TimeCode.six: 7,
  TimeCode.seven: 8,
  TimeCode.eight: 9,
  TimeCode.nine: 10,
  TimeCode.A: 11,
  TimeCode.B: 12,
  TimeCode.C: 13,
  TimeCode.D: 14,
  TimeCode.E: 15,
  TimeCode.F: 16,
};

/// Model class representing the daily course schedule.
/// 
/// This class manages the daily courses by storing them in a schedule 
/// that maps each time slot to a corresponding course.
class DailyCourseModel {
  // Map that holds the course schedule for different time slots.
  Map<TimeCode, CourseModel> schedule;

  /// Constructor for initializing DailyCourseModel with a schedule.
  DailyCourseModel({
    required this.schedule,
  });

  /// Method to add a course to a specific time slot in the schedule.
  /// 
  /// This method takes a [TimeCode] and a [CourseModel] as parameters, 
  /// adding or updating the course in the schedule for the specified time slot.
  void addCourse({required TimeCode code, required CourseModel course}) {
    schedule[code] = course; // Add or update the course for the given time code.
  }
  
  /// Factory method to create an empty DailyCourseModel.
  /// 
  /// This method initializes a DailyCourseModel with all time slots 
  /// set to empty CourseModels, effectively providing a blank schedule.
  factory DailyCourseModel.empty() {
    return DailyCourseModel(schedule: {
      TimeCode.one: CourseModel.empty(),
      TimeCode.two: CourseModel.empty(),
      TimeCode.three: CourseModel.empty(),
      TimeCode.four: CourseModel.empty(),
      TimeCode.Z: CourseModel.empty(),
      TimeCode.five: CourseModel.empty(),
      TimeCode.six: CourseModel.empty(),
      TimeCode.seven: CourseModel.empty(),
      TimeCode.eight: CourseModel.empty(),
      TimeCode.nine: CourseModel.empty(),
      TimeCode.A: CourseModel.empty(),
      TimeCode.B: CourseModel.empty(),
      TimeCode.C: CourseModel.empty(),
      TimeCode.D: CourseModel.empty(),
      TimeCode.E: CourseModel.empty(),
      TimeCode.F: CourseModel.empty(),
    });
  }

  /// Method to convert DailyCourseModel to a corresponding DailyCourse entity.
  /// 
  /// This method maps the schedule from DailyCourseModel to the 
  /// corresponding DailyCourse entity, allowing for easy conversion 
  /// between model and entity representations.
  DailyCourse toEntity() {
    return DailyCourse(
      schedule: schedule.map((key, value) => MapEntry(key, value.toEntity())),
    );
  }
}
