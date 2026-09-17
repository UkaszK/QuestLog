import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/daily_progress_metrics.dart';
import 'package:questlog/theme/quest_log_colors.dart';

class DashboardDailyProgress extends StatelessWidget {
  const DashboardDailyProgress({super.key, required this.progress});

  final DailyProgressMetrics progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: QuestLogColors.border, width: 1),
        color: QuestLogColors.surface,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'DAILY OBJECTIVES PROGRESS',
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                '${progress.progressPercent}%',
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.accent,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          LinearProgressIndicator(
            value: progress.progress,
            valueColor: const AlwaysStoppedAnimation<Color>(
              QuestLogColors.accent,
            ),
            backgroundColor: QuestLogColors.border,
            minHeight: 5,
            borderRadius: BorderRadiusGeometry.all(Radius.circular(5)),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${progress.tasksDone} OF ${progress.tasksPlanned} PLANNED OBJECTIVES COMPLETED',
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
