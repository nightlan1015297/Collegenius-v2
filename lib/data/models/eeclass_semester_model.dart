import 'package:collegenius/domain/entities/eeclass_semester.dart';

/// Model class representing a semester.
///
/// This class encapsulates the details of a semester, including its 
/// ID and name. It provides methods to create an [EeclassSemesterModel] 
/// from a string representation and convert it to a corresponding 
/// [EeclassSemester] entity.
class EeclassSemesterModel {
  /// The ID of the semester (e.g., "1101" or "1102").
  final String id;

  /// The name of the semester.
  final String semesterName;

  /// Constructor for initializing [EeclassSemesterModel] with an ID and name.
  EeclassSemesterModel({
    required this.id,
    required this.semesterName,
  });

  /// Indicates if the semester model is empty.
  bool get isEmpty => id.isEmpty && semesterName.isEmpty;

  /// Factory constructor that creates an empty [EeclassSemesterModel].
  ///
  /// Useful for initializing empty forms or placeholders.
  factory EeclassSemesterModel.empty() {
    return EeclassSemesterModel(id: '', semesterName: '');
  }

  /// Factory constructor that creates an [EeclassSemesterModel] from a [Map].
  ///
  /// This method is used to convert raw data (e.g., JSON) into an instance of the model.
  factory EeclassSemesterModel.fromMap(Map<String, dynamic> map) {
    return EeclassSemesterModel(
      id: map['id'] as String? ?? '',
      semesterName: map['semesterName'] as String? ?? '',
    );
  }

  /// Converts this [EeclassSemesterModel] into a domain entity.
  ///
  /// This method maps the data held in this model into the corresponding
  /// [EeclassSemester] domain entity, used throughout the application.
  EeclassSemester toEntity() {
    return EeclassSemester(
      id: id,
      semesterName: semesterName,
    );
  }
}
