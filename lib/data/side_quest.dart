import 'package:isar/isar.dart';
import 'package:questlog/data/quest_categories.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/data/day.dart';

part 'side_quest.g.dart';

// Recurring template a habit is defined from; each day creates an AssemblerSideQuest.
@collection
class SideQuest {
  SideQuest({
    required this.questCategoryName,
    required this.name,
    required this.repeatDaysList,
    this.archived = false,
  });

  SideQuest copyWith({
    String? questCategoryName,
    String? name,
    List<Day>? repeatDaysList,
    bool? archived,
  }) {
    return SideQuest(
      questCategoryName: questCategoryName ?? this.questCategoryName,
      name: name ?? this.name,
      repeatDaysList: repeatDaysList ?? this.repeatDaysList,
      archived: archived ?? this.archived,
    );
  }

  Id id = Isar.autoIncrement;

  final String questCategoryName;
  final String name;

  @enumerated
  final List<Day> repeatDaysList;

  final bool archived;

  @ignore
  Set<Day> get repeatDays => repeatDaysList.toSet();

  @ignore
  QuestCategory get questCategory =>
      questCategories.firstWhere((c) => c.name == questCategoryName);

  String? timeIntervalString() {
    if (repeatDays.isEmpty) return null;
    if (repeatDays.length == 1) return 'Every ${repeatDays.first.label}';
    if (repeatDays.length == 7) return 'Every day';

    const weekdays = {
      Day.monday,
      Day.tuesday,
      Day.wednesday,
      Day.thursday,
      Day.friday,
    };
    const weekends = {Day.saturday, Day.sunday};

    if (repeatDays.length == weekdays.length &&
        repeatDays.containsAll(weekdays)) {
      return 'On Weekdays';
    }

    if (repeatDays.length == weekends.length &&
        repeatDays.containsAll(weekends)) {
      return 'On Weekends';
    }

    return 'On selected Days';
  }
}
