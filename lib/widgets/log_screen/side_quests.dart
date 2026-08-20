import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/section_decoration.dart';

class SideQuests extends StatelessWidget {
  const SideQuests({super.key, required this.sideQuests});

  final List<SideQuest> sideQuests;

  Widget _buildHeader() {
    return Row(
      spacing: 5,
      children: [
        Icon(Icons.more_horiz, color: QuestLogColors.otherAccent, size: 16),
        Text(
          'SIDE QUESTS',
          style: GoogleFonts.jetBrainsMono(
            color: QuestLogColors.otherAccent,
            fontSize: 12,
            fontWeight: .bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSideQuest(SideQuest sideQuest) {
    return Container(
      decoration: SectionDecoration(),
      padding: EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 5,
                children: [
                  Icon(
                    Icons.circle,
                    color: QuestLogColors.otherAccent,
                    size: 10,
                  ),
                  Text(
                    sideQuest.name,
                    style: TextStyle(
                      color: QuestLogColors.textPrimary,
                      fontWeight: .bold,
                      letterSpacing: -1,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                    fontSize: 10,
                    fontWeight: .bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                sideQuest.categoryString().toUpperCase(),
                style: GoogleFonts.jetBrainsMono(fontSize: 10),
              ),
              if (sideQuest.repeatDays.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: QuestLogColors.otherAccentLessOpacity,
                    border: Border.all(
                      color: QuestLogColors.otherAccent,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    spacing: 5,
                    children: [
                      Icon(
                        Icons.history,
                        size: 12,
                        color: QuestLogColors.otherAccent,
                      ),
                      Text(
                        sideQuest.timeIntervalString()!.toUpperCase(),
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 9,
                          color: QuestLogColors.otherAccent,
                          fontWeight: .bold,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        _buildHeader(),

        for (final sideQuest in sideQuests) _buildSideQuest(sideQuest),
      ],
    );
  }
}
