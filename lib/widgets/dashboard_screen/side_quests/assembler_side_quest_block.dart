import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/theme/quest_log_colors.dart';
import 'package:questlog/widgets/reusables/quest_log_badge.dart';

class AssemblerSideQuestBlock extends StatelessWidget {
  const AssemblerSideQuestBlock({
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
    String? timeIntervalString = sideQuest.timeIntervalString();

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: QuestLogColors.border),
        color: QuestLogColors.surface,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.jetBrainsMono(
                    color: completed
                        ? QuestLogColors.textSecondary
                        : QuestLogColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    decoration: completed ? TextDecoration.lineThrough : null,
                  ),
                ),

                const SizedBox(height: 3),

                Row(
                  children: [
                    Flexible(
                      child: Text(
                        sideQuest.questCategoryName.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.jetBrainsMono(
                          color: QuestLogColors.textSecondary,
                          fontSize: 8,
                        ),
                      ),
                    ),
                    if (timeIntervalString != null) ...[
                      const SizedBox(width: 5),

                      QuestLogBadge(
                        label: timeIntervalString.toUpperCase(),
                        primaryColor: QuestLogColors.otherAccent,
                        borderColor: QuestLogColors.otherAccentLessOpacity,
                        padding: EdgeInsets.symmetric(horizontal: 2),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          if (scheduledToday) ...[
            QuestLogBadge(
              label: 'TODAY',
              primaryColor: QuestLogColors.otherAccent,
            ),
          ],
        ],
      ),
    );
  }
}
