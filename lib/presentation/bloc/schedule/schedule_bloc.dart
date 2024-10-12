// presentation/bloc/schedule_bloc.dart

import 'dart:async';

import 'package:collegenius/core/constants.dart';
import 'package:collegenius/core/usecases/usecase.dart';
import 'package:collegenius/domain/entities/course_schedule.dart';
import 'package:collegenius/domain/entities/semester.dart';
import 'package:collegenius/domain/usecases/get_course_schedule.dart';
import 'package:collegenius/domain/usecases/get_current_semester.dart';
import 'package:collegenius/domain/usecases/get_semester_list.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final GetCourseSchedule getCourseSchedule;
  final GetCurrentSemester getCurrentSemester;
  final GetSemesterList getSemesterList;

  Timer? _timer;
  CourseSchedule? _loadedSchedule;
  List<Semester>? _semesters;
  Semester? _currentSemester;
  Semester? _selectedSemester;
  WeekDay _selectedWeekday = mapIndexToWeekDay[DateTime.now().weekday]!;

  ScheduleBloc({
    required this.getCourseSchedule,
    required this.getCurrentSemester,
    required this.getSemesterList,
  }) : super(ScheduleInitial()) {
    on<LoadInitialDataEvent>(_onLoadInitialDataEvent);
    on<SemesterChangedEvent>(_onSemesterChangedEvent);
    on<WeekdaySelectedEvent>(_onWeekdaySelectedEvent);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Future<void> _onLoadInitialDataEvent(
    LoadInitialDataEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      /// Fetch semester list
      final smsLstRst = await getSemesterList.call(NoParams());
      smsLstRst.fold(
        (failure) => emit(ScheduleError(message: failure.message)),
        (semesters) => _semesters = semesters,
      );

      final curSmsRst = await getCurrentSemester.call(NoParams());
      curSmsRst.fold(
        (failure) => emit(ScheduleError(message: failure.message)),
        (semester) {
          _selectedSemester = semester;
          _currentSemester = semester;
        },
      );

      final selScheRst =
          await getCourseSchedule(ScheduleParams(semester: _selectedSemester!));
      selScheRst.fold(
        (failure) => emit(ScheduleError(message: failure.message)),
        (schedule) => _loadedSchedule = schedule,
      );

      emit(ScheduleLoaded(
        semesters: _semesters!,
        selectedSemester: _selectedSemester!,
        weeklySchedule: _loadedSchedule!,
        selectedWeekday: _selectedWeekday,
        needRenderOngoing: true,
      ));
    } catch (e) {
      emit(ScheduleError(message: e.toString()));
    }
  }

  Future<void> _onSemesterChangedEvent(
    SemesterChangedEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    /// Early return if the new selected semester is the same as the old selected.
    if (_selectedSemester == event.semester) {
      return;
    }
    emit(ScheduleLoading());
    try {
      /// update selected semester
      _selectedSemester = event.semester;

      /// Fetch weekly schedule for the selected semester
      final selScheRst =
          await getCourseSchedule(ScheduleParams(semester: _selectedSemester!));
      selScheRst.fold(
        (failure) => emit(ScheduleError(message: failure.message)),
        (schedule) => _loadedSchedule = schedule,
      );

      final day = mapIndexToWeekDay[DateTime.now().weekday];
      final bool needRenderOngoing;
      if (_selectedSemester == _currentSemester && day == _selectedWeekday) {
        needRenderOngoing = true;
      } else {
        needRenderOngoing = false;
      }

      emit(ScheduleLoaded(
        semesters: _semesters!,
        selectedSemester: _selectedSemester!,
        weeklySchedule: _loadedSchedule!,
        selectedWeekday: _selectedWeekday,
        needRenderOngoing: needRenderOngoing,
      ));
    } catch (e) {
      emit(ScheduleError(message: e.toString()));
    }
  }

  Future<void> _onWeekdaySelectedEvent(
    WeekdaySelectedEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    /// Early return if the new selected weekday is the same as the old weekday.
    if (_selectedWeekday == event.weekday) {
      return;
    }
    _selectedWeekday = event.weekday;

    final day = mapIndexToWeekDay[DateTime.now().weekday];
    final bool needRenderOngoing;
    if (_selectedSemester == _currentSemester && day == _selectedWeekday) {
      needRenderOngoing = true;
    } else {
      needRenderOngoing = false;
    }
    emit(ScheduleLoaded(
      semesters: _semesters!,
      selectedSemester: _selectedSemester!,
      weeklySchedule: _loadedSchedule!,
      selectedWeekday: _selectedWeekday,
      needRenderOngoing: needRenderOngoing,
    ));
  }
}
