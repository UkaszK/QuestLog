import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/assembler_main_quest.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/time_slot.dart';
import 'package:questlog/providers/assembler_providers.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/utils/DateTime/date_time_extension.dart';
import 'package:questlog/widgets/assembler_screen/assemble_quest_screen/active_time_slot_bar.dart';
import 'package:questlog/widgets/assembler_screen/assemble_quest_screen/edit_assembler_quest_sheet.dart';
import 'package:questlog/widgets/assembler_screen/assembler.dart';
import 'package:questlog/widgets/assembler_screen/day_picker.dart';
import 'package:questlog/widgets/quest_log_loading_screen.dart';

class AssemblerScreen extends ConsumerWidget {
  const AssemblerScreen({super.key});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> editQuestDetails(AssemblerMainQuest quest) async {
      final details = await showEditAssemblerQuestSheet(context, quest);
      if (details == null) return;

      ref
          .read(assemblerViewStateNotifierProvider.notifier)
          .handleUpdateAssemblerQuestDetails(
            name: details.name,
            subTasks: details.subTasks,
          );
    }

    final notifier = ref.read(assemblerViewStateNotifierProvider.notifier);
    final assemblerViewState = ref.watch(assemblerViewStateNotifierProvider);
    final selectedDay = assemblerViewState.selectedDay;
    final assemblerDataStateAsync = ref.watch(
      assemblerStateProvider(selectedDay),
    );

    final DateTime baseDate = DateUtils.dateOnly(selectedDay);
    final TimeSlot? selectedTimeSlot = assemblerViewState.selectedTimeSlot;
    final AssemblerMainQuest? editingQuest = assemblerViewState.editingQuest;
    final MainQuest? assembledMainQuest = assemblerViewState.assembledMainQuest;
    final bool hasTimeSlot = selectedTimeSlot != null;
    final String assembledQuestName =
        assembledMainQuest?.name ?? editingQuest?.name ?? '';

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
                          selectedDay: selectedDay,
                          onDaySelected: (value) {
                            notifier.updateSelectedDay(value);
                          },
                        ),
                        _AssemblerTitle(
                          rightSide: Text(
                            selectedDay.toDDMMYYYY(),
                            style: GoogleFonts.jetBrainsMono(
                              color: QuestLogColors.accent,
                              fontSize: 10,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Divider(height: 1),

                        Assembler(
                          baseDate: baseDate,
                          assemblerQuests: state.selectedDayQuests,
                          displayInsertBlocks: !hasTimeSlot,
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
                            onAddMainQuestToAssemble:
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
                                notifier.onClickAddQuest(context),
                            onEditDetails: () {
                              if (editingQuest == null) return;
                              editQuestDetails(editingQuest);
                            },
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
      error: (error, stack) => Center(child: Text('Error loading: $error')),
      loading: () => QuestLogLoadingScreen(),
    );
  }
}

class _AssemblerTitle extends StatelessWidget {
  const _AssemblerTitle({required this.rightSide});

  final Widget rightSide;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'ASSEMBLER',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),

        rightSide,
      ],
    );
  }
}
