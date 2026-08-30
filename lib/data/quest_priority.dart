import 'package:flutter/material.dart';
import 'package:questlog/theme/questlog_colors.dart';

enum QuestPriority {
  low,
  normal,
  high;

  String get label {
    return switch (this) {
      QuestPriority.low => 'Low',
      QuestPriority.normal => 'Medium',
      QuestPriority.high => 'High',
    };
  }

  Color get color {
    return switch (this) {
      QuestPriority.low => QuestLogColors.success,
      QuestPriority.normal => QuestLogColors.info,
      QuestPriority.high => QuestLogColors.warning,
    };
  }

  IconData get icon {
    return switch (this) {
      QuestPriority.low => Icons.low_priority,
      QuestPriority.normal => Icons.check,
      QuestPriority.high => Icons.priority_high,
    };
  }
}
