import 'package:collegenius/core/constants.dart';
import 'package:collegenius/data/models/eeclass_assignment_info_model.dart';
import 'package:collegenius/data/models/eeclass_assignment_model.dart';
import 'package:collegenius/data/models/eeclass_bulletin_info_model.dart';
import 'package:collegenius/data/models/eeclass_bullitin_model.dart';
import 'package:collegenius/data/models/eeclass_course_model.dart';
import 'package:collegenius/data/models/eeclass_course_info_model.dart';
import 'package:collegenius/data/models/eeclass_file_model.dart';
import 'package:collegenius/data/models/eeclass_material_info_model.dart';
import 'package:collegenius/data/models/eeclass_material_model.dart';
import 'package:collegenius/data/models/eeclass_quiz_info_model.dart';
import 'package:collegenius/data/models/eeclass_quiz_model.dart';
import 'package:collegenius/data/models/eeclass_semester_model.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;

class EeclassParser {
  static List<EeclassCourseInfoModel> parseCourseList(String responseBody) {
    dom.Document document = htmlparser.parse(responseBody);
    final target = document.getElementById('myCourseHistoryTable');
    const keys = [
      'semester',
      'courseCode',
      'name',
      'professor',
      'credit',
      'grade',
      'classType',
      'courseSerial'
    ];
    var result = <EeclassCourseInfoModel>[];
    if (target != null) {
      final courseTable =
          target.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
      if (courseTable[0].id == "noData") {
        return [];
      }
      for (var i in courseTable) {
        final value = i.text.split('\n');
        final attr = i.getElementsByTagName('a')[0].attributes;
        value.add(attr['href']!.replaceAll(RegExp(r"/course/"), ""));
        final course = Map.fromIterables(keys, value);
        result.add(EeclassCourseInfoModel.fromMap(course));
      }
      return result;
    }
    return [];
  }

  static List<EeclassSemesterModel> parseAvailableSemester(
      String responseBody) {
    dom.Document document = htmlparser.parse(responseBody);
    var target = document.getElementById('termId');
    final result = <EeclassSemesterModel>[];
    if (target != null) {
      var semesterList = target.getElementsByTagName('option');
      for (var element in semesterList) {
        var value = element.attributes['value'];
        var semester = element.text.trim();
        if (value != null) {
          result.add(EeclassSemesterModel(
            semesterName: semester,
            id: value,
          ));
        }
      }
      return result;
    } else {
      return [];
    }
  }

  static EeclassCourseModel parseCourse(String responseBody) {
    final dom.Document document = htmlparser.parse(responseBody);
    var info = document
        .getElementsByClassName('module app-course_info app-course_info-show');

    /// Early return if the course data is not avaliable.
    if (info.isEmpty) {
      return EeclassCourseModel.empty();
    }
    final infoTitle = info[0].getElementsByTagName('dt');
    final infoBody = info[0].getElementsByTagName('dd');
    Map<String, dynamic> result = {};
    for (int i = 0; i < infoTitle.length; i++) {
      switch (infoTitle[i].text.trim()) {
        case 'Code':
        case '課程代碼':
          result['classCode'] = infoBody[i].text.trim();
          break;
        case 'Course name':
        case '課程名稱':
          result['name'] = infoBody[i].text.trim();
          break;
        case 'Credits':
        case '學分':
          result['credit'] = int.parse(infoBody[i].text.trim());
          break;
        case 'Semester':
        case '學期':
          result['semester'] = infoBody[i].text.trim();
          break;
        case 'Division':
        case '單位':
          result['division'] = infoBody[i].text.trim();
          break;
        case 'Class':
        case '班級':
          result['classes'] = infoBody[i].text.trim();
          break;
        case 'Members':
        case '修課人數':
          result['members'] = int.parse(infoBody[i].text.trim().split(' ')[0]);
          break;
        case 'Instructor':
        case '老師':
          result['instructors'] = infoBody[i]
              .children
              .map((e) => e.children[1].children[0].children
                  .map((e) => e.text)
                  .toList()
                  .sublist(0, 2))
              .toList();
          break;
        case 'Teaching assistant':
        case '助教':
          result['assistants'] = infoBody[i]
              .children
              .map((e) => e.children[1].children[0].children
                  .map((e) => e.text)
                  .toList()
                  .sublist(0, 2))
              .toList();
          break;
        case 'Description':
        case '課程簡介':
          result['description'] = infoBody[i].text;
          break;
        case 'Syllabus':
        case '課程大綱':
          result['syllabus'] = infoBody[i].text;
          break;
        case 'Textbooks':
        case '教科書':
          result['textbooks'] = infoBody[i].text;
          break;
        case 'Grading description':
        case '成績說明':
          result['gradingDescription'] = infoBody[i].text;
          break;
      }
    }
    return EeclassCourseModel.fromMap(result);
  }

