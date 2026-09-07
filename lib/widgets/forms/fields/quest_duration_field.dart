import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:questlog/theme/questlog_colors.dart';

class QuestDurationField extends StatelessWidget {
  QuestDurationField({super.key, required this.controller});

  final TextEditingController controller;

  final _timeFormatter = MaskTextInputFormatter(
    mask: '##:##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'Duration (HH:MM) (Optional)',
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
            keyboardType: TextInputType.number,
            inputFormatters: [_timeFormatter],
            textAlignVertical: TextAlignVertical.top,
            cursorColor: QuestLogColors.textSecondary,
            style: GoogleFonts.jetBrainsMono(
              color: QuestLogColors.textPrimary,
              fontSize: 16,
            ),
            autocorrect: false,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.timer_outlined,
                color: QuestLogColors.textSecondary,
              ),
              hintText: '00:00',
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
