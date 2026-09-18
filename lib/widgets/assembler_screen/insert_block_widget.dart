import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/quest_log_colors.dart';
import 'package:questlog/utils/get_time_text.dart';

class InsertBlockWidget extends StatelessWidget {
  const InsertBlockWidget({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onTap,
  });

  final DateTime startTime;
  final DateTime endTime;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color color = QuestLogColors.textSecondary.withValues(alpha: 0.3);
    final borderWidth = 1.0;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: DottedBorder(
        options: RectDottedBorderOptions(
          strokeWidth: borderWidth,
          color: color,
        ),
        child: Align(
          alignment: Alignment.center,
          child: LayoutBuilder(
            builder: ((context, constraints) {
              final availableHeight = constraints.maxHeight + borderWidth * 2;

              bool isTiny = availableHeight < 30;
              bool isSmall = availableHeight < 60;

              String timeText = getTimeText(startTime, endTime, false);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: !isTiny
                    ? Text(
                        '+ INSERT BLOCK ($timeText)',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.jetBrainsMono(
                          color: color,
                          fontSize: isSmall ? 10 : 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const SizedBox.shrink(),
              );
            }),
          ),
        ),
      ),
    );
  }
}
