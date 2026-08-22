import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/priority.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/theme/questlog_text_styles.dart';
import 'package:questlog/utils/stringify_duration.dart';
import 'package:questlog/utils/stringify_quest_category.dart';

class MainQuests extends StatefulWidget {
  const MainQuests({super.key, required this.mainQuests});

  final List<MainQuest> mainQuests;

  @override
  State<MainQuests> createState() => _MainQuestsState();
}

class _MainQuestsState extends State<MainQuests> {
  bool isExpanded = false;

  Widget _buildHeader() {
    return Row(
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

        IconButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          icon: AnimatedRotation(
            turns: isExpanded ? 0.5 : 0,
            duration: Duration(milliseconds: 200),
            child: Icon(Icons.arrow_drop_down),
          ),
        ),
      ],
    );
  }

  Widget _buildMainQuest(MainQuest mainQuest) {
    final priority = mainQuest.priority;
    final icon = priorityIcon(priority);
    final color = priorityColor(priority);
    final label = priorityLabel(priority);

    final name = mainQuest.name;
    final durationString = stringifyDuration(mainQuest.durationMin);

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: QuestLogColors.accent),
          bottom: BorderSide(width: 1, color: QuestLogColors.accent),
          left: BorderSide(width: 1, color: QuestLogColors.accent),
          top: BorderSide(width: 5, color: QuestLogColors.accent),
        ),
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: QuestLogColors.accentLessOpacity,
                  border: Border.all(color: QuestLogColors.accent, width: 1),
                ),
                child: Text(
                  stringifyQuestCategory(mainQuest.questCategory).toUpperCase(),
                  style: GoogleFonts.jetBrainsMono(
                    color: QuestLogColors.accent,
                    fontSize: 13,
                    fontWeight: .w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              Row(
                spacing: 5,
                children: [
                  Icon(icon, color: color, size: 12),

                  Text(
                    'PRIORITY: ${label.toUpperCase()}',
                    style: GoogleFonts.jetBrainsMono(
                      color: color,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Text(
            name,
            style: TextStyle(
              color: QuestLogColors.textPrimary,
              fontWeight: .bold,
              fontSize: 18,
            ),
          ),

          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Expanded(
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 12,
                      color: QuestLogColors.textSecondary,
                    ),
                    Text(
                      'DEADLINE: ${mainQuest.dueDate.day}.${mainQuest.dueDate.month}.${mainQuest.dueDate.year}',
                      style: GoogleFonts.jetBrainsMono(
                        color: QuestLogColors.textSecondary,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 12,
                      color: QuestLogColors.textSecondary,
                    ),

                    Text(
                      'Duration: ${durationString}H',
                      style: GoogleFonts.jetBrainsMono(
                        color: QuestLogColors.textSecondary,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: QuestLogColors.surface,
              border: Border.all(color: QuestLogColors.border, width: 1),
            ),
            child: Column(
              spacing: 5,
              children: [
                for (final subTask in mainQuest.subTasks)
                  _buildSubTask(subTask),
              ],
            ),
          ),

          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(10),
              backgroundColor: QuestLogColors.accentLessOpacity,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: QuestLogColors.accent),
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: Row(
              mainAxisAlignment: .center,
              spacing: 5,
              children: [
                Icon(
                  Icons.bolt_outlined,
                  color: QuestLogColors.accent,
                  size: 20,
                ),

                Text(
                  'ASSEMBLE',
                  style: GoogleFonts.jetBrainsMono(
                    color: QuestLogColors.accent,
                    fontSize: 12,
                    fontWeight: .w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubTask(SubTask subTask) {
    return Row(
      spacing: 5,
      children: [
        Icon(Icons.chevron_right, size: 16, color: QuestLogColors.accent),

        Text(
          subTask.name.toUpperCase(),
          style: GoogleFonts.jetBrainsMono(
            color: QuestLogColors.textPrimary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),

        AnimatedCrossFade(
          firstChild: SizedBox.shrink(),
          secondChild: Column(
            spacing: 10,
            children: [
              for (final mainQuest
                  in (widget.mainQuests.toList()
                    ..sort((a, b) => a.dueDate.compareTo(b.dueDate))))
                _buildMainQuest(mainQuest),
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
