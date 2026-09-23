import 'package:flutter/material.dart';
import 'package:questlog/screens/quest_form_screen.dart';
import 'package:questlog/theme/quest_log_colors.dart';

class QuestLogFAB extends StatelessWidget {
  const QuestLogFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: QuestLogColors.accent.withValues(alpha: 0.4),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: FloatingActionButton(
          heroTag: 'main_center_fab',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuestFormScreen()),
            );
          },
          backgroundColor: QuestLogColors.accent,
          shape: CircleBorder(
            side: BorderSide(
              color: QuestLogColors.black.withValues(alpha: 0.8),
              width: 3,
            ),
          ),
          elevation: 2,
          child: Icon(Icons.add, color: QuestLogColors.black, size: 32),
        ),
      ),
    );
  }
}
