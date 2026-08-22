import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssemblerTitle extends StatelessWidget {
  const AssemblerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'ASSEMBLER',
      style: GoogleFonts.jetBrainsMono(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
