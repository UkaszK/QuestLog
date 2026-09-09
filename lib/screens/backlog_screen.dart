import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/providers/backlog_providers.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/backlog_screen/backlog_empty_note.dart';
import 'package:questlog/widgets/quest_log_loading_screen.dart';
import 'package:questlog/widgets/reusables/quest_log_screen_container.dart';
import 'package:questlog/widgets/reusables/quest_log_section_header.dart';

class BacklogScreen extends ConsumerWidget {
  const BacklogScreen({super.key});

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
                QuestLogSectionHeader(
                  title: category.name,

                  rightSide: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: QuestLogColors.surface,
                          border: Border.all(color: QuestLogColors.border),
                          borderRadius: BorderRadiusGeometry.circular(2),
                        ),
                        child: Text(
                          '${categoryCounts[category]} QUESTS',
                          style: GoogleFonts.jetBrainsMono(
                            color: QuestLogColors.textSecondary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
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
