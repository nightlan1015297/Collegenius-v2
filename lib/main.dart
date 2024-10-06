import 'package:collegenius/presentation/bloc/auth_bloc.dart';
import 'package:collegenius/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/pages/homepage.dart';
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
    return BlocProvider(
      // Provide the AuthBloc to the widget tree to handle authentication states.
      create: (context) => di.sl<AuthBloc>(),
      child: MaterialApp(
        title: 'Collegenius',           // Updated the app title for accuracy.
        theme: CollegeniusTheme.theme,  // Apply custom theme from the theme file.
        
        // Define the app routes for navigation.
        routes: {
          '/': (context) => LoginPage(),           // Login page as the initial route.
          '/home': (context) => const HomePage(),  // Home page route.
        },
      ),
    );
  }
}
