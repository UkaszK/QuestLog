import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/section_decoration.dart';

class SideQuests extends StatefulWidget {
  const SideQuests({super.key, required this.sideQuests});

  final List<SideQuest> sideQuests;

  @override
  State<SideQuests> createState() => _SideQuestsState();
}

class _SideQuestsState extends State<SideQuests> {
  bool isExpanded = false;

  Widget _buildHeader() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 5,
            children: [
              Icon(
                Icons.more_horiz,
                color: QuestLogColors.otherAccent,
                size: 16,
              ),
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

          AnimatedRotation(
            turns: isExpanded ? 0 : 0.5,
            duration: Duration(milliseconds: 200),
            child: Icon(Icons.arrow_drop_down),
          ),
        ],
      ),
    );
  }

  Widget _buildSideQuest(SideQuest sideQuest) {
    final isRepetitive = sideQuest.repeatDays.isNotEmpty;

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
                      fontWeight: FontWeight.bold,
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
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sideQuest.questCategory.name.toUpperCase(),
                style: GoogleFonts.jetBrainsMono(fontSize: 10),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: QuestLogColors.otherAccentLessOpacity,
                  border: Border.all(
                    color: isRepetitive
                        ? QuestLogColors.otherAccent
                        : QuestLogColors.textSecondary,
                    width: 1,
                  ),
                ),
                child: Row(
                  spacing: 5,
                  children: [
                    if (isRepetitive)
                      Icon(
                        Icons.history,
                        size: 12,
                        color: QuestLogColors.otherAccent,
                      ),
                    Text(
                      isRepetitive
                          ? sideQuest.timeIntervalString()!.toUpperCase()
                          : 'JUST ONCE',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 9,
                        color: isRepetitive
                            ? QuestLogColors.otherAccent
                            : QuestLogColors.textSecondary,
                        fontWeight: FontWeight.bold,
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
      spacing: 15,
      children: [
        _buildHeader(),

        AnimatedCrossFade(
          firstChild: SizedBox.shrink(),
          secondChild: Column(
            spacing: 10,
            children: [
              for (final sideQuest in widget.sideQuests)
                _buildSideQuest(sideQuest),
            ],
          ),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 250),
        ),
      ],
    );
  }
}
