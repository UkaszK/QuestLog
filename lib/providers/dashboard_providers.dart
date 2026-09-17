import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/assembler_main_quest.dart';
import 'package:questlog/data/assembler_side_quest.dart';
import 'package:questlog/data/daily_progress_metrics.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/providers/quest_providers.dart';
import 'package:questlog/providers/side_quest_providers.dart';

typedef DashboardState = ({
  List<AssemblerMainQuest> assemblerMainQuests,
  List<AssemblerSideQuest> assemblerSideQuests,
  List<SideQuest> sideQuests,
  Set<int> completedSideQuestIds,
  DailyProgressMetrics progress,
});

final dashboardStateProvider =
    Provider.family<AsyncValue<DashboardState>, DateTime>((ref, date) {
      final states = [
        ref.watch(assemblerMainQuestsForDayProvider(date)),
        ref.watch(assemblerSideQuestsForDayProvider(date)),
        ref.watch(sideQuestsProvider),
        ref.watch(completedSideQuestIdsForDayProvider(date)),
        ref.watch(dailyProgressForDayProvider(date)),
      ];

      if (states.any((state) => state.isLoading)) {
        return const AsyncLoading();
      }

      for (final state in states) {
        if (state.hasError) return AsyncError(state.error!, state.stackTrace!);
      }

      return AsyncData((
        assemblerMainQuests: states[0].requireValue as List<AssemblerMainQuest>,
        assemblerSideQuests: states[1].requireValue as List<AssemblerSideQuest>,
        sideQuests: states[2].requireValue as List<SideQuest>,
        completedSideQuestIds: states[3].requireValue as Set<int>,
        progress: states[4].requireValue as DailyProgressMetrics,
      ));
    });

final dashboardControllerProvider = NotifierProvider<DashboardController, void>(
  () => DashboardController(),
);

class DashboardController extends Notifier<void> {
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
      completed: newValue,
      completedAt: newValue ? DateTime.now() : null,
      clearCompletedAt: !newValue,
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
      completedAt: completed == true ? DateTime.now() : null,
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
