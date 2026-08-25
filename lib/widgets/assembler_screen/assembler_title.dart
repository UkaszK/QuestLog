import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssemblerTitle extends StatelessWidget {
  const AssemblerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ASSEMBLER',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
