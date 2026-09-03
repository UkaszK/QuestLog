import 'package:isar/isar.dart';

part 'assembler_side_quest.g.dart';

// Concrete daily occurrence of a SideQuest; not a template.
@collection
class AssemblerSideQuest implements Comparable<AssemblerSideQuest> {
  AssemblerSideQuest({
    required this.sideQuestId,
    required this.name,
    required this.questCategoryName,
    required this.occurrenceDate,
    this.completedAt,
  });

  Id id = Isar.autoIncrement;

  final int sideQuestId;
  final String name;
  final String questCategoryName;
  final DateTime occurrenceDate;
  final DateTime? completedAt;

  bool get completed => completedAt != null;

  @override
  int compareTo(AssemblerSideQuest other) {
    return occurrenceDate.compareTo(other.occurrenceDate);
  }
}
