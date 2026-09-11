import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/quest_categories.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/providers/main_quest_providers.dart';
import 'package:questlog/providers/side_quest_providers.dart';

typedef BacklogState = ({
  Map<QuestCategory, (List<MainQuest>, List<SideQuest>)> questsByCategory,
});

final backlogStateProvider = Provider<AsyncValue<BacklogState>>((ref) {
  final mainQuestsAsync = ref.watch(mainQuestsProvider);
  final sideQuestsAsync = ref.watch(sideQuestsProvider);

  if (mainQuestsAsync.isLoading || sideQuestsAsync.isLoading) {
    return AsyncLoading();
  }

  if (mainQuestsAsync.hasError) {
    return AsyncError(mainQuestsAsync.error!, mainQuestsAsync.stackTrace!);
  }
  if (sideQuestsAsync.hasError) {
    return AsyncError(sideQuestsAsync.error!, sideQuestsAsync.stackTrace!);
  }

  final mainQuests = mainQuestsAsync.requireValue;
  final sideQuests = sideQuestsAsync.requireValue;

  final questsByCategory = <QuestCategory, (List<MainQuest>, List<SideQuest>)>{
    for (final category in questCategories)
      category: (
        mainQuests
            .where((quest) => quest.questCategoryName == category.name)
            .toList(),
        sideQuests
            .where((quest) => quest.questCategoryName == category.name)
            .toList(),
      ),
  }..removeWhere((_, quests) => quests.$1.isEmpty && quests.$2.isEmpty);

  return AsyncValue.data((questsByCategory: questsByCategory));
});

final backlogControllerProvider = NotifierProvider<BacklogController, void>(
  () => BacklogController(),
);

class BacklogController extends Notifier<void> {
  @override
  void build() {}

  void archiveMainQuest(MainQuest mainQuest) {
    IsarDataStore.archiveMainQuest(mainQuest);
  }

  void updateMainQuest(MainQuest mainQuest) {
    IsarDataStore.updateMainQuest(mainQuest.id, mainQuest);
  }

  void archiveSideQuest(SideQuest sideQuest) {
    IsarDataStore.archiveSideQuest(sideQuest);
  }

  void updateSideQuest(SideQuest sideQuest) {
    IsarDataStore.updateSideQuest(sideQuest.id, sideQuest);
  }
}
