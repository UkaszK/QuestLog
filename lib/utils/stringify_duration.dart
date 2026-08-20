String stringifyDuration(int durationMin) {
  final hours = durationMin ~/ 60;
  final minutes = durationMin % 60;

  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}
