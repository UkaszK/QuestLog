import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/quest_priority.dart';
import 'package:questlog/theme/questlog_colors.dart';

class MainQuestBlock extends StatelessWidget {
  const MainQuestBlock({
    super.key,
    required this.mainQuest,
    required this.onAssemble,
  });

  final MainQuest mainQuest;
  final void Function(MainQuest) onAssemble;

  Widget _buildSubTask(String subTask) {
    return Row(
      spacing: 5,
      children: [
        Icon(Icons.chevron_right, size: 16, color: QuestLogColors.accent),

        Text(
          subTask.toUpperCase(),
          style: GoogleFonts.jetBrainsMono(
            color: QuestLogColors.textPrimary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildSubTasksContainer(List<String> subTasks) {
    final limit = 3;
    bool tooLong = subTasks.length > limit;
    var updated = tooLong ? subTasks.sublist(0, 3) : subTasks;

    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: QuestLogColors.surface,
        border: Border.all(color: QuestLogColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          for (final subTask in updated) _buildSubTask(subTask),
          if (tooLong)
            Text(
              '... ${subTasks.length - limit} more',
              style: GoogleFonts.jetBrainsMono(
                color: QuestLogColors.textSecondary,
                fontSize: 10,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final priority = mainQuest.priority;
    final icon = priorityIcon(priority);
    final color = priorityColor(priority);
    final label = priorityLabel(priority);

    final dueDate = mainQuest.dueDate;

    final name = mainQuest.name;
    final durationString = mainQuest.durationText;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: QuestLogColors.accent),
          bottom: BorderSide(width: 1, color: QuestLogColors.accent),
          left: BorderSide(width: 1, color: QuestLogColors.accent),
          top: BorderSide(width: 5, color: QuestLogColors.accent),
        ),
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: QuestLogColors.accentLessOpacity,
                  border: Border.all(color: QuestLogColors.accent, width: 1),
                ),
                child: Text(
                  mainQuest.questCategory.name.toUpperCase(),
                  style: GoogleFonts.jetBrainsMono(
                    color: QuestLogColors.accent,
                    fontSize: 13,
                    fontWeight: .w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              Row(
                spacing: 5,
                children: [
                  Icon(icon, color: color, size: 12),

                  Text(
                    'PRIORITY: ${label.toUpperCase()}',
                    style: GoogleFonts.jetBrainsMono(
                      color: color,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Text(
            name,
            style: TextStyle(
              color: QuestLogColors.textPrimary,
              fontWeight: .bold,
              fontSize: 18,
            ),
          ),

          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Expanded(
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 12,
                      color: QuestLogColors.textSecondary,
                    ),
                    Text(
                      dueDate == null
                          ? 'DEADLINE: -'
                          : 'DEADLINE: ${dueDate.day}.${dueDate.month}.${dueDate.year}',
                      style: GoogleFonts.jetBrainsMono(
                        color: QuestLogColors.textSecondary,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 12,
                      color: QuestLogColors.textSecondary,
                    ),

                    Text(
                      'Duration: ${durationString}H',
                      style: GoogleFonts.jetBrainsMono(
                        color: QuestLogColors.textSecondary,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (mainQuest.subTasks.isNotEmpty)
            _buildSubTasksContainer(mainQuest.subTasks),

          TextButton(
            onPressed: () => onAssemble(mainQuest),
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(10),
              backgroundColor: QuestLogColors.accentLessOpacity,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: QuestLogColors.accent),
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: Row(
              mainAxisAlignment: .center,
              spacing: 5,
              children: [
                Icon(
                  Icons.bolt_outlined,
                  color: QuestLogColors.accent,
                  size: 20,
                ),

                Text(
                  'ASSEMBLE',
                  style: GoogleFonts.jetBrainsMono(
                    color: QuestLogColors.accent,
                    fontSize: 12,
                    fontWeight: .w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
