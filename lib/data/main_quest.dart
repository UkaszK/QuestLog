import 'package:flutter/material.dart';
import 'package:questlog/data/quest_priority.dart';
import 'package:questlog/data/quest_category.dart';

class MainQuest implements Comparable<MainQuest> {
  const MainQuest({
    required this.questCategory,
    required this.name,
    this.dueDate,
    required this.priority,
    required this.subTasks,
  });

  final QuestCategory questCategory;
  final String name;
  final DateTime? dueDate;
  final QuestPriority priority;
  final List<String> subTasks;

  @override
  int compareTo(MainQuest other) {
    if (dueDate == null && other.dueDate == null) {
      return name.compareTo(other.name);
    }
    if (dueDate == null) {
      return 1;
    }
    if (other.dueDate == null) {
      return -1;
    }

    return dueDate!.compareTo(other.dueDate!);
  }

  @override
  String toString() {
    return name;
  }

  String get dueText {
    if (dueDate == null) {
      return '-';
    }

    if (DateUtils.isSameDay(dueDate!, DateTime.now())) {
      return 'TODAY';
    }

    if (DateUtils.isSameDay(
      DateTime.now().subtract(Duration(days: 1)),
      dueDate,
    )) {
      return 'YESTERDAY';
    }

    if (DateUtils.isSameDay(DateTime.now().add(Duration(days: 1)), dueDate)) {
      return 'TOMORROW';
    }

    return '${dueDate!.day}.${dueDate!.month}.${dueDate!.year}';
  }
}
