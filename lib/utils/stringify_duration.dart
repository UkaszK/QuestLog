import 'package:questlog/utils/get_duration_hours_and_minutes.dart';

String stringifyDuration(int durationMin) {
  final (hours, minutes) = getDurationHoursAndMinutes(durationMin);

  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}
