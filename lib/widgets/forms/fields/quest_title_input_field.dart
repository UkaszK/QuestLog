import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';

class QuestTitleInputField extends StatelessWidget {
  const QuestTitleInputField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'Quest Title',
          style: GoogleFonts.jetBrainsMono(
            color: QuestLogColors.textSecondary,
            fontSize: 12,
          ),
        ),

        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: QuestLogColors.textSecondary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: controller,
            maxLength: 25,
            style: GoogleFonts.jetBrainsMono(
              color: QuestLogColors.textPrimary,
              fontSize: 16,
            ),
            autocorrect: false,
            cursorColor: QuestLogColors.textSecondary,
            decoration: InputDecoration(
              counterText: '',
              hintText: 'Enter quest title...',
              hintStyle: GoogleFonts.jetBrainsMono(
                color: QuestLogColors.textSecondary,
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
