import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/quest.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/theme/questlog_text_styles.dart';
import 'package:questlog/widgets/section_decoration.dart';

class ActiveProtocol extends StatelessWidget {
  const ActiveProtocol({super.key, required this.activeQuest});

  final Quest activeQuest;

  @override
  Widget build(BuildContext context) {
    final isPending = activeQuest.status == .pending;

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
                activeQuest.name.toUpperCase(),
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

          Column(
            spacing: 10,
            children: [
              for (final key in activeQuest.subTasks.keys)
                Container(
                  width: .infinity,
                  decoration: SectionDecoration(),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: Checkbox(
                          value: activeQuest.subTasks[key],
                          onChanged: (value) {},
                          activeColor: QuestLogColors.accent,
                        ),
                      ),

                      Text(
                        key,
                        style: TextStyle(
                          color: activeQuest.subTasks[key] == true
                              ? QuestLogColors.textSecondary
                              : QuestLogColors.textPrimary,
                          decoration: activeQuest.subTasks[key] == true
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}