import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/data/assembler_side_quest.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/providers/quest_providers.dart';
import 'package:questlog/widgets/dashboard_screen/daily_progress/dashboard_daily_progress.dart';
import 'package:questlog/widgets/dashboard_screen/scheduled_main_quests/assembler_main_quests.dart';
import 'package:questlog/widgets/dashboard_screen/side_quests/side_quests.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  void _handleCheckAssemblerQuest(
    AssemblerMainQuest assemblerQuest,
    bool newValue,
  ) {
    final updatedSubTasks = assemblerQuest.subTasks
        .map((subTask) => SubTask(name: subTask.name, completed: newValue))
        .toList();
    final updatedAssemblerQuest = AssemblerMainQuest(
      mainQuestId: assemblerQuest.mainQuestId,
      name: assemblerQuest.name,
      questCategoryName: assemblerQuest.questCategoryName,
      subTasks: updatedSubTasks,
      startTime: assemblerQuest.startTime,
      endTime: assemblerQuest.endTime,
      completed: newValue,
    );

    IsarDataStore.updateAssemblerQuest(
      assemblerQuest.id,
      updatedAssemblerQuest,
    );
  }

  void _handleCheckSubTask(
    AssemblerMainQuest assemblerQuest,
    SubTask subTask,
    bool newValue,
  ) {
    final subTaskIndex = assemblerQuest.subTasks.indexWhere(
      (st) => identical(st, subTask),
    );
    if (subTaskIndex == -1) return;

    final updatedSubTasks = List<SubTask>.from(assemblerQuest.subTasks);
    updatedSubTasks[subTaskIndex] = SubTask(
      name: subTask.name,
      completed: newValue,
    );

    final updatedAssemblerQuest = AssemblerMainQuest(
      mainQuestId: assemblerQuest.mainQuestId,
      name: assemblerQuest.name,
      questCategoryName: assemblerQuest.questCategoryName,
      subTasks: updatedSubTasks,
      startTime: assemblerQuest.startTime,
      endTime: assemblerQuest.endTime,
      completed: assemblerQuest.completed,
    );

    IsarDataStore.updateAssemblerQuest(
      assemblerQuest.id,
      updatedAssemblerQuest,
    );
  }

  void _handleCheckSideQuest(
    SideQuest sideQuest,
    bool newValue,
    List<AssemblerSideQuest> assemblerSideQuestCollection,
  ) {
    final now = DateTime.now();
    final existing = assemblerSideQuestCollection.firstWhereOrNull(
      (assemblerSideQuest) => assemblerSideQuest.sideQuestId == sideQuest.id,
    );

    if (!newValue) {
      if (existing != null) {
        IsarDataStore.deleteAssemblerSideQuest(existing);
      }
    } else {
      final updatedAssemblerSideQuest = AssemblerSideQuest(
        sideQuestId: sideQuest.id,
        name: sideQuest.name,
        questCategoryName: sideQuest.questCategoryName,
        occurrenceDate: DateTime(now.year, now.month, now.day),
        completedAt: now,
      );

      if (existing != null) {
        IsarDataStore.updateAssemblerSideQuest(
          existing.id,
          updatedAssemblerSideQuest,
        );
      } else {
        IsarDataStore.addAssemblerSideQuest(updatedAssemblerSideQuest);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();

    final todayAssemblerMainQuests = ref.watch(
      assemblerMainQuestsForDayProvider(today),
    );

    final todayAssemblerSideQuests = ref.watch(
      assemblerSideQuestsForDayProvider(today),
    );

    final completedSideQuestIds = todayAssemblerSideQuests
        .where((assemblerSideQuest) => assemblerSideQuest.completed)
        .map((assemblerSideQuest) => assemblerSideQuest.sideQuestId)
        .toSet();

    final sideQuestsAsync = ref.watch(sideQuestsProvider);

    final dailyProgress = ref.watch(dailyProgressForDayProvider(today));

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 150),
      child: Column(
        spacing: 25,
        children: [
          if (todayAssemblerMainQuests.isNotEmpty ||
              todayAssemblerSideQuests.isNotEmpty)
            DashboardDailyProgress(
              tasksDone: dailyProgress.tasksDone,
              tasksPlanned: dailyProgress.tasksPlanned,
            ),

          AssemblerMainQuests(
            assemblerMainQuests: todayAssemblerMainQuests,
            onCheckAssemblerMainQuest: _handleCheckAssemblerQuest,
            onCheckSubTask: _handleCheckSubTask,
          ),

          sideQuestsAsync.when(
            data: (sideQuests) {
              return SideQuests(
                sideQuests: sideQuests,
                completedSideQuestIds: completedSideQuestIds,
                onCheckSideQuest: (sideQuest, newValue) =>
                    _handleCheckSideQuest(
                      sideQuest,
                      newValue,
                      todayAssemblerSideQuests,
                    ),
              );
            },
            error: (_, _) => const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
