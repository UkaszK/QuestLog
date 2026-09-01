extension DateTimeExtension on DateTime {
  String toHHMM() {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');

    return '$h:$m';
  }
}
