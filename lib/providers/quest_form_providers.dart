import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/providers/main_quest_providers.dart';
import 'package:questlog/providers/side_quest_providers.dart';

final questFormNotifierProvider = NotifierProvider<QuestFormNotifier, void>(
  () => QuestFormNotifier(),
);

class QuestFormNotifier extends Notifier<void> {
  @override
  void build() {}

  void submitMainQuest(MainQuest mainQuest) {
    MainQuestService.add(mainQuest);
  }

  void submitSideQuest(SideQuest sideQuest) {
    SideQuestService.add(sideQuest);
  }
}
