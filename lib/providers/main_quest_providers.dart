import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/main_quest.dart';

final mainQuestsProvider = StreamProvider<List<MainQuest>>((ref) {
  return IsarDataStore.watchAllMainQuests();
});

class MainQuestService {
  static void add(MainQuest mainQuest) {
    IsarDataStore.addMainQuest(mainQuest);
  }
}
