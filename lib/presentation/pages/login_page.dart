import 'package:collegenius/core/constants.dart';
import 'package:collegenius/domain/entities/auth_result.dart';
import 'package:collegenius/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// LoginPage serves as the UI for user authentication.
/// 
/// It uses Bloc to manage the state of the login process and handle different
/// outcomes such as initial loading, login failure, or successful authentication.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthInitial) {
            return const LoginInitPage();
          } else if (state is AuthLoading) {
            return const LoginLoadingPage();
          } else if (state is AuthenticatedMultiple) {
            return LoginResultPage(authResults: state.authResults);
          } else {
            return const LoginInitPage();
          }
        },
      ),
    );
  }
}

class LoginInitPage extends StatefulWidget {
  const LoginInitPage({super.key});

  @override
  LoginInitPageState createState() => LoginInitPageState();
}

class LoginLoadingPage extends StatelessWidget {
  const LoginLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class LoginFailedPage extends StatelessWidget {
  const LoginFailedPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Login failed!'),
    );
  }
}

class LoginInitPageState extends State<LoginInitPage> {
  // Controllers for text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      // Show error message or handle validation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all required fields.')),
      );
      return;
    }

    // Dispatch the LoginButtonPressed event
    context.read<AuthBloc>().add(LoginButtonPressed(
          username: username,
          password: password,
          idents: const [
            WebsiteIdentifier.courseSelect,
            WebsiteIdentifier.eeclass
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username TextField
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
          ),
          const SizedBox(height: 16),
          // Password TextField
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 24),
          // Login Button
          ElevatedButton(
            onPressed: _onLoginPressed,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

class LoginResultPage extends StatelessWidget {
  final Map<WebsiteIdentifier, AuthResult> authResults;
  const LoginResultPage({super.key, required this.authResults});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            for (var entry in authResults.entries)
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 90,
                    minWidth: 340,
                    maxHeight: 90,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: entry.value.isSuccess
                                  ? Colors.green
                                  : Colors.deepOrange,
                              borderRadius: BorderRadius.circular(22.5),
                            ),
                            child: Icon(
                              entry.value.isSuccess
                                  ? Icons.verified
                                  : Icons.error,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 80,
                        top: 15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key.name,
                              style: theme.textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                OutlinedButton(
                                  onPressed: entry.value.isSuccess
                                      ? null
                                      : () {
                                          // Re-authentication not yet implemented.
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Re-authentication not implemented yet.'),
                                          ));
                                        },
                                  child: const Text('Re-auth'),
                                ),
                                const SizedBox(width: 8),
                                OutlinedButton(
                                  onPressed: () {
                                    // Status check not yet implemented.
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Status check not implemented yet.')));
                                  },
                                  child: const Text('Status'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
