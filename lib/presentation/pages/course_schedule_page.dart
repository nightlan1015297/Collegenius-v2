import 'dart:async';

import 'package:collegenius/core/constants.dart';
import 'package:collegenius/domain/entities/course.dart';
import 'package:collegenius/domain/entities/daily_course.dart';
import 'package:collegenius/domain/entities/semester.dart';
import 'package:collegenius/presentation/bloc/schedule/schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class CourseSchedulePage extends StatefulWidget {
  const CourseSchedulePage({super.key});

  @override
  State<CourseSchedulePage> createState() => _CourseSchedulePageState();
}

class _CourseSchedulePageState extends State<CourseSchedulePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ScheduleBloc>(context).add(LoadInitialDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Schedule'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocConsumer<ScheduleBloc, ScheduleState>(
        listener: (context, state) {
          if (state is ScheduleError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (ScheduleInitial):
              return const CourseScheduleInitPage();
            case const (ScheduleLoading):
              return const CourseScheduleLoadingPage();
            case const (ScheduleLoaded):
              return const CourseScheduleLoadedPage();
            default:
              return const CourseScheduleInitPage();
          }
        },
      ),
    );
  }
}

class CourseScheduleInitPage extends StatelessWidget {
  const CourseScheduleInitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class CourseScheduleLoadingPage extends StatelessWidget {
  const CourseScheduleLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class CourseScheduleLoadedPage extends StatefulWidget {
  const CourseScheduleLoadedPage({super.key});

  @override
  State<CourseScheduleLoadedPage> createState() =>
      _CourseScheduleLoadedPageState();
}

class _CourseScheduleLoadedPageState extends State<CourseScheduleLoadedPage> {
  TimeOfDay _currentTime = TimeOfDay.now();
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(minutes: 1), (Timer t) {
      setState(() {
        _currentTime = TimeOfDay.now();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        state as ScheduleLoaded;
        return Column(
          children: [
            const CourseScheduleSelectors(),
            Expanded(
              child: Builder(builder: (context) {
                if (state
                    .weeklySchedule.schedule[state.selectedWeekday]!.isEmpty) {
                  return const Center(
                    child: Text('No course on this day'),
                  );
                } else {
                  return _buildTimeline(
                    state.weeklySchedule.schedule[state.selectedWeekday]!,
                    state.needRenderOngoing,
                  );
                }
              }),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Widget _renderOngoingCourseCard(Course course) {
    if (_currentTime.isAfter(course.timeCode.endTime)) {
      return Opacity(opacity: 0.5, child: StaticCourseCard(course: course));
    } else {
      return StaticCourseCard(course: course);
    }
  }

  Widget _renderOngoingTimeLine(Course course,
      {double? topPadding, double? height}) {
    if (_currentTime.isAfter(course.timeCode.endTime)) {
      return FadedTimeLineUnit(
          topPadding: topPadding ?? 0, height: height ?? 70);
    } else if (_currentTime.isAfter(course.timeCode.startTime) &&
        _currentTime.isBefore(course.timeCode.endTime)) {
      return AnimatedTimeLineUnit(
          topPadding: topPadding ?? 0, height: height ?? 70);
    } else {
      return StaticTimeLineUnit(
          topPadding: topPadding ?? 0, height: height ?? 70);
    }
  }

  Widget _buildTimeline(DailyCourse courses, bool needRenderOngoing) {
    List<Course?> renderLst = [];
    List<Widget> timeline = [];
    List<Widget> cards = [];
    bool isFirstRendered = true;
    bool previousIsBlank = false;
    for (int i = 1; i < 17; i++) {
      final timeCode = mapIndexToTimeCode[i];
      if (courses.schedule[timeCode]!.isEmpty) {
        if (isFirstRendered) {
          continue;
        } else {
          previousIsBlank = true;
        }
      } else {
        isFirstRendered = false;
        if (previousIsBlank) {
          renderLst.add(null);
          previousIsBlank = false;
        }
        renderLst.add(courses.schedule[timeCode]!);
      }
    }
    if (needRenderOngoing) {
      timeline.add(_renderOngoingTimeLine(renderLst[0]!, topPadding: 25));
      cards.add(_renderOngoingCourseCard(renderLst[0]!));
      for (int i = 1; i < renderLst.length - 1; i++) {
        if (renderLst[i] == null) {
          if (_currentTime.isAfter(renderLst[i + 1]!.timeCode.startTime)) {
            timeline.add(const Opacity(opacity: 0.5, child: Line(height: 20)));
            cards.add(const SizedBox(height: 20));
          } else {
            timeline.add(const Line(height: 20));
            cards.add(const SizedBox(height: 20));
          }
        } else {
          timeline.add(_renderOngoingTimeLine(renderLst[i]!));
          cards.add(_renderOngoingCourseCard(renderLst[i]!));
        }
      }
      timeline.add(_renderOngoingTimeLine(renderLst.last!, height: 30));
      cards.add(_renderOngoingCourseCard(renderLst.last!));
    } else {
      timeline.add(const StaticTimeLineUnit(topPadding: 25, height: 70));
      cards.add(StaticCourseCard(course: renderLst[0]!));
      for (var course in renderLst.sublist(1, renderLst.length - 1)) {
        if (course == null) {
          timeline.add(const Line(height: 20));
          cards.add(const SizedBox(height: 20));
        } else {
          timeline.add(const StaticTimeLineUnit(topPadding: 0, height: 70));
          cards.add(StaticCourseCard(course: course));
        }
      }
      timeline.add(const StaticTimeLineUnit(topPadding: 0, height: 30));
      cards.add(StaticCourseCard(course: renderLst.last!));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: timeline,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: cards,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedTimeLineUnit extends StatelessWidget {
  final double height;
  final double topPadding;

  const AnimatedTimeLineUnit(
      {super.key, required this.height, required this.topPadding});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DottedNode(topPadding: topPadding),
        DottedLine(height: height),
      ],
    );
  }
}

class StaticTimeLineUnit extends StatelessWidget {
  final double height;
  final double topPadding;

  const StaticTimeLineUnit({
    super.key,
    required this.height,
    required this.topPadding,
  });
  @override
  Widget build(Object context) {
    return Column(
      children: [
        Node(topPadding: topPadding),
        Line(height: height),
      ],
    );
  }
}

class FadedTimeLineUnit extends StatelessWidget {
  final double height;
  final double topPadding;

  const FadedTimeLineUnit({
    super.key,
    required this.height,
    required this.topPadding,
  });
  @override
  Widget build(Object context) {
    return Column(
      children: [
        Opacity(opacity: 0.5, child: Node(topPadding: topPadding)),
        Opacity(opacity: 0.5, child: Line(height: height)),
      ],
    );
  }
}

class CourseScheduleSelectors extends StatelessWidget {
  const CourseScheduleSelectors({
    super.key,
  });

  List<WeekDay> get _weekdays => [
        WeekDay.sunday,
        WeekDay.monday,
        WeekDay.tuesday,
        WeekDay.wednesday,
        WeekDay.thursday,
        WeekDay.friday,
        WeekDay.saturday,
      ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        state as ScheduleLoaded;
        final theme = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Semester Selector
              Container(
                height: 35,
                decoration: BoxDecoration(
                  color: theme.canvasColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Semester>(
                    isDense: true,
                    isExpanded: false,
                    dropdownColor: theme.canvasColor,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    borderRadius: BorderRadius.circular(30),
                    value: state.selectedSemester,
                    items: state.semesters.map((Semester semester) {
                      return DropdownMenuItem<Semester>(
                        value: semester,
                        child: Text(semester.semesterName,
                            style: theme.textTheme.labelLarge),
                      );
                    }).toList(),
                    onChanged: (value) {
                      
                      if (value != null) {
                        BlocProvider.of<ScheduleBloc>(context).add(
                          SemesterChangedEvent(semester: value),
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Weekday Selector
              Container(
                height: 35,
                decoration: BoxDecoration(
                  color: theme.canvasColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<WeekDay>(
                    isDense: true,
                    isExpanded: false,
                    dropdownColor: theme.canvasColor,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    borderRadius: BorderRadius.circular(30),
                    value: state.selectedWeekday,
                    items: _weekdays.map((WeekDay day) {
                      return DropdownMenuItem<WeekDay>(
                        value: day,
                        child: Text(
                          day.name,
                          style: theme.textTheme.labelLarge,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        BlocProvider.of<ScheduleBloc>(context).add(
                          WeekdaySelectedEvent(weekday: value),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class StaticCourseCard extends StatelessWidget {
  final Course course;
  const StaticCourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 90,
        minWidth: 200,
        maxHeight: 90,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(course.name, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 5),
                      Text(
                          "${course.timeCode.startTimeString} - ${course.timeCode.endTimeString}",
                          style: theme.textTheme.titleSmall),
                    ],
                  ),
                ),
                const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_forward_ios)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class NodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double circleRadius = 8;
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, circleRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DottedLinePainter extends CustomPainter {
  DottedLinePainter({
    required this.shiftPercent,
  });

  final double shiftPercent;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    final double shiftPixel = shiftPercent * 14;

    for (double i = 0; i * 7 + shiftPixel < size.height; i++) {
      if (shiftPercent > 0.5) {
        canvas.drawLine(Offset(size.width / 2, 0),
            Offset(size.width / 2, shiftPixel - 7), paint);
      }
      if (i % 2 == 0) {
        if (i * 7 + shiftPixel + 7 > size.height) {
          canvas.drawLine(Offset(size.width / 2, i * 7 + shiftPixel),
              Offset(size.width / 2, size.height), paint);
        } else {
          canvas.drawLine(Offset(size.width / 2, i * 7 + shiftPixel),
              Offset(size.width / 2, i * 7 + shiftPixel + 7), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DottedNodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double circleRadius = 8;
    final center = Offset(size.width / 2, size.height / 2);
    const circleradius = 2 * pi;
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    for (double i = 0; i < 1; i += 0.2) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: circleRadius),
        i * circleradius,
        0.125 * circleradius,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Line extends StatelessWidget {
  final double height;
  const Line({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: height,
      child: CustomPaint(
        foregroundPainter: LinePainter(),
      ),
    );
  }
}

class Node extends StatelessWidget {
  final double topPadding;
  const Node({super.key, required this.topPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: SizedBox(
        width: 20,
        height: 20,
        child: CustomPaint(
          foregroundPainter: NodePainter(),
        ),
      ),
    );
  }
}

class DottedLine extends StatefulWidget {
  final double height;
  const DottedLine({super.key, required this.height});

  @override
  State<DottedLine> createState() => DottedLineState();
}

class DottedLineState extends State<DottedLine> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    final curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);

    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: widget.height,
      child: AnimatedBuilder(
          animation: _animationController.view,
          builder: (context, child) {
            return CustomPaint(
              painter: DottedLinePainter(shiftPercent: _animation.value),
            );
          }),
    );
  }
}

class DottedNode extends StatefulWidget {
  final double topPadding;
  const DottedNode({super.key, required this.topPadding});

  @override
  DottedNodeState createState() => DottedNodeState();
}

class DottedNodeState extends State<DottedNode> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    final curvedAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutQuad);

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(curvedAnimation);
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.topPadding),
      child: SizedBox(
        width: 20,
        height: 20,
        child: AnimatedBuilder(
          animation: _animationController.view,
          builder: (context, child) {
            return Transform.rotate(angle: _animation.value, child: child);
          },
          child: CustomPaint(
            foregroundPainter: DottedNodePainter(),
          ),
        ),
      ),
    );
  }
}
