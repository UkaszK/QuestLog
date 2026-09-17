import 'package:flutter/material.dart';
import 'package:questlog/theme/quest_log_colors.dart';

enum QuestStatus {
  open(label: 'Upcoming', color: QuestLogColors.textSecondary),
  completed(label: 'Done', color: QuestLogColors.success),
  active(label: 'Active', color: QuestLogColors.accent),
  pending(label: 'Overdue', color: QuestLogColors.warning);

  const QuestStatus({required this.label, required this.color});

  final String label;
  final Color color;
}
