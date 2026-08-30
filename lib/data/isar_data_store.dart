import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:questlog/data/assembler_quest.dart';
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
      AssemblerQuestSchema,
    ], directory: dir.path);
  }

  // MainQuest
  static List<MainQuest> getAllMainQuests() =>
      instance.mainQuests.where().findAllSync();

  static void addMainQuest(MainQuest mainQuest) {
    instance.writeTxnSync(() => instance.mainQuests.putSync(mainQuest));
  }

  static void deleteMainQuest(MainQuest mainQuest) {
    instance.writeTxnSync(() => instance.mainQuests.deleteSync(mainQuest.id));
  }

  // SideQuest
  static List<SideQuest> getAllSideQuests() =>
      instance.sideQuests.where().findAllSync();

  static void addSideQuest(SideQuest sideQuest) {
    instance.writeTxnSync(() => instance.sideQuests.putSync(sideQuest));
  }

  static void deleteSideQuest(SideQuest sideQuest) {
    instance.writeTxnSync(() => instance.sideQuests.deleteSync(sideQuest.id));
  }

  // AssemblerQuest
  static List<AssemblerQuest> getAllAssemblerQuests() =>
      instance.assemblerQuests.where().findAllSync();

  static void addAssemblerQuest(AssemblerQuest assemblerQuest) {
    instance.writeTxnSync(
      () => instance.assemblerQuests.putSync(assemblerQuest),
    );
  }

  static void updateAssemblerQuest(int id, AssemblerQuest assemblerQuest) {
    assemblerQuest.id = id;
    instance.writeTxnSync(
      () => instance.assemblerQuests.putSync(assemblerQuest),
    );
  }

  static void deleteAssemblerQuest(AssemblerQuest assemblerQuest) {
    instance.writeTxnSync(
      () => instance.assemblerQuests.deleteSync(assemblerQuest.id),
    );
  }
}
