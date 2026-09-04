import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';

class DashboardDailyProgress extends StatelessWidget {
  const DashboardDailyProgress({
    super.key,
    required this.tasksDone,
    required this.tasksPlanned,
  });

  final int tasksDone;
  final int tasksPlanned;

  double get _progress =>
      tasksPlanned == 0 ? 0.0 : (tasksDone / tasksPlanned).clamp(0.0, 1.0);

  int get _progressPercent => tasksPlanned == 0
      ? 0
      : ((tasksDone / tasksPlanned) * 100).round().clamp(0, 100);

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
                '$_progressPercent%',
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
            value: _progress,
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
                '$tasksDone OF $tasksPlanned PLANNED OBJECTIVES COMPLETED',
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
