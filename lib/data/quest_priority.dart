import 'package:flutter/material.dart';
import 'package:questlog/theme/quest_log_colors.dart';

enum QuestPriority {
  low(label: 'Low', color: QuestLogColors.success, icon: Icons.low_priority),
  normal(label: 'Normal', color: QuestLogColors.info, icon: Icons.check),
  high(label: 'High', color: QuestLogColors.warning, icon: Icons.priority_high);

  const QuestPriority({
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;
}
