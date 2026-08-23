import 'package:questlog/utils/stringify_time_of_date.dart';

String getTimeText(
  DateTime start,
  DateTime end, [
  bool automaticLineBreak = true,
]) {
  return '${stringifyTimeOfDate(start)} -${automaticLineBreak ? '\n' : ' '}${stringifyTimeOfDate(end)}';
}
