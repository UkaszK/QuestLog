import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/data/assembler_side_quest.dart';
import 'package:questlog/data/daily_progress_metrics.dart';
import 'package:questlog/data/day.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/side_quest.dart';

// ==========================================
// Base Stream Providers (Live DB Watchers)
// ==========================================

final mainQuestsProvider = StreamProvider<List<MainQuest>>((ref) {
  return IsarDataStore.watchAllMainQuests();
});

final sideQuestsProvider = StreamProvider<List<SideQuest>>((ref) {
  return IsarDataStore.watchAllSideQuests();
});

final assemblerMainQuestsProvider = StreamProvider<List<AssemblerMainQuest>>((
  ref,
) {
  return IsarDataStore.watchAllAssemblerMainQuests();
});

final assemblerSideQuestsProvider = StreamProvider<List<AssemblerSideQuest>>((
  ref,
) {
  return IsarDataStore.watchAllAssemblerSideQuests();
});

// ------------------------------------------
// Date-parameterized Providers
// ------------------------------------------

/// Assembler main quests scheduled for a specific date, sorted chronologically.
final assemblerMainQuestsForDayProvider =
    Provider.family<List<AssemblerMainQuest>, DateTime>((ref, date) {
      final quests = ref.watch(assemblerMainQuestsProvider).value ?? [];
      return quests
          .where((q) => DateUtils.isSameDay(q.startTime, date))
          .sorted((a, b) => a.compareTo(b));
    });

/// Assembler side quest entries (completions) for a specific date.
final assemblerSideQuestsForDayProvider =
    Provider.family<List<AssemblerSideQuest>, DateTime>((ref, date) {
      final sideQuests = ref.watch(assemblerSideQuestsProvider).value ?? [];
      return sideQuests
          .where((sq) => DateUtils.isSameDay(sq.occurrenceDate, date))
          .toList();
    });

/// Side quests that repeat on the weekday of the given date.
final scheduledSideQuestsForDayProvider =
    Provider.family<List<SideQuest>, DateTime>((ref, date) {
      final sideQuests = ref.watch(sideQuestsProvider).value ?? [];
      final targetDay = Day.fromDateTime(date);
      return sideQuests
          .where((sq) => sq.repeatDays.contains(targetDay))
          .toList();
    });

/// Set of side quest IDs that have been completed on a specific date.
final completedSideQuestIdsForDayProvider = Provider.family<Set<int>, DateTime>(
  (ref, date) {
    final todayAssemblerSideQuests = ref.watch(
      assemblerSideQuestsForDayProvider(date),
    );
    return todayAssemblerSideQuests
        .where((asq) => asq.completed)
        .map((asq) => asq.sideQuestId)
        .toSet();
  },
);

/// Daily progress statistics (tasks done vs tasks planned) for a specific date.
final dailyProgressForDayProvider = Provider.family<DailyProgressMetrics, DateTime>((
  ref,
  date,
) {
  final mainQuests = ref.watch(assemblerMainQuestsForDayProvider(date));
  final scheduledSideQuests = ref.watch(
    scheduledSideQuestsForDayProvider(date),
  );
  final completedSideQuestIds = ref.watch(
    completedSideQuestIdsForDayProvider(date),
  );

  // Tasks done: completed main quests + completed subtasks + completed side quests
  final mainTasksDone = mainQuests.fold<int>(0, (total, quest) {
    final completedSubTasks = quest.subTasks.where((st) => st.completed).length;
    return total + completedSubTasks + (quest.completed ? 1 : 0);
  });

  final sideQuestsDone = scheduledSideQuests
      .where((sq) => completedSideQuestIds.contains(sq.id))
      .length;

  final tasksDone = mainTasksDone + sideQuestsDone;

  // Tasks planned: all main quests + their subtasks + scheduled side quests for this day
  final mainTasksPlanned = mainQuests.fold<int>(0, (total, quest) {
    return total + quest.subTasks.length + 1;
  });
  final sideQuestsPlanned = scheduledSideQuests.length;

  final tasksPlanned = mainTasksPlanned + sideQuestsPlanned;

  return DailyProgressMetrics(tasksDone: tasksDone, tasksPlanned: tasksPlanned);
});
