import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/theme/questlog_text_styles.dart';
import 'package:questlog/widgets/section_decoration.dart';

class ActiveProtocol extends StatelessWidget {
  const ActiveProtocol({super.key, required this.activeQuest});

  final AssemblerQuest activeQuest;

  Widget _buildSubTask(SubTask subTask) {
    return Container(
      width: .infinity,
      decoration: SectionDecoration(),
      child: Row(
        children: [
          SizedBox(
            width: 36,
            height: 36,
            child: Checkbox(
              value: subTask.completed,
              onChanged: (value) {},
              activeColor: QuestLogColors.accent,
            ),
          ),

          Text(
            subTask.name,
            style: TextStyle(
              color: subTask.completed
                  ? QuestLogColors.textSecondary
                  : QuestLogColors.textPrimary,
              decoration: subTask.completed
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPending = activeQuest.status == .pending;
    final subTasks = activeQuest.questInfo.subTasks;
    final hasSubTasks = subTasks.isNotEmpty;

    return Container(
      width: .infinity,
      padding: EdgeInsets.all(15),
      decoration: SectionDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ACTIVE PROTOCOL', style: QuestLogTextStyles.headerText),

          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                activeQuest.questInfo.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  color: QuestLogColors.textPrimary,
                  letterSpacing: -1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                activeQuest.timeLabel(),
                style: QuestLogTextStyles.normalText,
              ),
            ],
          ),

          if (isPending)
            Container(
              margin: EdgeInsets.only(top: 3, bottom: 10),
              child: Row(
                crossAxisAlignment: .center,
                spacing: 5,
                children: [
                  Icon(Icons.warning, size: 14, color: QuestLogColors.warning),
                  Text(
                    'VIEWING PAST ROUNTINE - PENDING VALIDATION',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      color: QuestLogColors.warning,
                    ),
                  ),
                ],
              ),
            ),

          if (hasSubTasks)
            Column(
              spacing: 10,
              children: [
                for (final subTask in subTasks) _buildSubTask(subTask),
              ],
            ),

          SizedBox(
            width: .infinity,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: QuestLogColors.accentLessOpacity,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: QuestLogColors.accent),
                  borderRadius: BorderRadius.zero,
                ),
              ),

              child: Text(
                'COMPLETE',
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.accent,
                  fontSize: 12,
                  fontWeight: .w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
