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

class LogScreen extends StatelessWidget {
  const LogScreen({super.key});

  List<AssemblerQuest> get _assemblerQuests {
    return IsarDataStore.getAllAssemblerQuests()
        .where(
          (assemblerQuest) =>
              DateUtils.isSameDay(assemblerQuest.startTime, DateTime.now()),
        )
        .toList();
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
          DailyAssembler(assemblerQuests: _assemblerQuests),
          if (activeQuest != null) ActiveProtocol(activeQuest: activeQuest),
          if (sideQuests.isNotEmpty) SideQuests(sideQuests: sideQuests),
          if (mainQuests.isNotEmpty) MainQuests(mainQuests: mainQuests),

          if (sideQuests.isEmpty && mainQuests.isEmpty) BacklogEmptyNote(),
        ],
      ),
    );
  }
}
