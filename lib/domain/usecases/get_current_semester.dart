import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/core/usecases/usecase.dart';
import 'package:collegenius/domain/entities/semester.dart';
import 'package:collegenius/domain/repositories/course_select_repository.dart';
import 'package:either_dart/either.dart';

/// Use case to get the current semester.
///
/// This class interacts with the [CourseSelectRepository] to 
/// retrieve the current [Semester]. It extends [UseCase], 
/// following a clean architecture pattern for separation of concerns.
class GetCurrentSemester implements UseCase<Semester, NoParams> {
  /// The repository instance used to access course selection data.
  ///
  /// This repository is injected via the constructor to maintain 
  /// modularity and facilitate unit testing.
  final CourseSelectRepository repository;

  /// Constructs a [GetCurrentSemester] instance.
  ///
  /// Requires the [repository] which provides methods for accessing data
  /// from the course selection system.
  GetCurrentSemester({required this.repository});
  
  /// Calls the repository to get the current semester.
  ///
  /// Since there are no specific parameters needed, [NoParams] is used as
  /// the input type. This method retrieves the current [Semester] from the
  /// repository, returning a [Future] that contains either a [Failure] or the [Semester].
  ///
  /// Parameters:
  /// - [params]: The [NoParams] object indicating no additional input is required.
  ///
  /// Returns:
  /// - A [Future<Either<Failure, Semester>>] which contains either a failure 
  ///   object or the retrieved [Semester] data.
  @override
  Future<Either<Failure, Semester>> call(NoParams params) async {
    return await repository.getCurrentSemester();
  }
}