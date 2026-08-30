import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:questlog/data/quest_info.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/utils/get_time_text.dart';
import 'package:questlog/utils/stringify_time_of_date.dart';

part 'assembler_quest.g.dart';

enum QuestStatus { open, completed, active, pending }

@collection
class AssemblerQuest {
  AssemblerQuest({
    required this.questInfo,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  Id id = Isar.autoIncrement;

  final QuestInfo questInfo;
  final DateTime startTime;
  final DateTime endTime;

  @enumerated
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
      _ => '${startTime.toHHMM()} -\n${endTime.toHHMM()}',
    };
  }

  @ignore // ANPASSUNG
  int get durationInMinutes => endTime.difference(startTime).inMinutes;

  @ignore // ANPASSUNG
  Color get statusColor => getStatusColor(status);

  @ignore // ANPASSUNG
  String get timeText => getTimeText(startTime, endTime);
}
