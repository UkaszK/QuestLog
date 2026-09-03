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
  bool _showTodayOnly = false;

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.checklist,
                color: QuestLogColors.otherAccent,
                size: 14,
              ),
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
        ),

        SegmentedButton<bool>(
          segments: const [
            ButtonSegment(value: false, label: Text('ALL')),
            ButtonSegment(value: true, label: Text('TODAY')),
          ],
          selected: {_showTodayOnly},
          showSelectedIcon: false,
          style: ButtonStyle(
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
            ),
            visualDensity: VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            textStyle: WidgetStatePropertyAll(
              GoogleFonts.jetBrainsMono(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          onSelectionChanged: (selection) {
            setState(() => _showTodayOnly = selection.first);
          },
        ),
      ],
    );
  }

  Widget _buildEmptyBlock({required bool hasSideQuests}) {
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
                hasSideQuests
                    ? 'NO SIDE QUESTS DUE TODAY'
                    : 'NO SIDE QUESTS LOGGED',
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
                hasSideQuests
                    ? 'Switch to all side quests to view your other recurring routines and tasks'
                    : 'Add recurring routines, habits, or quick tasks to check off throughout the day',
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
    final displayedSideQuests = _showTodayOnly
        ? widget.sideQuests
              .where((sideQuest) => sideQuest.repeatDays.contains(today))
              .toList()
        : widget.sideQuests;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 5),
        Divider(height: 1),
        if (displayedSideQuests.isNotEmpty) ...[
          for (final sideQuest in displayedSideQuests) ...[
            const SizedBox(height: 10),
            SideQuestBlock(
              sideQuest: sideQuest,
              completed: widget.completedSideQuestIds.contains(sideQuest.id),
              scheduledToday: sideQuest.repeatDays.contains(today),
              onCheckSideQuest: (newValue) =>
                  widget.onCheckSideQuest(sideQuest, newValue),
            ),
          ],
        ] else ...[
          const SizedBox(height: 10),
          _buildEmptyBlock(hasSideQuests: widget.sideQuests.isNotEmpty),
        ],
      ],
    );
  }
}
