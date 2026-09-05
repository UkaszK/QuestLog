import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/assembler_main_quest.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/time_slot.dart';
import 'package:questlog/providers/assembler_providers.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/assembler_screen/assemble_quest_screen/active_time_slot_bar.dart';
import 'package:questlog/widgets/assembler_screen/assembler.dart';
import 'package:questlog/widgets/assembler_screen/assembler_title.dart';
import 'package:questlog/widgets/assembler_screen/day_picker.dart';

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

  Future<void> _showDeleteJustAssembledQuestDialog(
    AssembledQuestResult result,
  ) async {
    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: QuestLogColors.surface,
        title: Text(
          'Quest Assembled',
          style: GoogleFonts.jetBrainsMono(
            color: QuestLogColors.textPrimary,
            fontSize: 14,
          ),
        ),
        content: Text(
          'Do you want to delete "${result.assemblerQuest.name}" from your Main Quest backlog?',
          style: GoogleFonts.jetBrainsMono(
            color: QuestLogColors.textSecondary,
            fontSize: 12,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              'Keep',
              style: GoogleFonts.jetBrainsMono(
                color: QuestLogColors.accent,
                fontSize: 12,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              'Delete',
              style: GoogleFonts.jetBrainsMono(
                color: QuestLogColors.danger,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      IsarDataStore.deleteMainQuest(result.sourceMainQuest);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(assemblerNotifierProvider.notifier);
    final viewState = ref.watch(assemblerNotifierProvider);
    final assemblerStateAsync = ref.watch(assemblerStateProvider(_selectedDay));

    final DateTime baseDate = DateUtils.dateOnly(_selectedDay);
    final TimeSlot? selectedTimeSlot = viewState.selectedTimeSlot;
    final AssemblerMainQuest? editingQuest = viewState.editingQuest;
    final MainQuest? assembledMainQuest = viewState.assembledMainQuest;
    final bool hasTimeSlot = selectedTimeSlot != null;
    final bool hasAssembledQuest =
        assembledMainQuest != null || editingQuest != null;
    final String assembledQuestName =
        assembledMainQuest?.name ?? editingQuest?.name ?? '';

    final isPastDay = _isPastDay(_selectedDay);

    return assemblerStateAsync.when(
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
                            hasAssembledQuest: hasAssembledQuest,
                            onQuestAssembled: notifier.handleMainQuestAssembled,
                            assembledQuestName: assembledQuestName,
                            onSave: () {
                              if (editingQuest != null) {
                                notifier.handleUpdateAssemblerQuest();
                                return;
                              }
                              final result = notifier
                                  .handleCreateAssemblerQuest();
                              if (result != null) {
                                _showDeleteJustAssembledQuestDialog(result);
                              }
                            },
                            onClearQuest: notifier.handleQuestCleared,
                            hasOverlap: hasOverlap,
                            isEditingExistingQuest: editingQuest != null,
                            onDelete: notifier.handleDeleteEditedQuest,
                            onUpdateTimeSlot: notifier.updateSelectedTimeSlot,
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
      error: (_, _) => CircularProgressIndicator(color: QuestLogColors.accent),
      loading: () => CircularProgressIndicator(color: QuestLogColors.accent),
    );
  }
}
