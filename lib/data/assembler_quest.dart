import 'package:flutter/material.dart';
import 'package:questlog/data/quest_info.dart';
import 'package:questlog/theme/questlog_colors.dart';

enum QuestStatus { open, completed, active, pending }

class AssemblerQuest {
  const AssemblerQuest({
    required this.questInfo,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  final QuestInfo questInfo;
  final String startTime;
  final String endTime;
  final QuestStatus status;

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
