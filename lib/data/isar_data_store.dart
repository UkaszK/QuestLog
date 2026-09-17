import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:questlog/data/achievement_unlock.dart';
import 'package:questlog/data/assembler_main_quest.dart';
import 'package:questlog/data/assembler_side_quest.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/side_quest.dart';

class IsarDataStore {
  IsarDataStore._();

  static late final Isar instance;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    instance = await Isar.open([
      MainQuestSchema,
      SideQuestSchema,
      AssemblerMainQuestSchema,
      AssemblerSideQuestSchema,
      AchievementUnlockSchema,
    ], directory: dir.path);
  }

  // MainQuest
  static List<MainQuest> getAllMainQuestsIncludingArchived() =>
      instance.mainQuests.where().findAllSync();

  static Stream<List<MainQuest>> watchAllMainQuests() => instance.mainQuests
      .filter()
      .archivedEqualTo(false)
      .watch(fireImmediately: true);

  static void addMainQuest(MainQuest mainQuest) {
    instance.writeTxnSync(() => instance.mainQuests.putSync(mainQuest));
  }

  static void archiveMainQuest(MainQuest mainQuest) {
    final archivedMainQuest = mainQuest.copyWith(archived: true)
      ..id = mainQuest.id;
    instance.writeTxnSync(() => instance.mainQuests.putSync(archivedMainQuest));
  }

  static void updateMainQuest(int id, MainQuest mainQuest) {
    mainQuest.id = id;
    instance.writeTxnSync(() => instance.mainQuests.putSync(mainQuest));
  }

  // SideQuest
  static List<SideQuest> getAllSideQuestsIncludingArchived() =>
      instance.sideQuests.where().findAllSync();

  static Stream<List<SideQuest>> watchAllSideQuests() => instance.sideQuests
      .filter()
      .archivedEqualTo(false)
      .watch(fireImmediately: true);

  static void addSideQuest(SideQuest sideQuest) {
    instance.writeTxnSync(() => instance.sideQuests.putSync(sideQuest));
  }

  static void archiveSideQuest(SideQuest sideQuest) {
    final archivedSideQuest = sideQuest.copyWith(archived: true)
      ..id = sideQuest.id;
    instance.writeTxnSync(() => instance.sideQuests.putSync(archivedSideQuest));
  }

  static void updateSideQuest(int id, SideQuest sideQuest) {
    sideQuest.id = id;
    instance.writeTxnSync(() => instance.sideQuests.putSync(sideQuest));
  }

  // AssemblerMainQuest
  static List<AssemblerMainQuest> getAllAssemblerQuests() =>
      instance.assemblerMainQuests.where().findAllSync();

  static Stream<List<AssemblerMainQuest>> watchAllAssemblerMainQuests() =>
      instance.assemblerMainQuests.where().watch(fireImmediately: true);

  static void addAssemblerMainQuest(AssemblerMainQuest assemblerQuest) {
    instance.writeTxnSync(
      () => instance.assemblerMainQuests.putSync(assemblerQuest),
    );
  }

  static void updateAssemblerMainQuest(
    int id,
    AssemblerMainQuest assemblerQuest,
  ) {
    assemblerQuest.id = id;
    instance.writeTxnSync(
      () => instance.assemblerMainQuests.putSync(assemblerQuest),
    );
  }

  static void deleteAssemblerMainQuest(AssemblerMainQuest assemblerQuest) {
    instance.writeTxnSync(
      () => instance.assemblerMainQuests.deleteSync(assemblerQuest.id),
    );
  }

  // AssemblerSideQuest
  static List<AssemblerSideQuest> getAllAssemblerSideQuests() =>
      instance.assemblerSideQuests.where().findAllSync();

  static Stream<List<AssemblerSideQuest>> watchAllAssemblerSideQuests() =>
      instance.assemblerSideQuests.where().watch(fireImmediately: true);

  static void addAssemblerSideQuest(AssemblerSideQuest assemblerSideQuest) {
    instance.writeTxnSync(
      () => instance.assemblerSideQuests.putSync(assemblerSideQuest),
    );
  }

  static void updateAssemblerSideQuest(
    int id,
    AssemblerSideQuest assemblerSideQuest,
  ) {
    assemblerSideQuest.id = id;
    instance.writeTxnSync(
      () => instance.assemblerSideQuests.putSync(assemblerSideQuest),
    );
  }

  static void deleteAssemblerSideQuest(AssemblerSideQuest assemblerSideQuest) {
    instance.writeTxnSync(
      () => instance.assemblerSideQuests.deleteSync(assemblerSideQuest.id),
    );
  }

  // AchievementUnlock
  static Set<String> getAnnouncedAchievementKeys() => instance
      .achievementUnlocks
      .where()
      .findAllSync()
      .map((unlock) => unlock.key)
      .toSet();

  static void addAchievementUnlocks(Iterable<String> keys) {
    final now = DateTime.now();
    final unlocks = keys
        .map((key) => AchievementUnlock(key: key, unlockedAt: now))
        .toList();
    if (unlocks.isEmpty) return;

    instance.writeTxnSync(() => instance.achievementUnlocks.putAllSync(unlocks));
  }
}
