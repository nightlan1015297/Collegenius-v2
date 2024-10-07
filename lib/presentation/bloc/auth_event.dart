part of 'auth_bloc.dart';

/// Abstract base class for all authentication-related events.
/// This class serves as a contract for specific events like 
/// [LoginButtonPressed] and [LogoutButtonPressed].
@immutable
sealed class AuthEvent {}

/// Event triggered when the user presses the login button.
///
/// This event contains the necessary login credentials, including
/// the [username], [password], and a list of [websiteIdentifiers]
/// representing the services the user wishes to authenticate with.
class LoginButtonPressed extends AuthEvent {
  final String username;
  final String password;
  final List<String> websiteIdentifiers;

  /// Constructor for initializing the [LoginButtonPressed] event.
  ///
  /// Requires the [username] and [password] for authentication, as well
  /// as a list of [websiteIdentifiers] to identify the services that
  /// the user is logging into.
  LoginButtonPressed({
    required this.username,
    required this.password,
    required this.websiteIdentifiers,
  });
}

/// Event triggered when the user presses the logout button.
///
/// This event signals the intent to log out of the current session.
class LogoutButtonPressed extends AuthEvent {
  /// Constructor for initializing the [LogoutButtonPressed] event.
  ///
  /// This event does not require any parameters, as it only triggers
  /// the logout functionality.
  LogoutButtonPressed();
}
