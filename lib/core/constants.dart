import 'package:flutter/material.dart';

/// Enumeration representing different website identifiers.
/// 
/// This enum helps differentiate between multiple websites that the application
/// might interact with, such as the eClass system and the Course Selection System.
enum WebsiteIdentifier {
  eeclass,
  courseSelect,
}

/// Extension on WebsiteIdentifier to provide a human-readable name for each identifier.
extension WebsiteIdentifierX on WebsiteIdentifier {
  String get name {
    switch (this) {
      case WebsiteIdentifier.eeclass:
        return 'EE Class';
      case WebsiteIdentifier.courseSelect:
        return 'Course Selection System';
    }
  }
}

/// Enum representing different time slots for courses.
/// 
/// This enumeration defines various time codes used to identify specific 
/// time slots in a daily course schedule.
enum TimeCode {
  one,
  two,
  three,
  four,
  Z,  // Noon time slot
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

/// Extension on TimeCode to provide start and end times for each time slot.
/// 
/// Each time slot is mapped to its corresponding start and end times.
extension TimeCodeX on TimeCode {
  /// Returns the start time for the specific course time slot.
  TimeOfDay get startTime {
    switch (this) {
      case TimeCode.one:
        return const TimeOfDay(hour: 8, minute: 0);
      case TimeCode.two:
        return const TimeOfDay(hour: 9, minute: 0);
      case TimeCode.three:
        return const TimeOfDay(hour: 10, minute: 0);
      case TimeCode.four:
        return const TimeOfDay(hour: 11 ,minute: 0);
      case TimeCode.Z:
        return const TimeOfDay(hour: 12, minute: 0);
      case TimeCode.five:
        return const TimeOfDay(hour: 13, minute: 0);
      case TimeCode.six:
        return const TimeOfDay(hour: 14, minute: 0);
      case TimeCode.seven:
        return const TimeOfDay(hour: 15, minute: 0);
      case TimeCode.eight:
        return const TimeOfDay(hour: 16, minute: 0);
      case TimeCode.nine:
        return const TimeOfDay(hour: 17, minute: 0);
      case TimeCode.A:
        return const TimeOfDay(hour: 18, minute: 0);
      case TimeCode.B:
        return const TimeOfDay(hour: 19, minute: 0);
      case TimeCode.C:
        return const TimeOfDay(hour: 20, minute: 0);
      case TimeCode.D:
        return const TimeOfDay(hour: 21, minute: 0);
      case TimeCode.E:
        return const TimeOfDay(hour: 22, minute: 0);
      case TimeCode.F:
        return const TimeOfDay(hour: 23, minute: 0);
    }
  }

  /// Returns the end time for the specific course time slot.
  TimeOfDay get endTime {
    switch (this) {
      case TimeCode.one:
        return const TimeOfDay(hour: 8, minute: 50);
      case TimeCode.two:
        return const TimeOfDay(hour: 9, minute: 50);
      case TimeCode.three:
        return const TimeOfDay(hour: 10, minute: 50);
      case TimeCode.four:
        return const TimeOfDay(hour: 11 ,minute: 50);
      case TimeCode.Z:
        return const TimeOfDay(hour: 12, minute: 50);
      case TimeCode.five:
        return const TimeOfDay(hour: 13, minute: 50);
      case TimeCode.six:
        return const TimeOfDay(hour: 14, minute: 50);
      case TimeCode.seven:
        return const TimeOfDay(hour: 15, minute: 50);
      case TimeCode.eight:
        return const TimeOfDay(hour: 16, minute: 50);
      case TimeCode.nine:
        return const TimeOfDay(hour: 17, minute: 50);
      case TimeCode.A:
        return const TimeOfDay(hour: 18, minute: 50);
      case TimeCode.B:
        return const TimeOfDay(hour: 19, minute: 50);
      case TimeCode.C:
        return const TimeOfDay(hour: 20, minute: 50);
      case TimeCode.D:
        return const TimeOfDay(hour: 21, minute: 50);
      case TimeCode.E:
        return const TimeOfDay(hour: 22, minute: 50);
      case TimeCode.F:
        return const TimeOfDay(hour: 23, minute: 50);
    }
  }
}

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

/// Enumeration representing the days of the week.
enum WeekDay { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

/// Mapping from integer indices to corresponding weekdays.
/// 
/// This map is used to convert integer indices into WeekDay values, which 
/// makes handling weekdays in the application more intuitive.
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
/// 
/// This map allows converting WeekDay values to integer indices for data 
/// storage and retrieval purposes.
Map<WeekDay, int> mapWeekDaytoIndex = {
  WeekDay.monday: 1,
  WeekDay.tuesday: 2,
  WeekDay.wednesday: 3,
  WeekDay.thursday: 4,
  WeekDay.friday: 5,
  WeekDay.saturday: 6,
  WeekDay.sunday: 7,
};
