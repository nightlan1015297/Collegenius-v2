part of 'auth_bloc.dart';

/// Abstract base class for all possible authentication states.
/// This class serves as the contract for various authentication
/// states like [AuthInitial], [AuthLoading], [AuthenticatedMultiple],
/// and [AuthError].
@immutable
sealed class AuthState extends Equatable {}

/// The initial state when the authentication process has not yet started.
///
/// This state is the default when no authentication attempt has been made,
/// or when the application is freshly started and awaiting user interaction.
class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

/// State emitted when the authentication process is in progress.
///
/// This state indicates that the user has triggered an authentication event,
/// and the application is currently awaiting the outcome (e.g., logging into
/// multiple services).
class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

/// State emitted when authentication succeeds for multiple services.
///
/// This state contains a list of [AuthSuccess] objects, which represent
/// the successful login results for each of the services the user attempted
/// to authenticate with.
class AuthenticatedMultiple extends AuthState {
  final List<AuthSuccess> authSuccess;

  /// Constructor for initializing [AuthenticatedMultiple] state.
  ///
  /// Accepts a required list of [authSuccess], representing the success 
  /// statuses for multiple authenticated services.
  AuthenticatedMultiple({required this.authSuccess});
  
  @override
  List<Object?> get props => [authSuccess];
}

/// State emitted when the authentication process fails.
///
/// This state contains a [message] that explains the reason for the failure,
/// which can be displayed to the user.
class AuthError extends AuthState {
  final String message;

  /// Constructor for initializing [AuthError] state.
  ///
  /// Accepts a required [message] parameter, which contains details of
  /// the error encountered during authentication.
  AuthError({required this.message});
  
  @override
  List<Object?> get props => [message];
}
