import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';

class QuestLogTextStyles {
  static final TextStyle headerText = GoogleFonts.jetBrainsMono(
    fontSize: 12,
    color: QuestLogColors.textSecondary,
  );
  static final TextStyle normalText = GoogleFonts.jetBrainsMono(
    fontSize: 10,
    color: QuestLogColors.textPrimary,
  );
}
