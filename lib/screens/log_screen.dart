import 'package:flutter/material.dart';
import 'package:questlog/data/dummy_quests.dart';
import 'package:questlog/widgets/log_screen/active_protocol.dart';
import 'package:questlog/widgets/log_screen/daily_assembler.dart';
import 'package:questlog/widgets/log_screen/main_quests.dart';
import 'package:questlog/widgets/log_screen/side_quests.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            spacing: 25,
            children: [
              DailyAssembler(quests: dailyAssemblerQuests),
              ActiveProtocol(
                activeQuest: dailyAssemblerQuests.firstWhere(
                  (quest) =>
                      quest.status == .active || quest.status == .pending,
                ),
              ),
              SideQuests(sideQuests: dummySideQuests),
              MainQuests(mainQuests: dummyMainQuests),
            ],
          ),
        ),
      ),
    );
  }
}
