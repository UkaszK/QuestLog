import 'package:flutter/material.dart';
import 'package:questlog/theme/questlog_colors.dart';

enum QuestPriority {
  low,
  normal,
  high;

  String get label {
    return switch (this) {
      .low => 'Low',
      .normal => 'Medium',
      .high => 'High',
    };
  }

  Color get color {
    return switch (this) {
      .low => QuestLogColors.success,
      .normal => QuestLogColors.info,
      .high => QuestLogColors.warning,
    };
  }

  IconData get icon {
    return switch (this) {
      .low => Icons.low_priority,
      .normal => Icons.check,
      .high => Icons.priority_high,
    };
  }
}
