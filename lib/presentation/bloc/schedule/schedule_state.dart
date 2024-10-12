part of 'schedule_bloc.dart';

sealed class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<Semester> semesters;
  final Semester selectedSemester;
  final CourseSchedule weeklySchedule;
  final WeekDay selectedWeekday;
  
  final bool needRenderOngoing;

  const ScheduleLoaded({
    required this.selectedSemester,
    required this.semesters,
    required this.weeklySchedule,
    required this.selectedWeekday,
    required this.needRenderOngoing,
  });

  @override
  List<Object> get props =>
      [selectedSemester, semesters, weeklySchedule, selectedWeekday, needRenderOngoing];
}

class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError({required this.message});
}
