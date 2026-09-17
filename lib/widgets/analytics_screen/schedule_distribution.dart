import 'package:flutter/material.dart';
import 'package:questlog/data/analytics_metrics.dart';
import 'package:questlog/theme/quest_log_colors.dart';
import 'package:questlog/widgets/analytics_screen/analytics_shared.dart';

class ScheduleDistribution extends StatelessWidget {
  const ScheduleDistribution({super.key, required this.metrics});

  final AnalyticsMetrics metrics;

  IconData _iconFor(DayWindow window) {
    return switch (window) {
      DayWindow.morning => Icons.wb_twilight,
      DayWindow.afternoon => Icons.wb_sunny_outlined,
      DayWindow.evening => Icons.nights_stay_outlined,
      DayWindow.night => Icons.bedtime_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    final windows = metrics.windows;
    final totalPlanned = windows.fold(0, (sum, w) => sum + w.planned);

    return AnalyticsSection(
      title: 'SCHEDULE DISTRIBUTION',
      icon: Icons.schedule,
      isEmpty: totalPlanned == 0,
      emptyLabel: 'NO MAIN QUESTS SCHEDULED IN RANGE',
      rightSide: Text('MAIN QUESTS BY TIME', style: analyticsCaptionStyle()),
      child: Column(
        spacing: 14,
        children: [
          for (final window in windows)
            AnalyticsBarRow(
              leading: Icon(
                _iconFor(window.window),
                size: 16,
                color: QuestLogColors.textSecondary,
              ),
              label: '${window.window.label}  ${window.window.hint}',
              value: totalPlanned == 0 ? 0 : window.planned / totalPlanned,
              color: window.planned == 0
                  ? QuestLogColors.border
                  : analyticsRateColor(window.rate),
              trailing: window.planned == 0
                  ? '-'
                  : '${window.ratePercent}% DONE',
              subLabel:
                  '${window.planned} SCHEDULED  ·  '
                  '${totalPlanned == 0 ? 0 : (window.planned / totalPlanned * 100).round()}% OF ALL',
            ),
        ],
      ),
    );
  }
}
