import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/providers/assembler_providers.dart';
import 'package:questlog/providers/quest_providers.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/quest_category/quest_category_header.dart';
import 'package:questlog/widgets/quest_log_loading_screen.dart';
import 'package:questlog/widgets/quests/main_quest_block.dart';
import 'package:questlog/widgets/reusables/quest_log_button.dart';
import 'package:questlog/widgets/reusables/quest_log_new_screen_container.dart';

class SelectMainQuestScreen extends ConsumerWidget {
  const SelectMainQuestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assemblerNotifier = ref.read(
      assemblerViewStateNotifierProvider.notifier,
    );
    final mainQuestsByCategoryAsync = ref.watch(mainQuestsByCategoryProvider);

    return mainQuestsByCategoryAsync.when(
      data: (collection) {
        return QuestLogNewScreenContainer(
          spacing: 10,
          children: [
            for (final entry in collection.entries) ...[
              QuestCategoryHeader(
                label: entry.key.name,
                questCount: entry.value.length,
              ),

              for (final mainQuest in entry.value) ...[
                MainQuestBlock(
                  mainQuest: mainQuest,
                  footer: QuestLogButton(
                    label: 'ASSEMBLE INTO SLOT',
                    prefixIcon: Icons.bolt_outlined,
                    onPress: () {
                      assemblerNotifier.handleAddMainQuestToAssemble(mainQuest);
                      Navigator.pop(context);
                    },
                    primaryColor: QuestLogColors.black,
                    borderColor: QuestLogColors.accent,
                    backgroundColor: QuestLogColors.accent,
                    expandHorizontally: true,
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
