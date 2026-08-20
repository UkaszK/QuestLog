import 'package:questlog/data/quest_category.dart';
import 'package:questlog/data/day.dart';
import 'package:questlog/utils/stringify_quest_category.dart';

class SideQuest {
  const SideQuest({
    required this.name,
    required this.questCategory,
    required this.repeatDays,
  });

  final String name;
  final QuestCategory questCategory;
  final Set<Day> repeatDays;

  String categoryString() {
    return stringifyQuestCategory(questCategory);
  }

  String? timeIntervalString() {
    if (repeatDays.isEmpty) return null;

    if (repeatDays.length == 1) return 'Every ${repeatDays.first}';

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
