import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/quest_categories.dart';
import 'package:questlog/data/quest_info.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/data/time_slot.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/utils/get_main_quests_by_category.dart';
import 'package:questlog/widgets/assembler_screen/assemble_quest_screen/active_time_slot_bar.dart';
import 'package:questlog/widgets/assembler_screen/assembler.dart';
import 'package:questlog/widgets/assembler_screen/assembler_title.dart';
import 'package:questlog/widgets/assembler_screen/day_picker.dart';

class AssemblerScreen extends StatefulWidget {
  const AssemblerScreen({super.key});

  @override
  State<AssemblerScreen> createState() => _AssemblerScreenState();
}

class _AssemblerScreenState extends State<AssemblerScreen> {
  DateTime _selectedDay = DateTime.now();
  TimeSlot? _selectedTimeSlot;
  MainQuest? _assembledMainQuest;
  AssemblerQuest? _editingQuest;

  List<AssemblerQuest> get _selectedDayQuests {
    return IsarDataStore.getAllAssemblerQuests()
        .where(
          (assemblerQuest) =>
              DateUtils.isSameDay(assemblerQuest.startTime, _selectedDay),
        )
        .toList();
  }

  bool get _isPastDay {
    final today = DateTime.now();
    final selectedDate = DateTime(
      _selectedDay.year,
      _selectedDay.month,
      _selectedDay.day,
    );
    return selectedDate.isBefore(DateTime(today.year, today.month, today.day));
  }

  bool get _hasOverlap {
    if (_selectedTimeSlot == null) return false;
    return _selectedDayQuests.any(
      (assemblerQuest) =>
          !(assemblerQuest.id == _editingQuest?.id) &&
          _selectedTimeSlot!.startTime.isBefore(assemblerQuest.endTime) &&
          _selectedTimeSlot!.endTime.isAfter(assemblerQuest.startTime),
    );
  }

  void _resetTimeSlot() {
    setState(() {
      _selectedTimeSlot = null;
      _assembledMainQuest = null;
      _editingQuest = null;
    });
  }

  void _updateSelectedTimeSlot(TimeSlot slot) {
    setState(() {
      _selectedTimeSlot = slot;
    });
  }

  void _handleSelectExistingQuest(AssemblerQuest quest) {
    setState(() {
      _editingQuest = quest;
    });
  }

  void _handleQuestAssembled(MainQuest mainQuest) {
    setState(() {
      _assembledMainQuest = mainQuest;
    });
  }

  void _handleQuestCleared() {
    setState(() {
      _assembledMainQuest = null;
    });
  }

  void _handleSave() {
    if (_editingQuest != null) {
      _handleSaveEditedQuest();
    } else {
      _handleSaveAssembledQuest();
    }
  }

  void _handleSaveAssembledQuest() {
    if (_selectedTimeSlot == null || _assembledMainQuest == null) return;
    if (_hasOverlap) return;

    final questInfo = QuestInfo(
      name: _assembledMainQuest!.name,
      questCategoryName: _assembledMainQuest!.questCategoryName,
      subTasks: _assembledMainQuest!.subTasks
          .map((subTask) => SubTask(name: subTask, completed: false))
          .toList(),
    );

    final newAssemblerQuest = AssemblerQuest(
      questInfo: questInfo,
      startTime: _selectedTimeSlot!.startTime,
      endTime: _selectedTimeSlot!.endTime,
    );

    _showDeleteJustAssembledQuestDialog(
      newAssemblerQuest,
      _assembledMainQuest!,
    );

    setState(() {
      IsarDataStore.addAssemblerQuest(newAssemblerQuest);
      _resetTimeSlot();
    });
  }

  Future<void> _showDeleteJustAssembledQuestDialog(
    AssemblerQuest assemblerQuest,
    MainQuest assembledMainQuest,
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
          'Do you want to delete Main Quest "${assemblerQuest.questInfo.name}"?',
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

    if (shouldDelete == true && mounted) {
      setState(() {
        IsarDataStore.deleteMainQuest(assembledMainQuest);
      });
    }
  }

  void _handleSaveEditedQuest() {
    if (_selectedTimeSlot == null || _editingQuest == null) return;
    if (_hasOverlap) return;

    final updatedQuest = AssemblerQuest(
      questInfo: _editingQuest!.questInfo,
      startTime: _selectedTimeSlot!.startTime,
      endTime: _selectedTimeSlot!.endTime,
      completed: _editingQuest!.completed,
    );

    setState(() {
      IsarDataStore.updateAssemblerQuest(_editingQuest!.id, updatedQuest);
      _resetTimeSlot();
    });
  }

  void _handleDeleteEditedQuest() {
    if (_editingQuest == null) return;

    setState(() {
      IsarDataStore.deleteAssemblerQuest(_editingQuest!);
      _resetTimeSlot();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasTimeSlot = _selectedTimeSlot != null;
    final bool hasAssembledQuest =
        _assembledMainQuest != null || _editingQuest != null;
    final String assembledQuestName =
        _assembledMainQuest?.name ?? _editingQuest?.questInfo.name ?? '';
    final DateTime baseDate = DateTime(
      _selectedDay.year,
      _selectedDay.month,
      _selectedDay.day,
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
                        setState(() {
                          _selectedDay = value;
                          _resetTimeSlot();
                        });
                      },
                      assemblerQuests: IsarDataStore.getAllAssemblerQuests(),
                    ),
                    AssemblerTitle(),

                    const SizedBox(height: 10),

                    const Divider(height: 1),

                    Assembler(
                      baseDate: baseDate,
                      assemblerQuests: _selectedDayQuests,
                      displayInsertBlocks: !_isPastDay && !hasTimeSlot,
                      isPastDay: _isPastDay,
                      hasOverlap: _hasOverlap,
                      selectedTimeSlot: _selectedTimeSlot,
                      onSelectTimeSlot: _updateSelectedTimeSlot,
                      onUpdateTimeSlot: _updateSelectedTimeSlot,
                      onSelectExistingQuest: _handleSelectExistingQuest,
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
                        timeSlot: _selectedTimeSlot!,
                        onReset: _resetTimeSlot,
                        hasAssembledQuest: hasAssembledQuest,
                        mainQuestsByCategory: getMainQuestsByCategory(
                          questCategories,
                          IsarDataStore.getAllMainQuests(),
                        ),
                        onQuestAssembled: _handleQuestAssembled,
                        assembledQuestName: assembledQuestName,
                        onSave: _handleSave,
                        onClearQuest: _handleQuestCleared,
                        hasOverlap: _hasOverlap,
                        isEditingExistingQuest: _editingQuest != null,
                        onDelete: _handleDeleteEditedQuest,
                        onUpdateTimeSlot: _updateSelectedTimeSlot,
                      )
                    : const SizedBox.shrink(key: ValueKey('slot-bar-empty')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
