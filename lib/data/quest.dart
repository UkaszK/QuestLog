import 'package:flutter/material.dart';

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
      QuestStatus.open => Colors.white38,
      QuestStatus.completed => Colors.greenAccent,
      QuestStatus.active => Colors.cyanAccent,
      QuestStatus.pending => Colors.red,
    };
  }
}
