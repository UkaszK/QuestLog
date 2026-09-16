import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/assembler_main_quest.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/data/time_slot.dart';
import 'package:questlog/providers/quest_providers.dart';
import 'package:questlog/screens/select_main_quest_screen.dart';

typedef AssemblerState = ({List<AssemblerMainQuest> selectedDayQuests});

typedef AssemblerViewState = ({
  DateTime selectedDay,
  TimeSlot? selectedTimeSlot,
  MainQuest? assembledMainQuest,
  AssemblerMainQuest? editingQuest,
});

final assemblerStateProvider =
    Provider.family<AsyncValue<AssemblerState>, DateTime>((ref, date) {
      final selectedDayQuestsAsync = ref.watch(
        assemblerMainQuestsForDayProvider(date),
      );

      // Loading
      if (selectedDayQuestsAsync.isLoading) {
        return const AsyncLoading();
      }

      // Errors
      if (selectedDayQuestsAsync.hasError) {
        return AsyncError(
          selectedDayQuestsAsync.error!,
          selectedDayQuestsAsync.stackTrace!,
        );
      }

      return AsyncData((
        selectedDayQuests: selectedDayQuestsAsync.requireValue,
      ));
    });

final assemblerViewStateNotifierProvider =
    NotifierProvider<AssemblerViewStateNotifier, AssemblerViewState>(
      () => AssemblerViewStateNotifier(),
    );

class AssemblerViewStateNotifier extends Notifier<AssemblerViewState> {
  @override
  AssemblerViewState build() => (
    selectedDay: DateUtils.dateOnly(DateTime.now()),
    selectedTimeSlot: null,
    assembledMainQuest: null,
    editingQuest: null,
  );

  void resetTimeSlot() {
    state = (
      selectedDay: state.selectedDay,
      selectedTimeSlot: null,
      assembledMainQuest: null,
      editingQuest: null,
    );
  }

  void updateSelectedTimeSlot(TimeSlot timeSlot) {
    state = (
      selectedDay: state.selectedDay,
      selectedTimeSlot: timeSlot,
      assembledMainQuest: state.assembledMainQuest,
      editingQuest: state.editingQuest,
    );
  }

  void handleSelectExistingAssemblerQuest(
    AssemblerMainQuest assemblerMainQuest,
  ) {
    state = (
      selectedDay: state.selectedDay,
      selectedTimeSlot: (
        startTime: assemblerMainQuest.startTime,
        endTime: assemblerMainQuest.endTime,
      ),
      assembledMainQuest: null,
      editingQuest: assemblerMainQuest,
    );
  }

  void handleAddMainQuestToAssemble(MainQuest mainQuest) {
    final today = DateUtils.dateOnly(DateTime.now());
    final defaultTimeSlot = (
      startTime: today,
      endTime: today.add(const Duration(hours: 2)),
    );

    state = (
      selectedDay: today,
      selectedTimeSlot: state.selectedTimeSlot ?? defaultTimeSlot,
      assembledMainQuest: mainQuest,
      editingQuest: state.editingQuest,
    );
  }

  void handleQuestCleared() {
    state = (
      selectedDay: state.selectedDay,
      selectedTimeSlot: state.selectedTimeSlot,
      assembledMainQuest: null,
      editingQuest: state.editingQuest,
    );
  }

  MainQuest? handleCreateAssemblerQuest() {
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

    return assembledMainQuest;
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

  void handleUpdateAssemblerQuestDetails({
    required String name,
    required List<SubTask> subTasks,
  }) {
    final editingQuest = state.editingQuest;
    if (editingQuest == null) return;

    final updatedQuest = editingQuest.copyWith(name: name, subTasks: subTasks);

    IsarDataStore.updateAssemblerMainQuest(editingQuest.id, updatedQuest);

    // Keep the bar open with the refreshed quest so time slot edits still work.
    state = (
      selectedDay: state.selectedDay,
      selectedTimeSlot: state.selectedTimeSlot,
      assembledMainQuest: state.assembledMainQuest,
      editingQuest: updatedQuest,
    );
  }

  void handleDeleteEditedQuest() {
    final editingQuest = state.editingQuest;
    if (editingQuest == null) return;

    IsarDataStore.deleteAssemblerMainQuest(editingQuest);
    resetTimeSlot();
  }

  void onClickAddQuest(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectMainQuestScreen()),
    );
  }

  void updateSelectedDay(DateTime date) {
    final normalizedDate = DateUtils.dateOnly(date);
    state = (
      selectedDay: normalizedDate,
      selectedTimeSlot: null,
      assembledMainQuest: null,
      editingQuest: null,
    );
  }
}
