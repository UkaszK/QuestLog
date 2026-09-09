import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/theme/questlog_colors.dart';

class AssemblerMainQuestBlock extends StatelessWidget {
  const AssemblerMainQuestBlock({
    super.key,
    required this.mainQuest,
    required this.onAssemble,
  });

  final MainQuest mainQuest;
  final void Function(MainQuest) onAssemble;

  Color get dueTextColor {
    final dueDate = mainQuest.dueDate;

    if (dueDate == null) {
      return QuestLogColors.textSecondary;
    }

    if (DateUtils.isSameDay(dueDate, DateTime.now())) {
      return QuestLogColors.info;
    }

    if (dueDate.isBefore(DateTime.now())) {
      return QuestLogColors.warning;
    }

    return QuestLogColors.textSecondary;
  }

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
    final icon = priority.icon;
    final color = priority.color;
    final label = priority.label;

    final name = mainQuest.name;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    fontWeight: FontWeight.w800,
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
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(Icons.calendar_today, size: 12, color: dueTextColor),
                    Text(
                      'DEADLINE: ${mainQuest.dueText}',
                      style: GoogleFonts.jetBrainsMono(
                        color: dueTextColor,
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                    fontWeight: FontWeight.w900,
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
