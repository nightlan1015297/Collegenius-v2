
import 'package:collegenius/domain/entities/eeclass_file.dart';

class EeclassAssignment {
  final String allowUploadDate;
  final String hasUploadedPeople;
  final String deadline;
  final bool canDelay;
  final String gradePercentage;
  final String gradingMethod;
  final String description;
  final List<EeclassFile> fileList;

  EeclassAssignment(
      {required this.allowUploadDate,
      required this.hasUploadedPeople,
      required this.deadline,
      required this.canDelay,
      required this.gradePercentage,
      required this.gradingMethod,
      required this.description,
      required this.fileList});

  factory EeclassAssignment.fromMap(Map<String, dynamic> map) {
    return EeclassAssignment(
      allowUploadDate: map['allowUploadDate'],
      hasUploadedPeople: map['hasUploadedPeople'],
      deadline: map['deadline'],
      canDelay: map['canDelay'],
      gradePercentage: map['gradePercentage'],
      gradingMethod: map['gradingMethod'],
      description: map['description'],
      fileList: map['fileList'],
    );
  }
}
