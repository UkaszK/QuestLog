enum Day {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  static Day fromDateTime(DateTime date) => Day.values[date.weekday - 1];

  String get label {
    return switch (this) {
      Day.monday => 'Monday',
      Day.tuesday => 'Tuesday',
      Day.wednesday => 'Wednesday',
      Day.thursday => 'Thursday',
      Day.friday => 'Friday',
      Day.saturday => 'Saturday',
      Day.sunday => 'Sunday',
    };
  }
}
