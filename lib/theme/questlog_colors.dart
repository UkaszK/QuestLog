import 'package:flutter/material.dart';

/// Centralized app color constants.
/// Use these throughout the app instead of hardcoding colors,
/// so the theme can be easily adjusted from a single place.
class QuestLogColors {
  // Brand colors
  // static const Color primary = Color(0xFF6C63FF);
  // static const Color secondary = Color(0xFF03DAC6);
  static const Color accent = Color.fromARGB(255, 111, 238, 252);

  // Neutral colors
  static const Color background = Color(0xFF131718);
  static const Color border = Color.fromARGB(255, 53, 53, 52);
  static const Color surface = Color.fromARGB(255, 28, 27, 27);
  // static const Color error = Color(0xFFB00020);

  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
  // static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Status colors
  static const Color success = Color.fromARGB(255, 165, 214, 167);
  static const Color warning = Color.fromARGB(255, 244, 183, 174);
  static const Color danger = Colors.red;
  static const Color info = Color(0xFF2196F3);
}
