import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/assembler_main_quest.dart';
import 'package:questlog/data/assembler_side_quest.dart';
import 'package:questlog/data/daily_progress_metrics.dart';
import 'package:questlog/data/day.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/providers/main_quest_providers.dart';
import 'package:questlog/providers/side_quest_providers.dart';

// ==========================================
// Base Stream Providers (Live DB Watchers)
// ==========================================

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
    Provider.family<AsyncValue<List<AssemblerMainQuest>>, DateTime>((
      ref,
      date,
    ) {
      final asyncAssemblerMainQuests = ref.watch(assemblerMainQuestsProvider);

      return asyncAssemblerMainQuests.whenData((assemblerMainQuests) {
        return assemblerMainQuests
            .where((q) => DateUtils.isSameDay(q.startTime, date))
            .sorted((a, b) => a.compareTo(b));
      });
    });

/// Assembler side quest entries (completions) for a specific date.
final assemblerSideQuestsForDayProvider =
    Provider.family<AsyncValue<List<AssemblerSideQuest>>, DateTime>((
      ref,
      date,
    ) {
      final asyncSideQuests = ref.watch(assemblerSideQuestsProvider);

      return asyncSideQuests.whenData((sideQuests) {
        return sideQuests
            .where((sq) => DateUtils.isSameDay(sq.occurrenceDate, date))
            .toList();
      });
    });

/// Side quests that repeat on the weekday of the given date.
final scheduledSideQuestsForDayProvider =
    Provider.family<AsyncValue<List<SideQuest>>, DateTime>((ref, date) {
      final asyncSideQuests = ref.watch(sideQuestsProvider);
      final targetDay = Day.fromDateTime(date);

      return asyncSideQuests.whenData((sideQuests) {
        return sideQuests
            .where((sq) => sq.repeatDays.contains(targetDay))
            .toList();
      });
    });

/// Set of side quest IDs that have been completed on a specific date.
final completedSideQuestIdsForDayProvider =
    Provider.family<AsyncValue<Set<int>>, DateTime>((ref, date) {
      final asyncTodayAssemblerSideQuests = ref.watch(
        assemblerSideQuestsForDayProvider(date),
      );
      return asyncTodayAssemblerSideQuests.whenData((todayAssemblerSideQuests) {
        return todayAssemblerSideQuests
            .where((asq) => asq.completed)
            .map((asq) => asq.sideQuestId)
            .toSet();
      });
    });

/// Daily progress statistics (tasks done vs tasks planned) for a specific date.
final dailyProgressForDayProvider =
    Provider.family<AsyncValue<DailyProgressMetrics>, DateTime>((ref, date) {
      final asyncMainQuests = ref.watch(
        assemblerMainQuestsForDayProvider(date),
      );
      final asyncScheduledSideQuests = ref.watch(
        scheduledSideQuestsForDayProvider(date),
      );
      final asyncCompletedSideQuestIds = ref.watch(
        completedSideQuestIdsForDayProvider(date),
      );

      if (asyncMainQuests.isLoading ||
          asyncScheduledSideQuests.isLoading ||
          asyncCompletedSideQuestIds.isLoading) {
        return const AsyncLoading();
      }

      final mainQuests = asyncMainQuests.requireValue;
      final scheduledSideQuests = asyncScheduledSideQuests.requireValue;
      final completedSideQuestIds = asyncCompletedSideQuestIds.requireValue;

      // Tasks done: completed main quests + completed subtasks + completed side quests
      final mainTasksDone = mainQuests.fold<int>(0, (total, quest) {
        final completedSubTasks = quest.subTasks
            .where((st) => st.completed)
            .length;
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

      return AsyncData(
        DailyProgressMetrics(tasksDone: tasksDone, tasksPlanned: tasksPlanned),
      );
    });

final mainQuestsByCategoryProvider =
    Provider<AsyncValue<Map<QuestCategory, List<MainQuest>>>>((ref) {
      final mainQuestsAsync = ref.watch(mainQuestsProvider);

      return mainQuestsAsync.whenData((mainQuests) {
        Map<QuestCategory, List<MainQuest>> collection = {};

        for (final mainQuest in mainQuests) {
          if (!collection.containsKey(mainQuest.questCategory)) {
            collection[mainQuest.questCategory] = [mainQuest];
            continue;
          }

          collection[mainQuest.questCategory]!.add(mainQuest);
        }

        return collection;
      });
    });
