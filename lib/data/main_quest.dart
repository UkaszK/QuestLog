import 'package:questlog/data/quest_priority.dart';
import 'package:questlog/data/quest_category.dart';

class MainQuest {
  const MainQuest({
    required this.name,
    required this.questCategory,
    required this.durationMin,
    required this.subTasks,
    required this.dueDate,
    required this.priority,
  });

  final String name;
  final QuestCategory questCategory;
  final int durationMin;
  final List<({String name, bool completed})> subTasks;
  final DateTime dueDate;
  final QuestPriority priority;
}
