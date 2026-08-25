import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';

class QuestLogAppBar extends AppBar {
  QuestLogAppBar({super.key})
    : super(
        title: const Text('QUESTLOG'),
        titleTextStyle: GoogleFonts.jetBrainsMono(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          shadows: const [Shadow(color: QuestLogColors.accent, blurRadius: 24)],
        ),
        centerTitle: true,
        backgroundColor: QuestLogColors.surface,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: QuestLogColors.border),
        ),
      );
}
