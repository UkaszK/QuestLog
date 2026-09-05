import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/assembler_main_quest.dart';
import 'package:questlog/data/assembler_side_quest.dart';
import 'package:questlog/data/daily_progress_metrics.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/providers/quest_providers.dart';

typedef DashboardState = ({
  List<AssemblerMainQuest> assemblerMainQuests,
  List<AssemblerSideQuest> assemblerSideQuests,
  List<SideQuest> sideQuests,
  Set<int> completedSideQuestIds,
  DailyProgressMetrics progress,
});

final dashboardStateProvider =
    Provider.family<AsyncValue<DashboardState>, DateTime>((ref, date) {
      final assemblerMainQuestsAsync = ref.watch(
        assemblerMainQuestsForDayProvider(date),
      );
      final assemblerSideQuestsAsync = ref.watch(
        assemblerSideQuestsForDayProvider(date),
      );
      final sideQuestsAsync = ref.watch(sideQuestsProvider);
      final completedSideQuestIdsAsync = ref.watch(
        completedSideQuestIdsForDayProvider(date),
      );
      final progressAsync = ref.watch(dailyProgressForDayProvider(date));

      // Loading
      if (assemblerMainQuestsAsync.isLoading ||
          assemblerSideQuestsAsync.isLoading ||
          sideQuestsAsync.isLoading ||
          completedSideQuestIdsAsync.isLoading ||
          progressAsync.isLoading) {
        return const AsyncLoading();
      }

      // Errors
      if (assemblerMainQuestsAsync.hasError) {
        return AsyncError(
          assemblerMainQuestsAsync.error!,
          assemblerMainQuestsAsync.stackTrace!,
        );
      }
      if (assemblerSideQuestsAsync.hasError) {
        return AsyncError(
          assemblerSideQuestsAsync.error!,
          assemblerSideQuestsAsync.stackTrace!,
        );
      }
      if (sideQuestsAsync.hasError) {
        return AsyncError(sideQuestsAsync.error!, sideQuestsAsync.stackTrace!);
      }
      if (completedSideQuestIdsAsync.hasError) {
        return AsyncError(
          completedSideQuestIdsAsync.error!,
          completedSideQuestIdsAsync.stackTrace!,
        );
      }
      if (progressAsync.hasError) {
        return AsyncError(progressAsync.error!, progressAsync.stackTrace!);
      }

      return AsyncData((
        assemblerMainQuests: assemblerMainQuestsAsync.requireValue,
        assemblerSideQuests: assemblerSideQuestsAsync.requireValue,
        sideQuests: sideQuestsAsync.requireValue,
        completedSideQuestIds: completedSideQuestIdsAsync.requireValue,
        progress: progressAsync.requireValue,
      ));
    });

final dashboardNotifierProvider = NotifierProvider<DashboardNotifier, void>(
  () => DashboardNotifier(),
);

class DashboardNotifier extends Notifier<void> {
  @override
  void build() {}

  void checkAssemblerMainQuest(
    AssemblerMainQuest assemblerMainQuest,
    bool newValue,
  ) {
    final updatedSubTasks = assemblerMainQuest.subTasks
        .map((subTask) => SubTask(name: subTask.name, completed: newValue))
        .toList();

    final updatedAssemblerMainQuest = assemblerMainQuest.copyWith(
      subTasks: updatedSubTasks,
    );

    IsarDataStore.updateAssemblerMainQuest(
      assemblerMainQuest.id,
      updatedAssemblerMainQuest,
    );
  }

  void checkSubTask(
    AssemblerMainQuest assemblerMainQuest,
    SubTask subTask,
    bool newValue,
  ) {
    final subTaskIndex = assemblerMainQuest.subTasks.indexWhere(
      (st) => st == subTask,
    );
    if (subTaskIndex == -1) return;

    final updatedSubTasks = List<SubTask>.from(assemblerMainQuest.subTasks);
    updatedSubTasks[subTaskIndex] = SubTask(
      name: subTask.name,
      completed: newValue,
    );

    bool? completed;
    if (newValue) {
      if (updatedSubTasks.every((st) => st.completed)) {
        completed = true;
      }
    }

    final updatedAssemblerMainQuest = assemblerMainQuest.copyWith(
      subTasks: updatedSubTasks,
      completed: completed,
    );

    IsarDataStore.updateAssemblerMainQuest(
      assemblerMainQuest.id,
      updatedAssemblerMainQuest,
    );
  }

  void checkSideQuest(
    SideQuest sideQuest,
    bool newValue,
    List<AssemblerSideQuest> assemblerSideQuests,
  ) {
    final existingSideQuest = assemblerSideQuests.firstWhereOrNull(
      (assemblerSideQuest) => assemblerSideQuest.sideQuestId == sideQuest.id,
    );

    if (existingSideQuest != null && !newValue) {
      IsarDataStore.deleteAssemblerSideQuest(existingSideQuest);
      return;
    }

    if (existingSideQuest == null && newValue) {
      final assemblerSideQuest = AssemblerSideQuest.from(
        sideQuest,
        DateTime.now(),
      );

      IsarDataStore.addAssemblerSideQuest(assemblerSideQuest);
      return;
    }
  }
}
