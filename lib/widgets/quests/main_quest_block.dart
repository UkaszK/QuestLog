import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/quest_priority.dart';
import 'package:questlog/theme/quest_log_colors.dart';
import 'package:questlog/widgets/quests/quest_container.dart';
import 'package:questlog/widgets/reusables/quest_log_badge.dart';

class MainQuestBlock extends StatelessWidget {
  const MainQuestBlock({super.key, required this.mainQuest, this.footer});

  final MainQuest mainQuest;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return QuestContainer(
      color: QuestLogColors.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  QuestLogBadge(
                    label: 'MAIN QUEST',
                    primaryColor: QuestLogColors.accent,
                  ),

                  if (mainQuest.priority == QuestPriority.high) ...[
                    const SizedBox(width: 5),

                    QuestLogBadge(
                      label: mainQuest.priority.label.toUpperCase(),
                      primaryColor: mainQuest.priority.color,
                      prefixIcon: mainQuest.priority.icon,
                    ),
                  ],
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: QuestLogColors.accent,
                    size: 10,
                  ),

                  const SizedBox(width: 5),

                  Text(
                    'DUE: ${mainQuest.dueText}',
                    style: GoogleFonts.jetBrainsMono(
                      color: QuestLogColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            mainQuest.name,
            style: GoogleFonts.jetBrainsMono(
              color: QuestLogColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight(1000),
            ),
          ),

          if (mainQuest.subTasks.isNotEmpty) ...[
            const SizedBox(height: 10),

            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: QuestLogColors.black,
                border: Border.all(color: QuestLogColors.border, width: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(
                          Icons.checklist,
                          size: 14,
                          color: QuestLogColors.accent,
                        ),
                      ),

                      const SizedBox(width: 5),

                      Text(
                        'SUB-TASKS',
                        style: GoogleFonts.jetBrainsMono(
                          color: QuestLogColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  for (final subTask in mainQuest.subTasks) ...[
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Icon(
                            Icons.chevron_right,
                            color: QuestLogColors.accent,
                            size: 14,
                          ),
                        ),

                        const SizedBox(width: 5),

                        Text(
                          subTask,
                          style: GoogleFonts.jetBrainsMono(
                            color: QuestLogColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],

          if (footer != null) ...[
            const SizedBox(height: 10),
            Divider(height: 1),
            const SizedBox(height: 5),
            footer!,
          ],
        ],
      ),
    );
  }
}
