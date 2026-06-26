import 'package:flutter/material.dart';

/// Centralized color palette configuration.
class AppColors {
  AppColors._();

  // Primary & Accent Brand Colors (Classic Blue & Brand Orange Palette)
  static const Color primary = Color(0xFF2D59D6); // Classic Blue
  static const Color secondary = Color(0xFF13235B); // Deep Navy
  static const Color accent = Color(0xFFF97316); // Brand Orange
  static const Color brand2 = Color(0xFF5B85F5); // Brand Blue Lighter
  static const Color brandSoft = Color(0xFFEAF0FF); // Light Blue Soft Highlight

  // Light Theme background & surfaces
  static const Color lightBackground = Color(0xFFF4F6FB); // Clean grey-blue bg
  static const Color lightSurface = Color(0xFFFFFFFF);

  // Dark Theme background & surfaces
  static const Color darkBackground = Color(0xFF101729); // Ink background
  static const Color darkSurface = Color(0xFF1E293B);

  // Status & Utility Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF16A06A); // Green checkmark / WhatsApp green
  static const Color successSoft = Color(0xFFE3F6EE); // Green success soft bg
  static const Color warning = Color(0xFFF5A623); // Amber/Orange star rating

  // Text Colors
  static const Color darkText = Color(0xFF101729); // Ink text for headings
  static const Color darkTextSecondary = Color(0xFF697089); // Muted slate text
  static const Color lightText = Color(0xFFF1F3F4);
  static const Color lightTextSecondary = Color(0xFF9AA0A6);

  // Line / Border Color
  static const Color line = Color(0xFFE7EAF2);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
