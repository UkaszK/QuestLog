import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:questlog/data/assembler_quest.dart';
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
    ], directory: dir.path);
  }

  // MainQuest
  static List<MainQuest> getAllMainQuests() =>
      instance.mainQuests.where().findAllSync();

  static Stream<List<MainQuest>> watchAllMainQuests() =>
      instance.mainQuests.where().watch(fireImmediately: true);

  static void addMainQuest(MainQuest mainQuest) {
    instance.writeTxnSync(() => instance.mainQuests.putSync(mainQuest));
  }

  static void deleteMainQuest(MainQuest mainQuest) {
    instance.writeTxnSync(() => instance.mainQuests.deleteSync(mainQuest.id));
  }

  // SideQuest
  static List<SideQuest> getAllSideQuests() =>
      instance.sideQuests.where().findAllSync();

  static Stream<List<SideQuest>> watchAllSideQuests() =>
      instance.sideQuests.where().watch(fireImmediately: true);

  static void addSideQuest(SideQuest sideQuest) {
    instance.writeTxnSync(() => instance.sideQuests.putSync(sideQuest));
  }

  static void deleteSideQuest(SideQuest sideQuest) {
    instance.writeTxnSync(() => instance.sideQuests.deleteSync(sideQuest.id));
  }

  // AssemblerMainQuest
  static List<AssemblerMainQuest> getAllAssemblerQuests() =>
      instance.assemblerMainQuests.where().findAllSync();

  static Stream<List<AssemblerMainQuest>> watchAllAssemblerMainQuests() =>
      instance.assemblerMainQuests.where().watch(fireImmediately: true);

  static void addAssemblerQuest(AssemblerMainQuest assemblerQuest) {
    instance.writeTxnSync(
      () => instance.assemblerMainQuests.putSync(assemblerQuest),
    );
  }

  static void updateAssemblerQuest(int id, AssemblerMainQuest assemblerQuest) {
    assemblerQuest.id = id;
    instance.writeTxnSync(
      () => instance.assemblerMainQuests.putSync(assemblerQuest),
    );
  }

  static void deleteAssemblerQuest(AssemblerMainQuest assemblerQuest) {
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
}
