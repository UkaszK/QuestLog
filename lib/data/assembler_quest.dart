import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:questlog/data/quest_info.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/utils/get_time_text.dart';

part 'assembler_quest.g.dart';

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
}

@collection
class AssemblerQuest {
  AssemblerQuest({
    required this.questInfo,
    required this.startTime,
    required this.endTime,
    this.completed = false,
  });

  Id id = Isar.autoIncrement;

  final QuestInfo questInfo;
  final DateTime startTime;
  final DateTime endTime;
  final bool completed;

  @ignore
  QuestStatus get status {
    if (completed) return QuestStatus.completed;

    final now = DateTime.now();
    if (startTime.isBefore(now) && endTime.isAfter(now)) {
      return QuestStatus.active;
    }

    if (endTime.isBefore(now)) {
      return QuestStatus.pending;
    }

    if (startTime.isAfter(now)) {
      return QuestStatus.open;
    }

    return QuestStatus.completed;
  }

  @ignore
  String get timeLabel {
    return switch (status) {
      QuestStatus.completed => 'COMPLETED',
      QuestStatus.pending => 'PENDING',
      _ => getTimeText(startTime, endTime),
    };
  }

  @ignore
  int get durationInMinutes => endTime.difference(startTime).inMinutes;

  @ignore
  String get timeText => getTimeText(startTime, endTime);
}
