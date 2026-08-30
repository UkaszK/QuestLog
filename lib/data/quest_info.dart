import 'package:isar/isar.dart';
import 'package:questlog/data/quest_categories.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/data/sub_task.dart';

part 'quest_info.g.dart';

@embedded
class QuestInfo {
  QuestInfo({
    this.name = '',
    this.questCategoryName = '',
    this.subTasks = const [],
  });

  final String name;
  final String questCategoryName;
  final List<SubTask> subTasks;

  @ignore
  QuestCategory get questCategory =>
      questCategories.firstWhere((c) => c.name == questCategoryName);
}
