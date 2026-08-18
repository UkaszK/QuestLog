import 'package:flutter/material.dart';
import '../widgets/questlog_app_bar.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: QuestLogAppBar(), body: Text('Test'));
  }
}
