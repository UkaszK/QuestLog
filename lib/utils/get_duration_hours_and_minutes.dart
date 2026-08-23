(int hours, int minutes) getDurationHoursAndMinutes(int durationMin) {
  final int hours = durationMin ~/ 60;
  final int minutes = durationMin % 60;

  return (hours, minutes);
}
