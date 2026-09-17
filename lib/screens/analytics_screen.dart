import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:questlog/data/analytics_metrics.dart';
import 'package:questlog/providers/analytics_providers.dart';
import 'package:questlog/theme/quest_log_colors.dart';
import 'package:questlog/widgets/achievements_screen/achievements_preview.dart';
import 'package:questlog/widgets/analytics_screen/analytics_overview_tiles.dart';
import 'package:questlog/widgets/analytics_screen/category_breakdown.dart';
import 'package:questlog/widgets/analytics_screen/daily_completion_chart.dart';
import 'package:questlog/widgets/analytics_screen/habit_consistency.dart';
import 'package:questlog/widgets/analytics_screen/schedule_distribution.dart';
import 'package:questlog/widgets/analytics_screen/weekday_performance_chart.dart';
import 'package:questlog/widgets/quest_log_loading_screen.dart';
import 'package:questlog/widgets/reusables/quest_log_choice_chip_bar.dart';
import 'package:questlog/widgets/reusables/quest_log_screen_container.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(analyticsStateProvider);

    return analyticsAsync.when(
      data: (metrics) => QuestLogScreenContainer(
        spacing: 25,
        children: [
          _Header(
            range: metrics.range,
            startDate: metrics.startDate,
            endDate: metrics.endDate,
            onRangeChange: ref.read(analyticsRangeProvider.notifier).select,
          ),
          AnalyticsOverviewTiles(metrics: metrics),
          const AchievementsPreview(),
          DailyCompletionChart(metrics: metrics),
          WeekdayPerformanceChart(metrics: metrics),
          CategoryBreakdown(metrics: metrics),
          HabitConsistency(metrics: metrics),
          ScheduleDistribution(metrics: metrics),
        ],
      ),
      error: (error, stack) => Center(child: Text('Error loading: $error')),
      loading: () => const QuestLogLoadingScreen(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.range,
    required this.startDate,
    required this.endDate,
    required this.onRangeChange,
  });

  final AnalyticsRange range;
  final DateTime startDate;
  final DateTime endDate;
  final void Function(AnalyticsRange) onRangeChange;

  static final _rangeFormat = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ANALYTICS',
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_rangeFormat.format(startDate)}'
                ' - ${_rangeFormat.format(endDate)}',
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 160,
          child: QuestLogChoiceChipBar<AnalyticsRange>(
            options: AnalyticsRange.values,
            selection: range,
            onChange: onRangeChange,
            labelOf: (r) => r.label,
            style: QuestLogChoiceChipBarStyle.outlined,
          ),
        ),
      ],
    );
  }
}
