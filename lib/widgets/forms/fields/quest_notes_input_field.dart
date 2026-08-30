import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/theme/questlog_text_styles.dart';

class QuestNotesInputField extends StatelessWidget {
  const QuestNotesInputField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text('Quest Title', style: QuestLogTextStyles.headerText),

        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: QuestLogColors.textSecondary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: controller,
            maxLength: 100,
            minLines: 5,
            maxLines: 5,
            textAlignVertical: TextAlignVertical.top,
            cursorColor: QuestLogColors.textSecondary,
            style: GoogleFonts.jetBrainsMono(
              color: QuestLogColors.textPrimary,
              fontSize: 16,
            ),
            autocorrect: false,
            decoration: InputDecoration(
              counterText: '',
              hintText: 'Add notes here...',
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
