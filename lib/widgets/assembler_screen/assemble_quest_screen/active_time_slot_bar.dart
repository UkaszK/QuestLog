import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';

class ActiveTimeSlotBar extends StatelessWidget {
  const ActiveTimeSlotBar({
    super.key,
    required this.timeSlotText,
    required this.onReset,
  });

  final String timeSlotText;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: QuestLogColors.surface,
        border: const Border(
          bottom: BorderSide(width: 1, color: QuestLogColors.accent),
        ),
        boxShadow: [
          BoxShadow(
            color: QuestLogColors.accent.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.schedule,
                  size: 16,
                  color: QuestLogColors.accent,
                ),
                const SizedBox(width: 8),
                Text(
                  'SLOT: $timeSlotText',
                  style: GoogleFonts.jetBrainsMono(
                    color: QuestLogColors.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            InkWell(
              onTap: onReset,
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: QuestLogColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