  static List<EeclassBulletinInfoModel> parseBulletinList(String responseBody) {
    dom.Document document = htmlparser.parse(responseBody);
    var target = document.getElementById('bulletinMgrTable');

    if (target != null) {
      var bulletins =
          target.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
      if (bulletins[0].id == "noData") {
        return [];
      }
      const key = [
        'readCount',
        'author',
        'date',
      ];
      var result = <Map<String, String?>>[];
      for (var element in bulletins) {
        var value = element
            .getElementsByClassName('hidden-xs')
            .sublist(1)
            .map((e) => e.text);
        var temp = Map<String, String?>.fromIterables(key, value);
        var info = element.getElementsByTagName('a')[0].attributes;
        temp['title'] = info['data-modal-title'];
        temp['url'] = info['data-url'];
        result.add(temp);
      }
      return result.map((e) => EeclassBulletinInfoModel.fromMap(e)).toList();
    }
    return [];
  }

  static EeclassBulletinModel parseBulletin(String responseBody) {
    dom.Document document = htmlparser.parse(responseBody);
    var textContentList = [];
    var textContent =
        document.getElementsByClassName('fs-text-break-word bulletin-content');
    if (textContent.isNotEmpty) {
      for (var element in textContent[0].children) {
        textContentList.add(element.text);
      }
    }
    var fileContent = document.getElementsByClassName('fs-list fs-filelist ');
    var fileContentList = <EeclassFileModel>[];
    if (fileContent.isNotEmpty) {
      for (var element in fileContent[0].getElementsByTagName('a')) {
        fileContentList.add(EeclassFileModel(
            fileName: element.text, url: element.attributes['href']!));
      }
    }
    return EeclassBulletinModel(
        content: textContentList.join('\n'), files: fileContentList);
  }

  static List<EeclassMaterialInfoModel> parseMaterialList(String responseBody) {
    dom.Document document = htmlparser.parse(responseBody);
    var target = document.getElementById('materialListTable');
    if (target != null) {
      var materials =
          target.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
      if (materials[0].id == "noData") {
        return [];
      }
      var result = <EeclassMaterialInfoModel>[];
      for (var element in materials.sublist(1)) {
        var values = element.getElementsByTagName('td');
        Map<String, dynamic> temp = {};
        for (var i = 0; i < values.length; i++) {
          switch (i) {
            case 1:
              temp['title'] = values[i]
                  .text
                  .trim()
                  .replaceAll(RegExp(r'\n'), "")
                  .replaceAll(RegExp(r'( )\1+'), " ");
              temp['url'] =
                  values[i].getElementsByTagName('a')[0].attributes['href'];
              switch (values[i]
                  .getElementsByClassName("fs-iconfont")[0]
                  .className) {
                case "fs-iconfont far fa-file-alt":
                  temp['type'] = EeclassMaterialType.attachment;
                  break;
                case "fs-iconfont far fa-file-pdf":
                  temp['type'] = EeclassMaterialType.pdf;
                  break;
                case "fs-iconfont fab fa-youtube":
                  temp['type'] = EeclassMaterialType.youtube;
                  break;
                case "fs-iconfont fal fa-file-audio":
                  temp['type'] = EeclassMaterialType.audio;
                  break;
                default:
                  temp['type'] = EeclassMaterialType.unknown;
              }

              break;
            case 2:
              temp['author'] = values[i].text.trim();
              break;
            case 3:
              temp['readCount'] = values[i].text.trim();
              break;
            case 4:
              temp['discussion'] = values[i].text.trim();
              break;
            case 5:
              temp['updateDate'] = values[i].text.trim();
              break;
          }
        }
        result.add(EeclassMaterialInfoModel.fromMap(temp));
      }
      return result;
    }
    return [];
  }

