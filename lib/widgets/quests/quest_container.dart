import 'package:flutter/material.dart';
import 'package:questlog/theme/quest_log_colors.dart';

class QuestContainer extends StatelessWidget {
  const QuestContainer({super.key, required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: QuestLogColors.surface,
        border: Border(
          top: BorderSide(color: color, width: 0.5),
          right: BorderSide(color: color, width: 0.5),
          bottom: BorderSide(color: color, width: 0.5),
          left: BorderSide(color: color, width: 5),
        ),
      ),
      child: child,
    );
  }
}
