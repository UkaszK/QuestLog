enum Day {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

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
