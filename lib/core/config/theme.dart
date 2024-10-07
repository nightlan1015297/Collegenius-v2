import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CollegeniusTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xff1e1e1e),
      
      // App bar theme
      appBarTheme: const AppBarTheme(
        color: Color(0xff3d3d3d),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: const Color(0xff3d3d3d),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // Text Theme
      fontFamily: GoogleFonts.roboto().fontFamily,
      textTheme: const TextTheme().copyWith(
      bodySmall: const TextStyle(color: Colors.white),
      bodyMedium: const TextStyle(color: Colors.white),
      bodyLarge: const TextStyle(color: Colors.white),
      labelSmall: const TextStyle(color: Colors.white),
      labelMedium: const TextStyle(color: Colors.white),
      labelLarge: const TextStyle(color: Colors.white),
      displaySmall: const TextStyle(color: Colors.white),
      displayMedium: const TextStyle(color: Colors.white),
      displayLarge: const TextStyle(color: Colors.white),
      titleLarge: const TextStyle(color: Colors.white),
      titleMedium: const TextStyle(color: Colors.white),
      titleSmall: const TextStyle(color: Colors.white),
      ),

    // icon theme
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),

    // input decorations
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.white),
      hintStyle: const TextStyle(color: Colors.white),
      errorStyle: const TextStyle(color: Colors.red),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.white,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.white,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.white,
        ),
      ),
    ),

    elevatedButtonTheme:  ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 95, 199, 255)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
      )
    );
  }
}