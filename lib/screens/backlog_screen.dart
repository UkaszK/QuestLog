import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/day.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/providers/backlog_providers.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/backlog_screen/backlog_empty_note.dart';
import 'package:questlog/widgets/quest_log_loading_screen.dart';
import 'package:questlog/widgets/reusables/quest_log_badge.dart';
import 'package:questlog/widgets/reusables/quest_log_screen_container.dart';
import 'package:questlog/widgets/reusables/quest_log_section_header.dart';

class BacklogScreen extends ConsumerWidget {
  const BacklogScreen({super.key});

  Widget _buildHeader(String label, int? questCount) {
    return QuestLogSectionHeader(
      title: label.toUpperCase(),

      rightSide: QuestLogBadge(
        label: '$questCount QUESTS',
        primaryColor: QuestLogColors.textSecondary,
        backgroundColor: QuestLogColors.surface,
        borderColor: QuestLogColors.border,
      ),
    );
  }

  Widget _buildMainQuestBlock(MainQuest mainQuest) {
    return _questContainer(
      color: QuestLogColors.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  QuestLogBadge(
                    label: 'MAIN QUEST',
                    primaryColor: QuestLogColors.accent,
                  ),

                  const SizedBox(width: 5),

                  QuestLogBadge(
                    label: mainQuest.priority.label.toUpperCase(),
                    primaryColor: mainQuest.priority.color,
                    prefixIcon: mainQuest.priority.icon,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: QuestLogColors.accent,
                    size: 10,
                  ),

                  const SizedBox(width: 5),

                  Text(
                    'DUE: ${mainQuest.dueText}',
                    style: GoogleFonts.jetBrainsMono(
                      color: QuestLogColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            mainQuest.name,
            style: GoogleFonts.jetBrainsMono(
              color: QuestLogColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight(1000),
            ),
          ),

          if (mainQuest.subTasks.isNotEmpty) ...[
            const SizedBox(height: 10),

            Container(
              padding: EdgeInsets.all(10),
              color: QuestLogColors.black,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.checklist,
                        size: 14,
                        color: QuestLogColors.accent,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        'SUB-TASKS',
                        style: GoogleFonts.jetBrainsMono(
                          color: QuestLogColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  for (final subTask in mainQuest.subTasks) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: QuestLogColors.accent,
                          size: 14,
                        ),

                        const SizedBox(width: 5),

                        Text(
                          subTask,
                          style: GoogleFonts.jetBrainsMono(
                            color: QuestLogColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],

          const SizedBox(height: 10),

          Divider(height: 1),

          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFooterActionsButtons(() {}, () {}),

              Material(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: QuestLogColors.accentLessOpacity,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      border: Border.all(color: QuestLogColors.accent),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.bolt_outlined,
                          color: QuestLogColors.accent,
                          size: 14,
                        ),

                        const SizedBox(width: 5),

                        Text(
                          'ASSEMBLE',
                          style: GoogleFonts.jetBrainsMono(
                            color: QuestLogColors.accent,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSideQuestBlock(SideQuest sideQuest) {
    return _questContainer(
      color: QuestLogColors.otherAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  QuestLogBadge(
                    label: 'SIDE QUEST',
                    primaryColor: QuestLogColors.otherAccent,
                  ),

                  const SizedBox(width: 5),

                  if (sideQuest.repeatDays.isNotEmpty) ...[
                    QuestLogBadge(
                      label: sideQuest.timeIntervalString()!.toUpperCase(),
                      primaryColor: QuestLogColors.otherAccent,
                      backgroundColor: QuestLogColors.surface,
                      borderColor: QuestLogColors.border,
                    ),
                  ],
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            sideQuest.name,
            style: GoogleFonts.jetBrainsMono(
              color: QuestLogColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight(1000),
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 10),

          Container(
            padding: EdgeInsets.all(10),
            color: QuestLogColors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 5,
                  children: [
                    Text(
                      'REPEAT:',
                      style: GoogleFonts.jetBrainsMono(
                        color: QuestLogColors.textPrimary,
                        fontSize: 10,
                      ),
                    ),

                    const SizedBox(height: 10),

                    for (final day in Day.values) ...[
                      Container(
                        decoration: BoxDecoration(
                          color: sideQuest.repeatDays.contains(day)
                              ? QuestLogColors.otherAccent
                              : QuestLogColors.surface,
                          border: Border.all(color: QuestLogColors.border),
                          borderRadius: BorderRadiusGeometry.circular(5),
                        ),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              day.label[0],
                              style: GoogleFonts.jetBrainsMono(
                                color: sideQuest.repeatDays.contains(day)
                                    ? QuestLogColors.black
                                    : QuestLogColors.textSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),

                if (sideQuest.repeatDays.contains(
                  Day.fromDateTime(DateTime.now()),
                )) ...[
                  Text(
                    'TODAY',
                    style: GoogleFonts.jetBrainsMono(
                      color: QuestLogColors.otherAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ] else if (sideQuest.repeatDays.isEmpty) ...[
                  Text(
                    'NO REPEAT',
                    style: GoogleFonts.jetBrainsMono(
                      color: QuestLogColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 10),

          Divider(height: 1),

          const SizedBox(height: 5),

          _buildFooterActionsButtons(() {}, () {}),
        ],
      ),
    );
  }

  Container _questContainer({required Color color, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: QuestLogColors.surface,
        border: Border(
          top: BorderSide(color: color, width: 0.5),
          right: BorderSide(color: color, width: 0.5),
          bottom: BorderSide(color: color, width: 0.5),
          left: BorderSide(color: color, width: 5),
        ),
      ),
      child: child,
    );
  }

  Widget _buildFooterActionsButtons(
    VoidCallback onTapDelete,
    VoidCallback onTapEdit,
  ) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            radius: 10,
            customBorder: const CircleBorder(),
            onTap: onTapEdit,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.edit,
                size: 16,
                color: QuestLogColors.textSecondary,
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        Material(
          color: Colors.transparent,
          child: InkWell(
            radius: 10,
            customBorder: const CircleBorder(),
            onTap: onTapDelete,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.delete_outline,
                size: 16,
                color: QuestLogColors.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backlogScreenAsync = ref.watch(backlogStateProvider);

    return backlogScreenAsync.when(
      data: (state) {
        final sortedCategories = state.questsByCategory.keys.toList()
          ..sort((a, b) {
            final aQuests = state.questsByCategory[a]!;
            final bQuests = state.questsByCategory[b]!;
            final aCount = aQuests.$1.length + aQuests.$2.length;
            final bCount = bQuests.$1.length + bQuests.$2.length;

            return bCount.compareTo(aCount);
          });
        final categoryCounts = <dynamic, int>{
          for (final category in sortedCategories)
            category:
                state.questsByCategory[category]!.$1.length +
                state.questsByCategory[category]!.$2.length,
        };

        return QuestLogScreenContainer(
          children: [
            if (state.questsByCategory.isEmpty)
              BacklogEmptyNote()
            else ...[
              for (final category in sortedCategories) ...[
                _buildHeader(category.name, categoryCounts[category]),

                const SizedBox(height: 10),

                Column(
                  spacing: 10,
                  children: [
                    for (final quest
                        in state.questsByCategory[category]!.$1) ...[
                      _buildMainQuestBlock(quest),
                    ],

                    for (final quest
                        in state.questsByCategory[category]!.$2) ...[
                      _buildSideQuestBlock(quest),
                    ],
                  ],
                ),

                const SizedBox(height: 32),
              ],
            ],
          ],
        );
      },
      error: (error, stack) => Center(child: Text('Fehler beim Laden: $error')),
      loading: () => QuestLogLoadingScreen(),
    );
  }
}
