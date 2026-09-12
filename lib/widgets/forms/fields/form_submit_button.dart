import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';

class FormSubmitButton extends StatelessWidget {
  const FormSubmitButton({
    super.key,
    required this.onSubmit,
    this.disabled = false,
    this.primaryColor = QuestLogColors.accent,
  });

  final VoidCallback onSubmit;
  final bool disabled;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onSubmit,
      child: Container(
        padding: EdgeInsets.all(16),
        color: disabled ? primaryColor.withValues(alpha: 0.3) : primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Icon(Icons.power_settings_new, color: QuestLogColors.black),

            Text(
              'SAVE',
              style: GoogleFonts.jetBrainsMono(
                color: QuestLogColors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
