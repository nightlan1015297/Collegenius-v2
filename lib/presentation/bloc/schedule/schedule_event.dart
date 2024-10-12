part of 'schedule_bloc.dart';

sealed class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialDataEvent extends ScheduleEvent {}

class SemesterChangedEvent extends ScheduleEvent {
  final Semester semester;

  const SemesterChangedEvent({required this.semester});
}

class WeekdaySelectedEvent extends ScheduleEvent {
  final WeekDay weekday;

  const WeekdaySelectedEvent({required this.weekday});
}

