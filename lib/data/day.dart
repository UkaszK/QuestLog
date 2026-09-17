enum Day {
  monday(label: 'Monday'),
  tuesday(label: 'Tuesday'),
  wednesday(label: 'Wednesday'),
  thursday(label: 'Thursday'),
  friday(label: 'Friday'),
  saturday(label: 'Saturday'),
  sunday(label: 'Sunday');

  const Day({required this.label});

  final String label;

  static Day fromDateTime(DateTime date) => Day.values[date.weekday - 1];
}
