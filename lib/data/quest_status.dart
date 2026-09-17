import 'package:flutter/material.dart';
import 'package:questlog/theme/quest_log_colors.dart';

enum QuestStatus {
  open,
  completed,
  active,
  pending;

  Color get color {
    return switch (this) {
      QuestStatus.open => QuestLogColors.textSecondary,
      QuestStatus.completed => QuestLogColors.success,
      QuestStatus.active => QuestLogColors.accent,
      QuestStatus.pending => QuestLogColors.warning,
    };
  }

  String get label {
    return switch (this) {
      QuestStatus.open => 'Upcoming',
      QuestStatus.completed => 'Done',
      QuestStatus.active => 'Active',
      QuestStatus.pending => 'Overdue',
    };
  }
}
