import 'package:questlog/data/day.dart';

String dayName(Day day) {
  switch (day) {
    case Day.monday:
      return 'Monday';
    case Day.tuesday:
      return 'Tuesday';
    case Day.wednesday:
      return 'Wednesday';
    case Day.thursday:
      return 'Thursday';
    case Day.friday:
      return 'Friday';
    case Day.saturday:
      return 'Saturday';
    case Day.sunday:
      return 'Sunday';
  }
}
