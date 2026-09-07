import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/assembler_main_quest.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/data/time_slot.dart';
import 'package:questlog/providers/quest_providers.dart';

typedef AssemblerDataState = ({
  List<AssemblerMainQuest> selectedDayQuests,
  Map<QuestCategory, List<MainQuest>> mainQuestsByCategory,
});

typedef AssemblerViewState = ({
  TimeSlot? selectedTimeSlot,
  MainQuest? assembledMainQuest,
  AssemblerMainQuest? editingQuest,
});

// Result of successfully creating an AssemblerMainQuest from a backlog MainQuest.
typedef AssembledQuestResult = ({
  AssemblerMainQuest assemblerQuest,
  MainQuest sourceMainQuest,
});

final assemblerDataStateProvider =
    Provider.family<AsyncValue<AssemblerDataState>, DateTime>((ref, date) {
      final selectedDayQuestsAsync = ref.watch(
        assemblerMainQuestsForDayProvider(date),
      );

      final mainQuestsByCategoryAsync = ref.watch(mainQuestsByCategoryProvider);

      // Loading
      if (selectedDayQuestsAsync.isLoading ||
          mainQuestsByCategoryAsync.isLoading) {
        return const AsyncLoading();
      }

      // Errors
      if (selectedDayQuestsAsync.hasError) {
        return AsyncError(
          selectedDayQuestsAsync.error!,
          selectedDayQuestsAsync.stackTrace!,
        );
      }
      if (mainQuestsByCategoryAsync.hasError) {
        return AsyncError(
          mainQuestsByCategoryAsync.error!,
          mainQuestsByCategoryAsync.stackTrace!,
        );
      }

      return AsyncData((
        selectedDayQuests: selectedDayQuestsAsync.requireValue,
        mainQuestsByCategory: mainQuestsByCategoryAsync.requireValue,
      ));
    });

final assemblerViewStateNotifierProvider =
    NotifierProvider<AssemblerViewStateNotifier, AssemblerViewState>(
      () => AssemblerViewStateNotifier(),
    );

class AssemblerViewStateNotifier extends Notifier<AssemblerViewState> {
  @override
  AssemblerViewState build() =>
      (selectedTimeSlot: null, assembledMainQuest: null, editingQuest: null);

  void resetTimeSlot() {
    state = (
      selectedTimeSlot: null,
      assembledMainQuest: null,
      editingQuest: null,
    );
  }

  void updateSelectedTimeSlot(TimeSlot timeSlot) {
    state = (
      selectedTimeSlot: timeSlot,
      assembledMainQuest: state.assembledMainQuest,
      editingQuest: state.editingQuest,
    );
  }

  void handleSelectExistingAssemblerQuest(
    AssemblerMainQuest assemblerMainQuest,
  ) {
    state = (
      selectedTimeSlot: (
        startTime: assemblerMainQuest.startTime,
        endTime: assemblerMainQuest.endTime,
      ),
      assembledMainQuest: null,
      editingQuest: assemblerMainQuest,
    );
  }

  void handleMainQuestAssembled(MainQuest mainQuest) {
    state = (
      selectedTimeSlot: state.selectedTimeSlot,
      assembledMainQuest: mainQuest,
      editingQuest: state.editingQuest,
    );
  }

  void handleQuestCleared() {
    state = (
      selectedTimeSlot: state.selectedTimeSlot,
      assembledMainQuest: null,
      editingQuest: state.editingQuest,
    );
  }

  AssembledQuestResult? handleCreateAssemblerQuest() {
    final selectedTimeSlot = state.selectedTimeSlot;
    final assembledMainQuest = state.assembledMainQuest;
    if (selectedTimeSlot == null || assembledMainQuest == null) return null;

    final newAssemblerQuest = AssemblerMainQuest(
      mainQuestId: assembledMainQuest.id,
      name: assembledMainQuest.name,
      questCategoryName: assembledMainQuest.questCategoryName,
      subTasks: assembledMainQuest.subTasks
          .map((subTask) => SubTask(name: subTask, completed: false))
          .toList(),
      startTime: selectedTimeSlot.startTime,
      endTime: selectedTimeSlot.endTime,
    );

    IsarDataStore.addAssemblerMainQuest(newAssemblerQuest);
    resetTimeSlot();

    return (
      assemblerQuest: newAssemblerQuest,
      sourceMainQuest: assembledMainQuest,
    );
  }

  void handleUpdateAssemblerQuest() {
    final selectedTimeSlot = state.selectedTimeSlot;
    final editingQuest = state.editingQuest;
    if (selectedTimeSlot == null || editingQuest == null) return;

    final updatedQuest = editingQuest.copyWith(
      startTime: selectedTimeSlot.startTime,
      endTime: selectedTimeSlot.endTime,
    );

    IsarDataStore.updateAssemblerMainQuest(editingQuest.id, updatedQuest);
    resetTimeSlot();
  }

  void handleDeleteEditedQuest() {
    final editingQuest = state.editingQuest;
    if (editingQuest == null) return;

    IsarDataStore.deleteAssemblerMainQuest(editingQuest);
    resetTimeSlot();
  }

  void handleDeleteSourceMainQuest(MainQuest mainQuest) {
    IsarDataStore.deleteMainQuest(mainQuest);
  }
}
