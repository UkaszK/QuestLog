import 'package:questlog/data/quest_priority.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/utils/stringify_duration.dart';

class MainQuest implements Comparable<MainQuest> {
  const MainQuest({
    required this.questCategory,
    required this.name,
    this.dueDate,
    required this.durationMin,
    required this.priority,
    required this.subTasks,
  });

  final QuestCategory questCategory;
  final String name;
  final DateTime? dueDate;
  final int durationMin;
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

  String get durationText => stringifyDuration(durationMin);

  @override
  String toString() {
    return name;
  }
}
