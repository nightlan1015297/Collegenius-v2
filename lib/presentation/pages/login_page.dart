import 'package:collegenius/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // List of available websites (services)
  final List<String> _availableWebsites = ['CourseSelect', 'Eeclass'];

  // Selected websites for authentication
  List<String> _selectedWebsites = [];

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty || _selectedWebsites.isEmpty) {
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
          websiteIdentifiers: _selectedWebsites,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedMultiple) {
            // Navigate to the next screen or show success message
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthError) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                const SizedBox(height: 16),
                // Multi-select for websites
                _buildWebsiteSelection(),
                const SizedBox(height: 24),
                // Login Button
                ElevatedButton(
                  onPressed: _onLoginPressed,
                  child: const Text('Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWebsiteSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Websites:'),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: _availableWebsites.map((website) {
            return FilterChip(
              label: Text(website),
              selected: _selectedWebsites.contains(website),
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    _selectedWebsites.add(website);
                  } else {
                    _selectedWebsites.remove(website);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
