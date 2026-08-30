import 'package:questlog/utils/stringify_time_of_date.dart';

String getTimeText(
  DateTime start,
  DateTime end, [
  bool automaticLineBreak = true,
]) {
  return '${start.toHHMM()} -${automaticLineBreak ? '\n' : ' '}${end.toHHMM()}';
}
