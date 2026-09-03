import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/data/assembler_side_quest.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/widgets/log_screen/scheduled_main_quests/assembler_quests.dart';
import 'package:questlog/widgets/log_screen/side_quests/side_quests.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<AssemblerMainQuest> _assemblerMainQuests = [];
  List<SideQuest> _sideQuests = [];
  List<AssemblerSideQuest> _todayAssemblerSideQuests = [];

  @override
  void initState() {
    super.initState();
    _assemblerMainQuests = _fetchAssemblerMainQuests();
    _sideQuests = IsarDataStore.getAllSideQuests();
    _todayAssemblerSideQuests = _fetchTodayAssemblerSideQuests();
  }

  List<AssemblerMainQuest> _fetchAssemblerMainQuests() {
    return IsarDataStore.getAllAssemblerQuests()
        .where(
          (assemblerQuest) =>
              DateUtils.isSameDay(assemblerQuest.startTime, DateTime.now()),
        )
        .sorted(((a, b) => a.compareTo(b)))
        .toList();
  }

  List<AssemblerSideQuest> _fetchTodayAssemblerSideQuests() {
    return IsarDataStore.getAllAssemblerSideQuests()
        .where(
          (assemblerSideQuest) => DateUtils.isSameDay(
            assemblerSideQuest.occurrenceDate,
            DateTime.now(),
          ),
        )
        .toList();
  }

  void _handleCheckAssemblerQuest(
    AssemblerMainQuest assemblerQuest,
    bool newValue,
  ) {
    final updatedSubTasks = assemblerQuest.subTasks
        .map((subTask) => SubTask(name: subTask.name, completed: newValue))
        .toList();
    final updatedAssemblerQuest = AssemblerMainQuest(
      mainQuestId: assemblerQuest.mainQuestId,
      name: assemblerQuest.name,
      questCategoryName: assemblerQuest.questCategoryName,
      subTasks: updatedSubTasks,
      startTime: assemblerQuest.startTime,
      endTime: assemblerQuest.endTime,
      completed: newValue,
    );

    IsarDataStore.updateAssemblerQuest(
      assemblerQuest.id,
      updatedAssemblerQuest,
    );

    setState(() {
      _assemblerMainQuests = _fetchAssemblerMainQuests();
    });
  }

  void _handleCheckSubTask(
    AssemblerMainQuest assemblerQuest,
    SubTask subTask,
    bool newValue,
  ) {
    final subTaskIndex = assemblerQuest.subTasks.indexWhere(
      (st) => identical(st, subTask),
    );
    if (subTaskIndex == -1) return;

    final updatedSubTasks = List<SubTask>.from(assemblerQuest.subTasks);
    updatedSubTasks[subTaskIndex] = SubTask(
      name: subTask.name,
      completed: newValue,
    );

    final updatedAssemblerQuest = AssemblerMainQuest(
      mainQuestId: assemblerQuest.mainQuestId,
      name: assemblerQuest.name,
      questCategoryName: assemblerQuest.questCategoryName,
      subTasks: updatedSubTasks,
      startTime: assemblerQuest.startTime,
      endTime: assemblerQuest.endTime,
      completed: assemblerQuest.completed,
    );

    IsarDataStore.updateAssemblerQuest(
      assemblerQuest.id,
      updatedAssemblerQuest,
    );

    setState(() {
      _assemblerMainQuests = _fetchAssemblerMainQuests();
    });
  }

  void _handleCheckSideQuest(SideQuest sideQuest, bool newValue) {
    final now = DateTime.now();
    final existing = _todayAssemblerSideQuests.firstWhereOrNull(
      (assemblerSideQuest) => assemblerSideQuest.sideQuestId == sideQuest.id,
    );

    if (!newValue) {
      if (existing != null) {
        IsarDataStore.deleteAssemblerSideQuest(existing);
      }
    } else {
      final updatedAssemblerSideQuest = AssemblerSideQuest(
        sideQuestId: sideQuest.id,
        name: sideQuest.name,
        questCategoryName: sideQuest.questCategoryName,
        occurrenceDate: DateTime(now.year, now.month, now.day),
        completedAt: now,
      );

      if (existing != null) {
        IsarDataStore.updateAssemblerSideQuest(
          existing.id,
          updatedAssemblerSideQuest,
        );
      } else {
        IsarDataStore.addAssemblerSideQuest(updatedAssemblerSideQuest);
      }
    }

    setState(() {
      _todayAssemblerSideQuests = _fetchTodayAssemblerSideQuests();
    });
  }

  @override
  Widget build(BuildContext context) {
    final completedSideQuestIds = _todayAssemblerSideQuests
        .where((assemblerSideQuest) => assemblerSideQuest.completed)
        .map((assemblerSideQuest) => assemblerSideQuest.sideQuestId)
        .toSet();

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 150),
      child: Column(
        spacing: 25,
        children: [
          AssemblerQuests(
            assemblerQuests: _assemblerMainQuests,
            onCheckQuest: _handleCheckAssemblerQuest,
            onCheckSubTask: _handleCheckSubTask,
          ),
          SideQuests(
            sideQuests: _sideQuests,
            completedSideQuestIds: completedSideQuestIds,
            onCheckSideQuest: _handleCheckSideQuest,
          ),
        ],
      ),
    );
  }
}
