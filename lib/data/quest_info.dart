import 'package:questlog/data/quest_category.dart';
import 'package:questlog/data/sub_task.dart';

class QuestInfo {
  QuestInfo({
    required this.name,
    required this.questCategory,
    required this.subTasks,
  });

  final String name;
  final QuestCategory questCategory;
  final List<SubTask> subTasks;
}
