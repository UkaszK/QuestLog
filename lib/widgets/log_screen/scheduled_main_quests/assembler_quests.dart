import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/utils/get_time_text.dart';
import 'package:questlog/widgets/log_screen/scheduled_main_quests/assembler_quest_block.dart';

class AssemblerQuests extends StatefulWidget {
  const AssemblerQuests({
    super.key,
    required this.assemblerQuests,
    required this.onCheckQuest,
    required this.onCheckSubTask,
  });

  final List<AssemblerMainQuest> assemblerQuests;
  final void Function(AssemblerMainQuest, bool) onCheckQuest;
  final void Function(AssemblerMainQuest, SubTask, bool) onCheckSubTask;

  @override
  State<AssemblerQuests> createState() => _AssemblerQuestsState();
}

class _AssemblerQuestsState extends State<AssemblerQuests> {
  Widget _buildHeader(String? timelineText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, color: QuestLogColors.accent, size: 14),

            const SizedBox(width: 10),

            Text(
              'SCHEDULED MAIN QUESTS',
              style: GoogleFonts.jetBrainsMono(
                color: QuestLogColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        Text(
          'TIMELINE (${timelineText ?? '-'})',
          style: GoogleFonts.jetBrainsMono(
            color: QuestLogColors.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyBlock() {
    return Container(
      color: QuestLogColors.surface,
      child: DottedBorder(
        options: RectDottedBorderOptions(
          strokeWidth: 1,
          color: QuestLogColors.border,
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                alignment: AlignmentGeometry.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: QuestLogColors.accent),
                  color: QuestLogColors.accent.withValues(alpha: 0.1),
                ),
                child: Icon(
                  Icons.radar,
                  color: QuestLogColors.accent,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'NO SCHEDULED QUESTS FOR TODAY',
                textAlign: TextAlign.center,
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Build your daily timeline in the Assembler',
                textAlign: TextAlign.center,
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime? timelineStart;
    DateTime? timelineEnd;
    String? timelineText;

    if (widget.assemblerQuests.isNotEmpty) {
      timelineStart = widget.assemblerQuests
          .map((aq) => aq.startTime)
          .reduce((a, b) => a.isBefore(b) ? a : b);
      timelineEnd = widget.assemblerQuests
          .map((aq) => aq.endTime)
          .reduce((a, b) => a.isAfter(b) ? a : b);
    }

    if (timelineStart != null && timelineEnd != null) {
      timelineText = getTimeText(timelineStart, timelineEnd, false);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        _buildHeader(timelineText),

        Divider(height: 1),

        if (widget.assemblerQuests.isNotEmpty) ...[
          for (final assemblerQuest in widget.assemblerQuests)
            AssemblerQuestBlock(
              assemblerQuest: assemblerQuest,
              onCheckQuest: (newValue) =>
                  widget.onCheckQuest(assemblerQuest, newValue),
              onCheckSubTask: (subTask, newValue) =>
                  widget.onCheckSubTask(assemblerQuest, subTask, newValue),
            ),
        ] else
          _buildEmptyBlock(),
      ],
    );
  }
}
