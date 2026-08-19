import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/constants/themed_colors.dart';

class QuestLogAppBar extends AppBar {
  QuestLogAppBar({super.key})
    : super(
        title: const Text('QUESTLOG'),
        titleTextStyle: GoogleFonts.jetBrainsMono(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          shadows: const [Shadow(color: ThemedColors.accent, blurRadius: 24)],
        ),
        centerTitle: true,
        backgroundColor: ThemedColors.background,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: ThemedColors.border),
        ),
      );
}