  static EeclassMaterialModel parseMaterial(
      String responseBody, EeclassMaterialType type) {
    dom.Document document = htmlparser.parse(responseBody);
    Map<String, dynamic> result = {};
    switch (type) {
      case EeclassMaterialType.attachment:
        var description =
            document.getElementsByClassName("fs-block-body list-margin");
        if (description[0].children.isNotEmpty) {
          result['description'] = description[0].text.trim();
        }
        final fileSection =
            document.getElementsByClassName("fs-list fs-filelist ");
        if (fileSection.isNotEmpty) {
          var fileList = <EeclassFileModel>[];
          final fileListTag = fileSection[0].getElementsByTagName("a");
          for (var element in fileListTag) {
            fileList.add(EeclassFileModel(
              fileName: element.text,
              url: element.attributes['href']!,
            ));
          }
          result['fileList'] = fileList;
        } else {
          result['fileList'] = [];
        }
      case EeclassMaterialType.youtube:
        var sourceTag = document
            .getElementById("info-tabs-detail")!
            .getElementsByTagName("dd")[4];
        var source = sourceTag.getElementsByTagName("a")[0].attributes['href'];
        result['source'] = source;
      case EeclassMaterialType.pdf:
        var source = document
            .getElementsByClassName("btn  mobile-only btn-primary")[0]
            .attributes['href'];
        result['source'] = source;
      default:
    }
    return EeclassMaterialModel(
      type: type,
      description: result['description'],
      fileLst: result['fileList'],
      source: result['source'],
    );
  }

  static List<EeclassAssignmentInfoModel> parseAssignmentList(
      String responseBody) {
    dom.Document document = htmlparser.parse(responseBody);
    var target = document.getElementById('homeworkListTable');
    if (target != null) {
      var homework =
          target.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
      if (homework[0].id == "noData") {
        return [];
      }
      var result = <EeclassAssignmentInfoModel>[];
      for (var element in homework) {
        var values = element.getElementsByTagName('td');
        Map<String, dynamic> temp = {};
        for (var i = 1; i < values.length; i++) {
          switch (i) {
            case 1:
              temp['title'] =
                  values[i].text.trim().replaceAll(RegExp(r'\n'), "");
              temp['url'] =
                  values[i].getElementsByTagName('a')[0].attributes['href'];
              break;
            case 2:
              temp['isTeamHomework'] = values[i]
                  .getElementsByClassName('text-overflow')[0]
                  .hasChildNodes();
              break;
            case 3:
              temp['startHandInDate'] = values[i].text.trim();
              break;
            case 4:
              temp['deadline'] = values[i].text.trim();
              break;
            case 5:
              temp['isHandedOn'] = values[i]
                  .getElementsByClassName('text-overflow')[0]
                  .hasChildNodes();
              break;
            case 6:
              temp['score'] = double.tryParse(values[i].text.trim());
          }
        }
        result.add(EeclassAssignmentInfoModel.fromMap(temp));
      }
      return result;
    }
    return [];
  }

  static EeclassAssignmentModel parseAssignment(String responseBody) {
    dom.Document document = htmlparser.parse(responseBody);
    final informationTable =
        document.getElementsByClassName("dl-horizontal ")[0];
    final infoTitle = informationTable.getElementsByTagName('dt');
    final infoBody = informationTable.getElementsByTagName('dd');
    Map<String, dynamic> temp = {};
    for (int i = 0; i < infoTitle.length; i++) {
      switch (infoTitle[i].text.trim()) {
        case 'Start Time':
        case '開放繳交':
          temp['allowUploadDate'] = infoBody[i].text.trim();
          break;
        case 'Submitted':
        case '已繳交':
          temp['hasUploadedPeople'] = infoBody[i].text.trim();
          break;
        case 'End Time':
        case '繳交期限':
          temp['deadline'] = infoBody[i].text.trim();
          break;
        case 'Allow late submission':
        case '允許遲交':
          if (infoBody[i].text.trim() == '是' ||
              infoBody[i].text.trim() == 'Yes') {
            temp['canDelay'] = true;
          } else {
            temp['canDelay'] = false;
          }
          break;
        case 'Percentage':
        case '成績比重':
          temp['gradePercentage'] = infoBody[i].text.trim();
          break;
        case 'Grading method':
        case '評分方式':
          temp['gradingMethod'] = infoBody[i].text.trim();
          break;
        case 'Description':
        case '說明':
          temp['description'] = infoBody[i].text.trim();
          break;
        case 'Attachment(s)':
        case '附件':
          var fileListTag = infoBody[i].getElementsByTagName("a");
          var fileList = <EeclassFileModel>[];
          for (var element in fileListTag) {
            fileList.add(EeclassFileModel(
              fileName: element.text,
              url: element.attributes['href']!,
            ));
          }
          temp['fileList'] = fileList;
          break;
      }
    }
    return EeclassAssignmentModel.fromMap(temp);
  }

