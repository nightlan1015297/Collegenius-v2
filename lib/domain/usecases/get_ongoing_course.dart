
import 'package:collegenius/core/constants.dart';
import 'package:collegenius/domain/entities/daily_course.dart';
import 'package:flutter/material.dart';

import '../entities/course.dart';

class GetOngoingCourse {
  Course? call(DailyCourse courses) {
    final now = TimeOfDay.fromDateTime(DateTime.now());
    final currentTimeMin = now.hour * 60 + now.minute;
    for (var entry in courses.schedule.entries) {
      final timeCode = entry.value.timeCode;
      final startTimeMin = timeCode.startTime.hour * 60 + timeCode.startTime.minute;
      final endTimeMin = timeCode.endTime.hour * 60 + timeCode.endTime.minute;
      if (currentTimeMin >= startTimeMin && currentTimeMin <= endTimeMin) {
        return entry.value;
      }
    }
    return null;
  }
}