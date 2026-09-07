import 'package:flutter/material.dart';
import 'package:questlog/theme/questlog_colors.dart';

class QuestLogLoadingScreen extends StatelessWidget {
  const QuestLogLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: QuestLogColors.accent),
      ),
    );
  }
}
