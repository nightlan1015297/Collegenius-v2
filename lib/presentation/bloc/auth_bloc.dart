import 'package:collegenius/core/constants.dart';
import 'package:collegenius/domain/entities/auth_success.dart';
import 'package:collegenius/domain/usecases/login_multiple_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// The AuthBloc class is responsible for managing authentication-related
/// events and state transitions in the application.
///
/// It handles user login across multiple services and emits corresponding
/// states (e.g., loading, error, success) based on the result of the login
/// process.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  
  /// An instance of [LoginToMultipleServices] use case, which manages 
  /// the login logic for multiple services.
  final LoginToMultipleServices loginToMultipleServices;

  /// Initializes the AuthBloc with the required use case.
  ///
  /// The initial state is set to [AuthInitial], and the [LoginButtonPressed]
  /// event is handled by the [_onLoginButtonPressed] function.
  AuthBloc({required this.loginToMultipleServices}) : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  /// Handles the [LoginButtonPressed] event, which is triggered when
  /// the user attempts to log in.
  ///
  /// This function calls the [loginToMultipleServices] use case with
  /// the login credentials provided in the event. Depending on the result,
  /// it emits either an [AuthError] or [AuthenticatedMultiple] state.
  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    // Emit [AuthLoading] state while the authentication process is ongoing.
    emit(AuthLoading());

    // Call the login use case with the provided username, password, and service identifiers.
    final result = await loginToMultipleServices(LoginParams(
      username: event.username,
      password: event.password,
      idents: event.websiteIdentifiers,
    ));

    // Handle the result of the login attempt.
    result.fold(
      (failure) {
        // If there are multiple failures, emit a detailed error message.
        if (failure is MultipleFailures) {
          emit(AuthError(message: 'Authentication failed for one or more services.'));
        } else {
          // For a single failure, emit a general error message.
          emit(AuthError(message: failure.message));
        }
      },
      // If the login is successful, emit the [AuthenticatedMultiple] state with the success data.
      (authSuccess) => emit(AuthenticatedMultiple(authSuccess: authSuccess)),
    );
  }
}
