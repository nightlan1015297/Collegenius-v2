import 'package:collegenius/core/error/failures.dart';
import 'package:collegenius/core/usecases/usecase.dart';
import 'package:collegenius/domain/entities/auth_success.dart';
import 'package:collegenius/domain/repositories/auth_repository.dart';
import 'package:either_dart/either.dart';

/// Use case for logging into multiple services.
///
/// This use case handles the process of authenticating a user across
/// multiple services in parallel. It returns either a list of successful
/// authentication results ([AuthSuccess]) or a list of failures.
class LoginToMultipleServices implements UseCase<List<AuthSuccess>, LoginParams> {
  final AuthRepository repository;

  /// Constructor for initializing [LoginToMultipleServices] use case.
  ///
  /// Requires an [AuthRepository] instance for performing the login operations.
  LoginToMultipleServices(this.repository);

  /// Overrides the call operator to initiate the login process for multiple services.
  ///
  /// This method takes [LoginParams], which includes the username, password,
  /// and a list of service identifiers. It attempts to log into each service
  /// in parallel, collecting either success results or failures. Returns
  /// either a [Failure] or a list of [AuthSuccess].
  @override
  Future<Either<Failure, List<AuthSuccess>>> call(LoginParams params) async {
    final websiteIdentifiers = params.websiteIdentifiers;

    // List to store successful authentication results.
    List<AuthSuccess> authSuccesses = [];
    
    // List to store any failures encountered during authentication.
    List<Failure> failures = [];

    // Perform authentication in parallel for each website identifier.
    final results = await Future.wait(websiteIdentifiers.map((websiteIdentifier) {
      return repository.login(
        username: params.username,
        password: params.password,
        websiteIdentifier: websiteIdentifier,
      );
    }));

    // Process the results, separating successes from failures.
    for (var result in results) {
      result.fold(
        (failure) => failures.add(failure),    // Add failures to the list.
        (authSuccess) => authSuccesses.add(authSuccess),  // Add successes to the list.
      );
    }

    // If there are any failures, return them wrapped in [MultipleFailures].
    if (failures.isNotEmpty) {
      return Left(MultipleFailures(failures: failures));
    } else {
      // If all authentications were successful, return the successes.
      return Right(authSuccesses);
    }
  }
}

/// Parameters required for logging into multiple services.
///
/// This class contains the [username], [password], and a list of 
/// [websiteIdentifiers] that identify the services the user wants to log into.
class LoginParams {
  final String username;
  final String password;
  final List<String> websiteIdentifiers;

  /// Constructor for initializing [LoginParams].
  ///
  /// Requires a [username], [password], and a list of [websiteIdentifiers].
  LoginParams({
    required this.username,
    required this.password,
    required this.websiteIdentifiers,
  });
}

/// Failure class representing multiple authentication failures.
///
/// This class is used when the login attempt fails for one or more
/// services. It holds a list of individual failures.
class MultipleFailures extends Failure {
  final List<Failure> failures;

  /// Constructor for initializing [MultipleFailures].
  ///
  /// Takes a required [failures] parameter, which is a list of 
  /// [Failure] objects representing the authentication failures.
  MultipleFailures({required this.failures}) : super('Authentication failed for one or more services.');
}
