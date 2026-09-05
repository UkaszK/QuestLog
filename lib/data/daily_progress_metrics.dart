class DailyProgressMetrics {
  const DailyProgressMetrics({
    required this.tasksDone,
    required this.tasksPlanned,
  });

  final int tasksDone;
  final int tasksPlanned;

  double get progress =>
      tasksPlanned == 0 ? 0.0 : (tasksDone / tasksPlanned).clamp(0.0, 1.0);

  int get progressPercent => tasksPlanned == 0
      ? 0
      : ((tasksDone / tasksPlanned) * 100).round().clamp(0, 100);
}
