import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/theme/questlog_colors.dart';

class SideQuestBlock extends StatelessWidget {
  const SideQuestBlock({
    super.key,
    required this.sideQuest,
    required this.completed,
    required this.scheduledToday,
    required this.onCheckSideQuest,
  });

  final SideQuest sideQuest;
  final bool completed;
  final bool scheduledToday;
  final void Function(bool) onCheckSideQuest;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: QuestLogColors.border),
        color: QuestLogColors.surface,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: Checkbox(
              value: completed,
              onChanged: (newValue) => onCheckSideQuest(newValue ?? false),
              activeColor: QuestLogColors.otherAccent,
              side: BorderSide(color: QuestLogColors.otherAccent, width: 1),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sideQuest.name,
                  style: GoogleFonts.jetBrainsMono(
                    color: completed
                        ? QuestLogColors.textSecondary
                        : QuestLogColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    decoration: completed ? TextDecoration.lineThrough : null,
                  ),
                ),

                Text(
                  sideQuest.questCategoryName.toUpperCase(),
                  style: GoogleFonts.jetBrainsMono(
                    color: QuestLogColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          if (scheduledToday)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: QuestLogColors.otherAccent),
                color: QuestLogColors.otherAccent.withValues(alpha: 0.1),
              ),
              child: Text(
                'TODAY',
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.otherAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
