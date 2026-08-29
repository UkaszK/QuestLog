import 'package:flutter/material.dart';
import 'package:questlog/theme/questlog_colors.dart';

enum QuestPriority { low, normal, high }

String priorityLabel(QuestPriority questPriority) {
  return switch (questPriority) {
    .low => 'Low',
    .normal => 'Medium',
    .high => 'High',
  };
}

Color priorityColor(QuestPriority questPriority) {
  return switch (questPriority) {
    .low => QuestLogColors.success,
    .normal => QuestLogColors.info,
    .high => QuestLogColors.warning,
  };
}

IconData priorityIcon(QuestPriority questPriority) {
  return switch (questPriority) {
    .low => Icons.low_priority,
    .normal => Icons.check,
    .high => Icons.priority_high,
  };
}
