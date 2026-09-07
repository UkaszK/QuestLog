import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/providers/backlog_providers.dart';
import 'package:questlog/widgets/backlog_screen/backlog_empty_note.dart';
import 'package:questlog/widgets/quest_log_loading_screen.dart';

class BacklogScreen extends ConsumerWidget {
  const BacklogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backlogScreenAsync = ref.watch(backlogStateProvider);

    return backlogScreenAsync.when(
      data: (state) {
        return Column(
          children: [
            if (state.mainQuests.isEmpty && state.sideQuests.isEmpty) ...[
              BacklogEmptyNote(),
            ] else ...[
              for (final mainQuest in state.mainQuests) ...[
                Text(mainQuest.name),
              ],
              for (final sideQuest in state.sideQuests) ...[
                Text(sideQuest.name),
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
