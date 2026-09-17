import 'package:isar/isar.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/utils/DateTime/date_time_extension.dart';

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

  AssemblerSideQuest copyWith({
    int? sideQuestId,
    String? name,
    String? questCategoryName,
    DateTime? occurrenceDate,
    DateTime? completedAt,
  }) {
    return AssemblerSideQuest(
      sideQuestId: sideQuestId ?? this.sideQuestId,
      name: name ?? this.name,
      questCategoryName: questCategoryName ?? this.questCategoryName,
      occurrenceDate: occurrenceDate ?? this.occurrenceDate,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  static AssemblerSideQuest from(SideQuest sideQuest, DateTime completedAt) {
    return AssemblerSideQuest(
      sideQuestId: sideQuest.id,
      name: sideQuest.name,
      questCategoryName: sideQuest.questCategoryName,
      occurrenceDate: completedAt.dateOnly,
      completedAt: completedAt,
    );
  }

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
