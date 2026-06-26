import 'package:flutter/material.dart';

/// Extension methods on [BuildContext] to simplify layout, themes, and navigation code.
extension ContextExtensions on BuildContext {
  // Theme Shortcuts
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  // Screen Shortcuts
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Standard implementation of snackbar alert.
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(
              color: isError ? Colors.white : theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: isError ? theme.colorScheme.error : theme.colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
  }
}
