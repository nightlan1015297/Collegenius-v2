import 'package:collegenius/data/models/eeclass_file_model.dart';

class EeclassAssignmentModel {
  final String allowUploadDate;
  final String hasUploadedPeople;
  final String deadline;
  final bool canDelay;
  final String gradePercentage;
  final String gradingMethod;
  final String description;
  final List<EeclassFileModel> fileList;

  EeclassAssignmentModel(
      {required this.allowUploadDate,
      required this.hasUploadedPeople,
      required this.deadline,
      required this.canDelay,
      required this.gradePercentage,
      required this.gradingMethod,
      required this.description,
      required this.fileList});

  factory EeclassAssignmentModel.fromMap(Map<String, dynamic> map) {
    return EeclassAssignmentModel(
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
