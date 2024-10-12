import 'package:collegenius/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:collegenius/presentation/bloc/schedule/schedule_bloc.dart';
import 'package:collegenius/presentation/pages/course_schedule_page.dart';
import 'package:collegenius/presentation/pages/homepage.dart';
import 'package:collegenius/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/theme.dart';
import 'service_locator.dart' as di;

void main() {
  // Ensures the Flutter engine is initialized before calling any widgets.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies using the service locator (dependency injection).
  di.init();

  // Run the application.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget serves as the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Provide the AuthBloc to the widget tree to handle authentication states.
      providers: [
        BlocProvider<AuthBloc>(create: (context) => di.sl<AuthBloc>()),
        BlocProvider<ScheduleBloc>(create: (context) => di.sl<ScheduleBloc>())
      ],
      child: MaterialApp(
        title: 'Collegenius', // Updated the app title for accuracy.
        theme:
            CollegeniusTheme.theme, // Apply custom theme from the theme file.

        // Define the app routes for navigation.
        routes: {
          '/login': (context) =>
              const LoginPage(), // Login page as the initial route.
          '/': (context) => const HomePage(),
          '/courseschedule': (context) =>
              const CourseSchedulePage() // Home page route.
        },
      ),
    );
  }
}
