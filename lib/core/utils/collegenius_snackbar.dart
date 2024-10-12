import 'package:flutter/material.dart';

/// Displays a custom snackbar using a modal bottom sheet.
/// 
/// [context] - The build context to display the snackbar.
/// [message] - The message to be displayed in the snackbar.
void collegeniusSnackBar(BuildContext context, String message) {
  final theme = Theme.of(context);
  
  showModalBottomSheet<void>(
    backgroundColor: Colors.transparent,
    context: context,
    barrierColor: Colors.transparent, // Keep the barrier color fully transparent
    builder: (BuildContext context) {
      // Automatically close the snackbar after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      });

      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xff5e5e5e), // Border color for the snackbar
              width: 2,
            ),
            color: theme.canvasColor, // Use the current theme's canvas color
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(12),
          child: Text(
            message,
            style: theme.textTheme.bodyMedium, // Apply consistent text styling from the theme
          ),
        ),
      );
    },
  );
}