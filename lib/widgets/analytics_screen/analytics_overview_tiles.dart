import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/analytics_metrics.dart';
import 'package:questlog/theme/quest_log_colors.dart';
import 'package:questlog/utils/get_duration_hours_and_minutes.dart';
import 'package:questlog/widgets/analytics_screen/analytics_shared.dart';

class AnalyticsOverviewTiles extends StatelessWidget {
  const AnalyticsOverviewTiles({super.key, required this.metrics});

  final AnalyticsMetrics metrics;

  String _focusTimeText() {
    final (hours, minutes) = getDurationHoursAndMinutes(metrics.focusMinutes);
    if (hours == 0) return '${minutes}m';
    return '${hours}h ${minutes.toString().padLeft(2, '0')}m';
  }

  @override
  Widget build(BuildContext context) {
    final rateColor = metrics.hasData
        ? analyticsRateColor(metrics.completionRate)
        : QuestLogColors.textSecondary;

    return Column(
      spacing: 12,
      children: [
        Row(
          spacing: 12,
          children: [
            Expanded(
              child: _StatTile(
                icon: Icons.track_changes,
                label: 'COMPLETION RATE',
                value: metrics.hasData ? '${metrics.completionPercent}%' : '-',
                valueColor: rateColor,
                subtitle: '${metrics.objectivesDone} / ${metrics.objectivesPlanned} PLANNED',
              ),
            ),
            Expanded(
              child: _StatTile(
                icon: Icons.check_circle_outline,
                label: 'OBJECTIVES DONE',
                value: '${metrics.objectivesDone}',
                subtitle: 'LAST ${metrics.range.days} DAYS',
              ),
            ),
          ],
        ),
        Row(
          spacing: 12,
          children: [
            Expanded(
              child: _StatTile(
                icon: Icons.timer_outlined,
                label: 'FOCUS TIME',
                value: _focusTimeText(),
                subtitle: 'COMPLETED MAIN QUESTS',
              ),
            ),
            Expanded(
              child: _StatTile(
                icon: Icons.local_fire_department_outlined,
                label: 'STREAK',
                value: '${metrics.currentStreak}D',
                valueColor: metrics.currentStreak > 0
                    ? QuestLogColors.otherAccent
                    : QuestLogColors.textSecondary,
                subtitle: 'BEST ${metrics.bestStreak}D',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.subtitle,
    this.valueColor = QuestLogColors.accent,
  });

  final IconData icon;
  final String label;
  final String value;
  final String subtitle;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return AnalyticsCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: QuestLogColors.textSecondary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: analyticsCaptionStyle(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: GoogleFonts.jetBrainsMono(
              color: valueColor,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.jetBrainsMono(
              color: QuestLogColors.textSecondary,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
