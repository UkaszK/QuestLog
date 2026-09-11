import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/assembler_main_quest.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/time_slot.dart';
import 'package:questlog/providers/assembler_providers.dart';
import 'package:questlog/providers/navigation_bar_providers.dart';
import 'package:questlog/widgets/assembler_screen/assemble_quest_screen/active_time_slot_bar.dart';
import 'package:questlog/widgets/assembler_screen/assembler.dart';
import 'package:questlog/widgets/assembler_screen/assembler_title.dart';
import 'package:questlog/widgets/assembler_screen/day_picker.dart';
import 'package:questlog/widgets/quest_log_loading_screen.dart';

class AssemblerScreen extends ConsumerStatefulWidget {
  const AssemblerScreen({super.key});

  @override
  ConsumerState<AssemblerScreen> createState() => _AssemblerScreenState();
}

class _AssemblerScreenState extends ConsumerState<AssemblerScreen> {
  DateTime _selectedDay = DateTime.now();

  bool _hasOverlap(
    List<AssemblerMainQuest> assemblerMainQuests,
    TimeSlot? selectedTimeSlot,
    AssemblerMainQuest? editingQuest,
  ) {
    if (selectedTimeSlot == null) return false;
    return assemblerMainQuests.any(
      (assemblerQuest) =>
          !(assemblerQuest.id == editingQuest?.id) &&
          selectedTimeSlot.startTime.isBefore(assemblerQuest.endTime) &&
          selectedTimeSlot.endTime.isAfter(assemblerQuest.startTime),
    );
  }

  bool _isPastDay(DateTime date) {
    final today = DateUtils.dateOnly(DateTime.now());
    final selectedDate = DateUtils.dateOnly(date);
    return selectedDate.isBefore(today);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(assemblerViewStateNotifierProvider.notifier);
    final assemblerViewState = ref.watch(assemblerViewStateNotifierProvider);
    final assemblerDataStateAsync = ref.watch(
      assemblerDataStateProvider(_selectedDay),
    );
    final navigationNotifier = ref.read(navigationProvider.notifier);

    final DateTime baseDate = DateUtils.dateOnly(_selectedDay);
    final TimeSlot? selectedTimeSlot = assemblerViewState.selectedTimeSlot;
    final AssemblerMainQuest? editingQuest = assemblerViewState.editingQuest;
    final MainQuest? assembledMainQuest = assemblerViewState.assembledMainQuest;
    final bool hasTimeSlot = selectedTimeSlot != null;
    final String assembledQuestName =
        assembledMainQuest?.name ?? editingQuest?.name ?? '';

    final isPastDay = _isPastDay(_selectedDay);

    return assemblerDataStateAsync.when(
      data: (state) {
        final hasOverlap = _hasOverlap(
          state.selectedDayQuests,
          selectedTimeSlot,
          editingQuest,
        );
        return Scaffold(
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 16,
                      right: 16,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DayPicker(
                          selectedDay: _selectedDay,
                          onDaySelected: (value) {
                            setState(() => _selectedDay = value);
                            notifier.resetTimeSlot();
                          },
                        ),
                        AssemblerTitle(),

                        const SizedBox(height: 10),

                        const Divider(height: 1),

                        Assembler(
                          baseDate: baseDate,
                          assemblerQuests: state.selectedDayQuests,
                          displayInsertBlocks: !isPastDay && !hasTimeSlot,
                          isPastDay: isPastDay,
                          hasOverlap: hasOverlap,
                          selectedTimeSlot: selectedTimeSlot,
                          onSelectTimeSlot: notifier.updateSelectedTimeSlot,
                          onUpdateTimeSlot: notifier.updateSelectedTimeSlot,
                          onSelectExistingQuest:
                              notifier.handleSelectExistingAssemblerQuest,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, -1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                    child: hasTimeSlot
                        ? ActiveTimeSlotBar(
                            key: const ValueKey('active-slot-bar'),
                            timeSlot: selectedTimeSlot,
                            onReset: notifier.resetTimeSlot,
                            onQuestAssembled:
                                notifier.handleAddMainQuestToAssemble,
                            assembledQuestName: assembledQuestName,
                            onSave: () {
                              if (editingQuest != null) {
                                notifier.handleUpdateAssemblerQuest();
                                return;
                              }
                              notifier.handleCreateAssemblerQuest();
                            },
                            onClearQuest: notifier.handleQuestCleared,
                            hasOverlap: hasOverlap,
                            isEditingExistingQuest: editingQuest != null,
                            onDelete: notifier.handleDeleteEditedQuest,
                            onUpdateTimeSlot: notifier.updateSelectedTimeSlot,
                            onClickAddQuest: () =>
                                navigationNotifier.setIndex(3),
                          )
                        : const SizedBox.shrink(
                            key: ValueKey('slot-bar-empty'),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stack) => Center(child: Text('Fehler beim Laden: $error')),
      loading: () => QuestLogLoadingScreen(),
    );
  }
}
