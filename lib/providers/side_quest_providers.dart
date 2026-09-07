import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/data/side_quest.dart';

final sideQuestsProvider = StreamProvider<List<SideQuest>>((ref) {
  return IsarDataStore.watchAllSideQuests();
});

class SideQuestService {
  static void add(SideQuest sideQuest) {
    IsarDataStore.addSideQuest(sideQuest);
  }
}
