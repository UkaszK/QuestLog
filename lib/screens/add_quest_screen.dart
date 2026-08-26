import 'package:flutter/material.dart';
import 'package:questlog/widgets/questlog_app_bar.dart';

class AddQuestScreen extends StatefulWidget {
  const AddQuestScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddQuestScreenState();
}

class _AddQuestScreenState extends State<AddQuestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuestLogAppBar(),
      body: const Center(child: Text('Add Quest')),
    );
  }
}
