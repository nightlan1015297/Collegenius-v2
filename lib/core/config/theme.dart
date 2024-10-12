import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class defining the theme of the Collegenius application.
///
/// This class provides a customized [ThemeData] that sets the overall look
/// and feel of the application, including colors, fonts, and widget styles.
class CollegeniusTheme {
  static ThemeData get theme {
    return ThemeData(
      // Background color for the main scaffold
      scaffoldBackgroundColor: const Color(0xff1e1e1e),

      // Background color for material widgets
      canvasColor: const Color(0xff3d3d3d),

      // AppBar styling
      appBarTheme: const AppBarTheme(
        color: Color(0xff3d3d3d),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),

      // Card widget styling
      cardTheme: CardTheme(
        color: const Color(0xff3d3d3d),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // Text theme for the application using Google Fonts
      fontFamily: GoogleFonts.roboto().fontFamily,
      textTheme: const TextTheme().copyWith(
        bodySmall: const TextStyle(
          color: Colors.white, 
          overflow: TextOverflow.ellipsis,
        ),
        bodyMedium: const TextStyle(
          color: Colors.white, 
          overflow: TextOverflow.ellipsis,
        ),
        bodyLarge: const TextStyle(
          color: Colors.white, 
          overflow: TextOverflow.ellipsis,
        ),
        labelSmall: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
        labelMedium: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
        labelLarge: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
        displaySmall: const TextStyle(
          color: Colors.white, 
          overflow: TextOverflow.ellipsis,
        ),
        displayMedium: const TextStyle(
          color: Colors.white, 
          overflow: TextOverflow.ellipsis,
        ),
        displayLarge: const TextStyle(
          color: Colors.white, 
          overflow: TextOverflow.ellipsis,
        ),
        titleLarge: const TextStyle(
          color: Colors.white, 
          overflow: TextOverflow.ellipsis,
        ),
        titleMedium: const TextStyle(
          color: Colors.white, 
          overflow: TextOverflow.ellipsis,
        ),
        titleSmall: const TextStyle(
          color: Colors.white, 
          overflow: TextOverflow.ellipsis,
        ),
      ),

      // Icon theme styling
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),

      // Text selection styling (e.g., cursor and selection color)
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: Color(0xff3d3d3d),
      ),

      // Input decoration (used for text fields)
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

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          textStyle: WidgetStateProperty.all<TextStyle>(
            const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey; // Disabled color
            }
            return Colors.blue; // Regular color
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return const Color.fromARGB(255, 94, 94, 94); // Disabled color
            }
            return Colors.white; // Regular color
          }),
          side: WidgetStateProperty.resolveWith((states) {
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

      // Drawer theme styling
      drawerTheme: const DrawerThemeData(
        elevation: 1,
        backgroundColor: Color(0xff3d3d3d),
      ),

      // ListTile theme for styling ListTiles across the app
      listTileTheme: ListTileThemeData(
        tileColor: const Color(0xff3d3d3d),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        iconColor: Colors.white,
        textColor: Colors.white,
        minLeadingWidth: 50,
        minVerticalPadding: 0,
        horizontalTitleGap: 8.0,
        style: ListTileStyle.drawer,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
      ),

      // Button theme (used for legacy button widgets)
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blue,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        alignedDropdown: false,
      ),
    );
  }
}