  static List<EeclassQuizInfoModel> parseQuizList(String responseBody) {
    dom.Document document = htmlparser.parse(responseBody);
    var target = document.getElementById('examListTable');
    if (target != null) {
      var quiz =
          target.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
      if (quiz[0].id == "noData") {
        return [];
      }
      var result = <EeclassQuizInfoModel>[];
      for (var element in quiz) {
        var values = element.getElementsByTagName('td');
        Map<String, dynamic> temp = {};
        for (var i = 0; i < values.length; i++) {
          switch (i) {
            case 1:
              temp['title'] = values[i].text.trim();
              temp['url'] =
                  values[i].getElementsByTagName('a')[0].attributes['href'];
              break;
            case 2:
              temp['deadLine'] = values[i].text.trim();
              break;
            case 3:
              temp['score'] = double.tryParse(values[i].text.trim());
              break;
          }
        }
        result.add(EeclassQuizInfoModel.fromMap(temp));
      }
      return result;
    }
    return [];
  }

  static EeclassQuizModel parseQuiz(String responseBody) {
    dom.Document document = htmlparser.parse(responseBody);
    var target = document
        .getElementsByClassName('fs-page-header-mobile hidden-md hidden-lg');
    Map<String, dynamic> result = {};
    var scoreTag = document.getElementsByClassName('number');
    if (scoreTag.isNotEmpty) {
      result['score'] = double.tryParse(scoreTag[0].text);
    }
    if (target[0].children.length == 2) {
      result['isPaperQuiz'] = true;
    } else {
      result['isPaperQuiz'] = false;
    }
    result['quizTitle'] = target[0].getElementsByTagName('h2')[0].text.trim();
    var quizInfoTable = document.getElementsByClassName('dl-horizontal');
    var infoKeys = quizInfoTable[0].getElementsByTagName("dt");
    var infoValues = quizInfoTable[0].getElementsByTagName("dd");
    result['timeDuration'] = infoValues[0].text.trim();
    result['percentage'] = infoValues[1].text.trim();
    result['fullMarks'] = double.tryParse(infoValues[2].text.trim());
    result['passingMarks'] = double.tryParse(infoValues[3].text.trim());
    if (infoKeys[4].text.trim() == "Duration" ||
        infoKeys[4].text.trim() == "時間限制") {
      result['timeLimit'] = infoValues[4].text.trim();
    }
    var description = '';
    var attachments = <EeclassFileModel>[];
    for (var element in infoValues[5].children) {
      if (element.className == "fs-list fs-filelist ") {
        for (var attachmentTag in element.getElementsByTagName("a")) {
          attachments.add(EeclassFileModel(
              fileName: attachmentTag.text,
              url: attachmentTag.attributes['href']!));
        }
      } else {
        description += element.text;
        description += "\n";
      }
    }
    result['description'] = description.trim();
    result['attachments'] = attachments;

    var tooltable = document.getElementsByClassName("fs-tools");
    if (tooltable.isNotEmpty) {
      for (var element in tooltable[0].getElementsByTagName("a")) {
        if (element.text == "") {
          continue;
        } else {
          switch (element.text) {
            case "成績分布":
              result['scoreDistributionUrl'] = element.attributes['href'];
              break;
            case "作答記錄":
              result['quizRecordUrl'] = element.attributes['href'];
              break;
            case "檢視解答":
              result['answerUrl'] = element.attributes['href'];
              break;

            default:
              continue;
          }
        }
      }
    }
    return EeclassQuizModel.fromMap(result);
  }

  static List<int> parseScoreDistribution(String responseBody) {
    dom.Document document = htmlparser.parse(responseBody);
    var target = document.getElementById("exam_paper_statistics");
    var infoTags = target!
        .getElementsByTagName("tbody")[0]
        .getElementsByClassName(" text-center  col-char2");
    var result = <int>[];
    for (int i = infoTags.length - 1; i >= 0; i--) {
      result.add(int.parse(infoTags[i].text));
    }
    return result;
  }
}
