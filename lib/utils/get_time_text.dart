import 'package:questlog/utils/DateTime/to_hhmm.dart';

String getTimeText(
  DateTime start,
  DateTime end, [
  bool automaticLineBreak = true,
]) {
  return '${start.toHHMM()} -${automaticLineBreak ? '\n' : ' '}${end.toHHMM()}';
}
