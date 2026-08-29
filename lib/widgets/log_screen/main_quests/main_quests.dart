import 'package:flutter/material.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/theme/questlog_text_styles.dart';
import 'package:questlog/widgets/log_screen/main_quests/main_quest_block.dart';

class MainQuests extends StatefulWidget {
  const MainQuests({super.key, required this.mainQuests});

  final List<MainQuest> mainQuests;

  @override
  State<MainQuests> createState() => _MainQuestsState();
}

class _MainQuestsState extends State<MainQuests> {
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
                Icons.calendar_month,
                color: QuestLogColors.textPrimary,
                size: 16,
              ),

              Text('MAIN QUESTS', style: QuestLogTextStyles.headerText),
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
              for (final mainQuest
                  in (widget.mainQuests.toList()
                    ..sort((a, b) => (a.compareTo(b)))))
                MainQuestBlock(
                  mainQuest: mainQuest,
                  onAssemble: (mainQuest) {},
                ),
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
