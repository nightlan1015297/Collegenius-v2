import 'package:collegenius/data/models/course_model.dart';
import 'package:collegenius/data/models/course_schedule_model.dart';
import 'package:collegenius/data/models/daily_course_model.dart';
import 'package:collegenius/data/models/semester_model.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

/// A parser class for extracting course schedule and semester data 
/// from HTML responses.
///
/// This class contains static methods to parse course schedules, current 
/// semesters, and a list of semesters from HTML documents. It utilizes 
/// the `html` package to parse HTML strings and extract relevant data.
class CourseSelectParser {
  static const String classTableClassName = 'classtable'; // Class name for course schedule table.
  static const String introBannerClassName = 'intro_banner'; // Class name for semester banner.

  /// Parses the course schedule from the provided [responseBody].
  /// 
  /// This method extracts the course schedule from an HTML document 
  /// represented by [responseBody]. It retrieves the course table, 
  /// iterates through each row, and constructs a [CourseScheduleModel] 
  /// object populated with the parsed courses.
  ///
  /// Throws an [Exception] if the course schedule table is not found.
  static CourseScheduleModel parseSchedule(String responseBody) {
    dom.Document document = htmlparser.parse(responseBody);
    var table = document.getElementsByClassName(classTableClassName).isNotEmpty 
        ? document.getElementsByClassName(classTableClassName)[0] 
        : null;

    if (table == null) {
      throw Exception("Course schedule table not found.");
    }

    var rows = table.getElementsByTagName('tr');
    var courseSchedule = CourseScheduleModel.empty();

    for (int i = 1; i < rows.length; i++) {
      var elemInRow = rows[i].getElementsByTagName('td');
      for (int j = 0; j < elemInRow.length; j++) {
        var info = elemInRow[j].text.trim().split('\n');
        if (info.length != 1) {
          var course = _parseCourse(info);
          if (course != null) {
            courseSchedule.addCourse(
                day: mapIndexToWeekDay[j]!,
                code: mapIndexToTimeCode[i + 1]!,
                course: course);
          }
        }
      }
    }
    return courseSchedule;
  }

  /// Parses a single course from the provided [info] list.
  /// 
  /// This method constructs a [CourseModel] object based on the given 
  /// information. It expects the course details to be formatted correctly 
  /// in the [info] list. Returns a [CourseModel] instance or null if 
  /// parsing fails.
  static CourseModel? _parseCourse(List<String> info) {
    var target = info[1].trim().replaceAll(RegExp(r'[()]'), "");
    var parts = target.split(' ');
    CourseModel course;
    if (target[0].trim().startsWith(RegExp(r'.*[A-Z]+.*[0-9]+.*'))) {
      course = CourseModel(
          name: info[0].trim(),
          classroom: parts[0].trim(),
          professor: parts[1].trim());
    } else {
      course = CourseModel(
          name: info[0].trim(),
          classroom: parts[1].trim(),
          professor: parts[0].trim());
    }

    return course;
  }

  /// Parses the current semester from the provided [responseBody].
  /// 
  /// This method extracts the current semester information from the HTML 
  /// document represented by [responseBody]. It looks for the relevant 
  /// banner and returns a [SemesterModel] object that corresponds to the 
  /// current semester.
  ///
  /// Throws an [Exception] if the current semester banner is not found.
  static SemesterModel parseCurrentSemester(String responseBody) {
    dom.Document document = htmlparser.parse(responseBody);
    var targetBanner = document.getElementsByClassName(introBannerClassName);
    
    if (targetBanner.length < 2) {
      throw Exception("Current semester banner not found.");
    }

    String semesterStr = targetBanner[1].text.split('|')[0].trim();
    return SemesterModel.fromString(str: semesterStr);
  }
  
  /// Parses the list of semesters from the provided [responseBody].
  /// 
  /// This method retrieves the list of available semesters from the HTML 
  /// document represented by [responseBody]. It extracts the semester 
  /// options from a dropdown and returns a list of [SemesterModel] 
  /// objects corresponding to each semester.
  ///
  /// Throws an [Exception] if the semester selection is not found.
  static List<SemesterModel> parseSemesterList(String responseBody) {
    dom.Document document = htmlparser.parse(responseBody);
    var selectElement = document.getElementsByTagName("select").isNotEmpty 
        ? document.getElementsByTagName("select")[0] 
        : null;

    if (selectElement == null) {
      throw Exception("Semester selection not found.");
    }

    var result = selectElement.children.map((e) => e.text).toList();
    List<SemesterModel> semesterList = [];
    for (var semesterText in result) {
      semesterList.add(SemesterModel.fromString(str: semesterText));
    }
    return semesterList;
  }
}
