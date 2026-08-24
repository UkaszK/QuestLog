import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/theme/questlog_text_styles.dart';
import 'package:questlog/widgets/section_decoration.dart';
import 'package:questlog/utils/quest_category_icon.dart';

class DailyAssembler extends StatelessWidget {
  const DailyAssembler({super.key, required this.assemblerQuests});

  final List<AssemblerQuest> assemblerQuests;

  Widget _buildHeader() {
    return Text('DAILY ASSEMBLER', style: QuestLogTextStyles.headerText);
  }

  Widget _buildQuestContainer(AssemblerQuest assemblerQuest) {
    final isPendingOrCompleted =
        assemblerQuest.status == QuestStatus.pending ||
        assemblerQuest.status == QuestStatus.completed;
    final questColor = assemblerQuest.statusColor;

    return Container(
      width: 100,
      padding: EdgeInsets.all(10),
      decoration: SectionDecoration(),
      child: Column(
        spacing: 3,
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 20,
            mainAxisAlignment: .spaceBetween,
            children: [
              Icon(
                getQuestCategoryIcon(assemblerQuest.questInfo.questCategory),
              ),

              Icon(Icons.circle, color: questColor, size: 10),
            ],
          ),
          Column(
            spacing: 3,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                assemblerQuest.timeLabel(),
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 12,
                  color: isPendingOrCompleted
                      ? questColor
                      : QuestLogColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                assemblerQuest.questInfo.name,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: QuestLogColors.textPrimary,
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
    final sortedQuests = List<AssemblerQuest>.from(assemblerQuests)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),

          SingleChildScrollView(
            physics: ScrollPhysics(parent: ClampingScrollPhysics()),
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final data in sortedQuests) _buildQuestContainer(data),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
