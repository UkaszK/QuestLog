import 'package:flutter/material.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/data/dummy_data.dart';
import 'package:questlog/widgets/log_screen/active_protocol.dart';
import 'package:questlog/widgets/log_screen/daily_assembler.dart';
import 'package:questlog/widgets/log_screen/main_quests/main_quests.dart';
import 'package:questlog/widgets/log_screen/side_quests.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({super.key});

  List<AssemblerQuest> get _assemblerQuests {
    return dailyAssemblerQuests
        .where((quest) => DateUtils.isSameDay(quest.startTime, DateTime.now()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 150),
      child: Column(
        spacing: 25,
        children: [
          DailyAssembler(assemblerQuests: _assemblerQuests),
          ActiveProtocol(
            activeQuest: _assemblerQuests.firstWhere(
              (quest) => quest.status == .active || quest.status == .pending,
            ),
          ),
          SideQuests(sideQuests: dummySideQuests),
          MainQuests(mainQuests: dummyMainQuests),
        ],
      ),
    );
  }
}
