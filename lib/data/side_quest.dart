import 'package:questlog/data/quest_category.dart';
import 'package:questlog/data/day.dart';

class SideQuest {
  const SideQuest({
    required this.questCategory,
    required this.name,
    required this.repeatDays,
  });

  final QuestCategory questCategory;
  final String name;
  final Set<Day> repeatDays;

  String? timeIntervalString() {
    if (repeatDays.isEmpty) return null;

    if (repeatDays.length == 1) return 'Every ${repeatDays.first}';

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
