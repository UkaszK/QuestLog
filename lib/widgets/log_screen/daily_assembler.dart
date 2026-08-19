import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/constants/themed_colors.dart';
import 'package:questlog/data/quest.dart';

class DailyAssembler extends StatelessWidget {
  const DailyAssembler({super.key, required this.quests});

  final List<Quest> quests;

  Widget buildQuestContainer(Quest quest) {
    final isPendingOrCompleted =
        quest.status == QuestStatus.pending ||
        quest.status == QuestStatus.completed;
    final questColor = Quest.statusColor(quest.status);

    return Container(
      width: 100,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: ThemedColors.border, width: 1),
        borderRadius: BorderRadius.circular(2),
        color: ThemedColors.surface,
      ),
      child: Column(
        spacing: 3,
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 20,
            mainAxisAlignment: .spaceBetween,
            children: [
              Icon(quest.icon),

              Icon(Icons.circle, color: questColor, size: 10),
            ],
          ),
          Column(
            spacing: 3,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quest.timeLabel(),
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 12,
                  color: isPendingOrCompleted
                      ? questColor
                      : ThemedColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                quest.name,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: ThemedColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DAILY ASSEMBLER',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: ThemedColors.textSecondary,
            ),
          ),
          SingleChildScrollView(
            physics: ScrollPhysics(parent: ClampingScrollPhysics()),
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final data in quests) buildQuestContainer(data),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
