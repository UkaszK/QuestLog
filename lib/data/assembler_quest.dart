import 'package:flutter/material.dart';
import 'package:questlog/data/quest_info.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/utils/stringify_duration.dart';
import 'package:questlog/utils/stringify_time_of_date.dart';

enum QuestStatus { open, completed, active, pending }

class AssemblerQuest {
  const AssemblerQuest({
    required this.questInfo,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  final QuestInfo questInfo;
  final DateTime startTime;
  final DateTime endTime;
  final QuestStatus status;

  static Color getStatusColor(QuestStatus status) {
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
      _ =>
        '${stringifyTimeOfDate(startTime)} -\n${stringifyTimeOfDate(endTime)}',
    };
  }

  int get durationInMinutes => endTime.difference(startTime).inMinutes;
  Color get statusColor => getStatusColor(status);
  String get durationText => stringifyDuration(durationInMinutes);
  String get timeText =>
      '${stringifyTimeOfDate(startTime)} -\n${stringifyTimeOfDate(endTime)}';
}
