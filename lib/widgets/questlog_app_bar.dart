import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestLogAppBar extends AppBar {
  QuestLogAppBar({super.key})
    : super(
        title: const Text('QUESTLOG'),
        titleTextStyle: GoogleFonts.jetBrainsMono(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          shadows: const [Shadow(color: Colors.cyan, blurRadius: 24)],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF131718),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFF4B4F52)),
        ),
      );
}
