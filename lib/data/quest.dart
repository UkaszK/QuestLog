import 'package:flutter/material.dart';
import 'package:questlog/theme/questlog_colors.dart';

enum QuestStatus { open, completed, active, pending }

class Quest {
  const Quest({
    required this.icon,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.subTasks,
  });

  final IconData icon;
  final String name;
  final String startTime;
  final String endTime;
  final QuestStatus status;
  final Map<String, bool> subTasks;

  static Color statusColor(QuestStatus status) {
    return switch (status) {
      QuestStatus.open => QuestLogColors.textSecondary,
      QuestStatus.completed => QuestLogColors.success,
      QuestStatus.active => QuestLogColors.accent,
      QuestStatus.pending => QuestLogColors.warning,
    };
  }

  String timeLabel() {
    return switch (status) {
      QuestStatus.completed => 'COMPLETED',
      QuestStatus.pending => 'PENDING',
      _ => '$startTime -\n$endTime',
    };
  }
}
