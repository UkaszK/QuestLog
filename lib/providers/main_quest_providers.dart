import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/main_quest.dart';

final mainQuestsProvider = StreamProvider<List<MainQuest>>((ref) {
  return IsarDataStore.watchAllMainQuests();
});

class MainQuestNotifier extends Notifier<void> {
  @override
  void build() {}

  void add(MainQuest mainQuest) {
    IsarDataStore.addMainQuest(mainQuest);
  }
}

final mainQuestControllerProvider = NotifierProvider<MainQuestNotifier, void>(
  () => MainQuestNotifier(),
);
