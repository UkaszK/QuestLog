import 'package:flutter/material.dart';
import 'package:questlog/widgets/log_screen/active_protocol.dart';
import 'package:questlog/widgets/log_screen/daily_assembler.dart';
import 'package:questlog/widgets/log_screen/main_quests.dart';
import 'package:questlog/widgets/log_screen/side_quests.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DailyAssembler(),
          ActiveProtocol(),
          MainQuests(),
          SideQuests(),
        ],
      ),
    );
  }
}
