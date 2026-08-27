import 'package:questlog/data/quest_priority.dart';
import 'package:questlog/data/quest_category.dart';

class MainQuest {
  const MainQuest({
    required this.questCategory,
    required this.name,
    required this.durationMin,
    required this.priority,
    required this.subTasks,
    required this.dueDate,
  });

  final QuestCategory questCategory;
  final String name;
  final int durationMin;
  final QuestPriority priority;
  final List<String> subTasks;
  final DateTime dueDate;
}
