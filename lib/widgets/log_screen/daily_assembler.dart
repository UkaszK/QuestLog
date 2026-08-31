import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/theme/questlog_text_styles.dart';

class DailyAssembler extends StatelessWidget {
  const DailyAssembler({
    super.key,
    required this.assemblerQuests,
    required this.onCompleteQuest,
  });

  final List<AssemblerQuest> assemblerQuests;
  final void Function(AssemblerQuest) onCompleteQuest;

  Widget _buildHeader() {
    return Text('DAILY ASSEMBLER', style: QuestLogTextStyles.headerText);
  }

  Widget _buildQuestsContainer(List<AssemblerQuest> quests) {
    return SingleChildScrollView(
      physics: ScrollPhysics(parent: ClampingScrollPhysics()),
      scrollDirection: Axis.horizontal,
      child: IntrinsicHeight(
        child: Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [for (final data in quests) _buildQuestContainer(data)],
        ),
      ),
    );
  }

  Widget _buildQuestContainer(AssemblerQuest assemblerQuest) {
    final isPendingOrCompleted =
        assemblerQuest.status == QuestStatus.pending ||
        assemblerQuest.status == QuestStatus.completed;
    final questColor = assemblerQuest.status.color;

    return Ink(
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: QuestLogColors.border),
        color: QuestLogColors.surface,
      ),
      child: InkWell(
        onTap: () => onCompleteQuest(assemblerQuest),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            spacing: 3,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(assemblerQuest.questInfo.questCategory.icon),

                  Icon(Icons.circle, color: questColor, size: 10),
                ],
              ),
              Column(
                spacing: 3,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assemblerQuest.timeLabel,
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
        ),
      ),
    );
  }

  Widget _buildEmptyContainer() {
    return Container(
      alignment: AlignmentGeometry.center,
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: QuestLogColors.border),
      ),
      child: Column(
        spacing: 10,
        children: [
          Text(
            'NO ACTIVE ROUTINES',
            style: GoogleFonts.jetBrainsMono(
              color: QuestLogColors.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 2,
            ),
          ),

          Text(
            'INITIALIZE YOUR DAY IN THE ASSEMBLER',
            textAlign: TextAlign.center,
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
    final sortedQuests = List<AssemblerQuest>.from(assemblerQuests)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          sortedQuests.isNotEmpty
              ? _buildQuestsContainer(sortedQuests)
              : _buildEmptyContainer(),
        ],
      ),
    );
  }
}
