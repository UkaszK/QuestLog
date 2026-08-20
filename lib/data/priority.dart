import 'package:flutter/material.dart';
import 'package:questlog/theme/questlog_colors.dart';

enum Priority { low, medium, high }

String priorityLabel(Priority priority) {
  return switch (priority) {
    .low => 'Low',
    .medium => 'Medium',
    .high => 'High',
  };
}

Color priorityColor(Priority priority) {
  return switch (priority) {
    .low => QuestLogColors.success,
    .medium => QuestLogColors.info,
    .high => QuestLogColors.warning,
  };
}

IconData priorityIcon(Priority priority) {
  return switch (priority) {
    .low => Icons.low_priority,
    .medium => Icons.accessible,
    .high => Icons.priority_high,
  };
}
