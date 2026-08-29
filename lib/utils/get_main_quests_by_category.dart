import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/quest_category.dart';

typedef MainQuestsByCategory = Map<QuestCategory, List<MainQuest>>;

MainQuestsByCategory getMainQuestsByCategory(
  List<QuestCategory> questCategories,
  List<MainQuest> mainQuests,
) {
  MainQuestsByCategory collection = {};

  for (final mainQuest in mainQuests) {
    if (!collection.containsKey(mainQuest.questCategory)) {
      collection[mainQuest.questCategory] = [mainQuest];
      continue;
    }

    collection[mainQuest.questCategory]!.add(mainQuest);
  }

  return collection;
}
