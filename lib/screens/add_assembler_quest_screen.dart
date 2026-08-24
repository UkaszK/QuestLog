import 'package:flutter/material.dart';
import 'package:questlog/widgets/questlog_app_bar.dart';

class AddAssemblerQuestScreen extends StatelessWidget {
  const AddAssemblerQuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuestLogAppBar(),
      body: const Center(child: Text('Add Assembler Quest')),
    );
  }
}
