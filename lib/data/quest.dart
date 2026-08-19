import 'package:flutter/material.dart';
import 'package:questlog/constants/themed_colors.dart';

enum QuestStatus { open, completed, active, pending }

class Quest {
  const Quest({
    required this.icon,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  final IconData icon;
  final String name;
  final String startTime;
  final String endTime;
  final QuestStatus status;

  static Color statusColor(QuestStatus status) {
    return switch (status) {
      QuestStatus.open => ThemedColors.textSecondary,
      QuestStatus.completed => ThemedColors.success,
      QuestStatus.active => ThemedColors.accent,
      QuestStatus.pending => ThemedColors.warning,
    };
  }
}
