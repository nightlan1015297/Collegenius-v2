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
        bodySmall: const TextStyle(
            color: Colors.white, overflow: TextOverflow.ellipsis),
        bodyMedium: const TextStyle(
            color: Colors.white, overflow: TextOverflow.ellipsis),
        bodyLarge: const TextStyle(
            color: Colors.white, overflow: TextOverflow.ellipsis),
        labelSmall: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis),
        labelMedium: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis),
        labelLarge: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis),
        displaySmall: const TextStyle(
            color: Colors.white, overflow: TextOverflow.ellipsis),
        displayMedium: const TextStyle(
            color: Colors.white, overflow: TextOverflow.ellipsis),
        displayLarge: const TextStyle(
            color: Colors.white, overflow: TextOverflow.ellipsis),
        titleLarge: const TextStyle(
            color: Colors.white, overflow: TextOverflow.ellipsis),
        titleMedium: const TextStyle(
            color: Colors.white, overflow: TextOverflow.ellipsis),
        titleSmall: const TextStyle(
            color: Colors.white, overflow: TextOverflow.ellipsis),
      ),

      // icon theme
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),

      // input decorations
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(fontSize: 15, color: Colors.grey),
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
              const Color.fromARGB(255, 95, 199, 255)),
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
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey; // Disabled color
            }
            return const Color.fromARGB(166, 33, 149, 243); // Regular color
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return const Color.fromARGB(255, 94, 94, 94); // Disabled color
            }
            return Colors.white; // Regular color
          }),
          side: WidgetStateBorderSide.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return const BorderSide(color: Colors.grey); // Disabled color
            }
            return const BorderSide(color: Colors.blue); // Regular color
          }),
          shadowColor: WidgetStateProperty.all<Color>(Colors.white),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          textStyle: WidgetStateProperty.all<TextStyle>(
            const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
      drawerTheme: const DrawerThemeData(
        elevation: 1,
        backgroundColor: Color(0xff3d3d3d),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: const Color(0xff3d3d3d),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        iconColor: Colors.white,
        textColor: Colors.white,
        minLeadingWidth: 50,
        minTileHeight: 45,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }
}
