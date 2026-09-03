import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/day.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/log_screen/side_quests/side_quest_block.dart';

class SideQuests extends StatefulWidget {
  const SideQuests({
    super.key,
    required this.sideQuests,
    required this.completedSideQuestIds,
    required this.onCheckSideQuest,
  });

  final List<SideQuest> sideQuests;
  final Set<int> completedSideQuestIds;
  final void Function(SideQuest, bool) onCheckSideQuest;

  @override
  State<SideQuests> createState() => _SideQuestsState();
}

class _SideQuestsState extends State<SideQuests> {
  bool isExpanded = true;

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.checklist, color: QuestLogColors.otherAccent, size: 14),
            const SizedBox(width: 10),
            Text(
              'SIDE QUESTS',
              style: GoogleFonts.jetBrainsMono(
                color: QuestLogColors.otherAccent,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        Text(
          'UNSCHEDULED',
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
                  border: Border.all(color: QuestLogColors.otherAccent),
                  color: QuestLogColors.otherAccent.withValues(alpha: 0.1),
                ),
                child: Icon(
                  Icons.playlist_add_check,
                  color: QuestLogColors.otherAccent,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'NO SIDE QUESTS LOGGED',
                textAlign: TextAlign.center,
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.otherAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Add recurring routines, habits, or quick tasks to check off throughout the day',
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
    final today = Day.fromDateTime(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        _buildHeader(),
        Divider(height: 1),
        if (widget.sideQuests.isNotEmpty) ...[
          for (final sideQuest in widget.sideQuests)
            SideQuestBlock(
              sideQuest: sideQuest,
              completed: widget.completedSideQuestIds.contains(sideQuest.id),
              scheduledToday: sideQuest.repeatDays.contains(today),
              onCheckSideQuest: (newValue) =>
                  widget.onCheckSideQuest(sideQuest, newValue),
            ),
        ] else
          _buildEmptyBlock(),
      ],
    );
  }
}
