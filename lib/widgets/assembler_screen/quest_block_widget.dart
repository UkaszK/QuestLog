import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/assembler_main_quest.dart';
import 'package:questlog/theme/quest_log_colors.dart';

class QuestBlockWidget extends StatelessWidget {
  const QuestBlockWidget({super.key, required this.quest, required this.onTap});

  final AssemblerMainQuest quest;
  final VoidCallback onTap;

  bool get _hasDescription => quest.subTasks.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    String title = quest.name;
    Color statusColor = quest.status.color;

    final borderWidth = 1.0;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: quest.status.color, width: borderWidth),
        ),
        child: LayoutBuilder(
          builder: ((context, constraints) {
            final availableHeight = constraints.maxHeight + borderWidth * 2;

            final isTiny = availableHeight < 30;
            if (isTiny) return const SizedBox.expand();

            final isSmall = availableHeight < 60;
            final isLarge = availableHeight >= 82;

            final timeText = isSmall ? quest.timeTextOneLine : quest.timeText;

            return Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 10,
                vertical: isSmall ? 0 : 10,
              ),
              child: Column(
                mainAxisAlignment: isSmall
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(isSmall, title, statusColor, timeText),
                  if (isLarge && _hasDescription)
                    _buildDescription(quest.subTasksListed),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildHeader(
    bool isSmall,
    String title,
    Color color,
    String timeText,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: isSmall
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.jetBrainsMono(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),

        Flexible(
          child: Text(
            timeText,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: GoogleFonts.jetBrainsMono(
              color: QuestLogColors.textPrimary,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(String description) {
    return Column(
      children: [
        const SizedBox(height: 4),
        Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.jetBrainsMono(
            color: QuestLogColors.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
