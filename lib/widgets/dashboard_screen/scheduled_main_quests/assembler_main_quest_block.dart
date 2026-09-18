import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/assembler_main_quest.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/theme/quest_log_colors.dart';
import 'package:questlog/widgets/reusables/quest_log_badge.dart';

class AssemblerMainQuestBlock extends StatelessWidget {
  const AssemblerMainQuestBlock({
    super.key,
    required this.assemblerQuest,
    required this.onCheckQuest,
    required this.onCheckSubTask,
  });

  final AssemblerMainQuest assemblerQuest;
  final void Function(bool) onCheckQuest;
  final void Function(SubTask, bool) onCheckSubTask;

  Widget _buildSubTask(SubTask subTask) {
    final checked = subTask.completed;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: Checkbox(
            value: checked,
            onChanged: (newValue) => onCheckSubTask(subTask, newValue ?? false),
            activeColor: QuestLogColors.otherAccent,
            side: BorderSide(color: QuestLogColors.border, width: 1),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            subTask.name,
            softWrap: true,
            style: GoogleFonts.jetBrainsMono(
              color: checked
                  ? QuestLogColors.textSecondary
                  : QuestLogColors.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              decoration: checked ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final questStatus = assemblerQuest.status;
    final statusColor = questStatus.color;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: statusColor),
        color: QuestLogColors.surface,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: assemblerQuest.completed,
                      onChanged: (value) => onCheckQuest(value ?? false),
                      side: BorderSide(color: statusColor),
                      activeColor: QuestLogColors.accent,
                      checkColor: QuestLogColors.black,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            assemblerQuest.timeTextOneLine,
                            style: GoogleFonts.jetBrainsMono(
                              color: QuestLogColors.textPrimary,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(width: 10),

                          Text(
                            assemblerQuest.questCategoryName.toUpperCase(),
                            style: GoogleFonts.jetBrainsMono(
                              color: QuestLogColors.textSecondary,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        assemblerQuest.name,
                        style: GoogleFonts.jetBrainsMono(
                          color: QuestLogColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight(1000),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              QuestLogBadge(
                label: questStatus.label.toUpperCase(),
                primaryColor: statusColor,
              ),
            ],
          ),

          if (assemblerQuest.subTasks.isNotEmpty) ...[
            Divider(color: QuestLogColors.border),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
              child: Column(
                spacing: 10,
                children: [
                  for (final subTask in assemblerQuest.subTasks) ...[
                    _buildSubTask(subTask),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
