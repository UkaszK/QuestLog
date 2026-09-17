import 'package:flutter/painting.dart';
import 'package:questlog/theme/quest_log_colors.dart';

enum QuestType {
  main(label: 'Main Quest', color: QuestLogColors.accent),
  side(label: 'Side Quest', color: QuestLogColors.otherAccent);

  const QuestType({required this.label, required this.color});

  final String label;
  final Color color;
}
