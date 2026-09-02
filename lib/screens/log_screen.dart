import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/widgets/log_screen/active_protocol.dart';
import 'package:questlog/widgets/log_screen/backlog_empty_note.dart';
import 'package:questlog/widgets/log_screen/daily_assembler.dart';
import 'package:questlog/widgets/log_screen/main_quests/main_quests.dart';
import 'package:questlog/widgets/log_screen/side_quests.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  List<AssemblerQuest> _assemblerQuests = [];

  @override
  void initState() {
    super.initState();
    _assemblerQuests = _fetchAssemblerQuests();
  }

  List<AssemblerQuest> _fetchAssemblerQuests() {
    return IsarDataStore.getAllAssemblerQuests()
        .where(
          (assemblerQuest) =>
              DateUtils.isSameDay(assemblerQuest.startTime, DateTime.now()),
        )
        .toList();
  }

  void _handleCompleteQuest(AssemblerQuest assemblerQuest) {
    IsarDataStore.updateAssemblerQuest(
      assemblerQuest.id,
      AssemblerQuest(
        questInfo: assemblerQuest.questInfo,
        startTime: assemblerQuest.startTime,
        endTime: assemblerQuest.endTime,
        completed: !assemblerQuest.completed,
      ),
    );

    setState(() {
      _assemblerQuests = _fetchAssemblerQuests();
    });
  }

  @override
  Widget build(BuildContext context) {
    AssemblerQuest? activeQuest = _assemblerQuests.firstWhereOrNull(
      (assemblerQuest) =>
          assemblerQuest.status == QuestStatus.active ||
          assemblerQuest.status == QuestStatus.pending,
    );

    List<SideQuest> sideQuests = IsarDataStore.getAllSideQuests();
    List<MainQuest> mainQuests = IsarDataStore.getAllMainQuests();

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 150),
      child: Column(
        spacing: 25,
        children: [
          DailyAssembler(
            assemblerQuests: _assemblerQuests,
            onCompleteQuest: _handleCompleteQuest,
          ),
          if (activeQuest != null)
            ActiveProtocol(
              assemblerQuest: activeQuest,
              onCompleteQuest: _handleCompleteQuest,
            ),
          if (sideQuests.isNotEmpty) SideQuests(sideQuests: sideQuests),
          if (mainQuests.isNotEmpty) MainQuests(mainQuests: mainQuests),

          if (sideQuests.isEmpty && mainQuests.isEmpty) BacklogEmptyNote(),
        ],
      ),
    );
  }
}
