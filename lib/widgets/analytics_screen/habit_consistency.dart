import 'package:flutter/material.dart';
import 'package:questlog/data/analytics_metrics.dart';
import 'package:questlog/theme/quest_log_colors.dart';
import 'package:questlog/widgets/analytics_screen/analytics_shared.dart';

class HabitConsistency extends StatelessWidget {
  const HabitConsistency({super.key, required this.metrics});

  final AnalyticsMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final habits = metrics.habits;

    return AnalyticsSection(
      title: 'HABIT CONSISTENCY',
      icon: Icons.repeat,
      isEmpty: habits.isEmpty,
      emptyLabel: 'NO SIDE QUESTS SCHEDULED IN RANGE',
      rightSide: Text('WEAKEST FIRST', style: analyticsCaptionStyle()),
      child: Column(
        spacing: 14,
        children: [
          for (final habit in habits)
            AnalyticsBarRow(
              leading: Icon(
                habit.sideQuest.questCategory.icon,
                size: 16,
                color: QuestLogColors.otherAccent,
              ),
              label: habit.sideQuest.name,
              value: habit.rate,
              color: analyticsRateColor(habit.rate),
              trailing: '${habit.ratePercent}%',
              subLabel: '${habit.done} / ${habit.scheduled} DAYS',
            ),
        ],
      ),
    );
  }
}
