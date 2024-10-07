import 'package:collegenius/core/error/failures.dart';
import 'package:either_dart/either.dart';

/// A base class for all use cases, ensuring a consistent interface.
/// [Type] is the return type of the use case.
/// [Params] is the input type required to execute the use case.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// A class representing no parameters.
/// Useful for use cases that don't require any input.
class NoParams {}