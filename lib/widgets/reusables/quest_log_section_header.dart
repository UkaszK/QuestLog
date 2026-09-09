import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';

class QuestLogSectionHeader extends StatelessWidget {
  const QuestLogSectionHeader({
    super.key,
    required this.title,
    this.icon,
    this.iconColor,
    this.rightSide,
  });

  final String title;
  final IconData? icon;
  final Color? iconColor;
  final Widget? rightSide;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 14, color: iconColor),

                  const SizedBox(width: 10),
                ],

                Text(
                  title,
                  style: GoogleFonts.jetBrainsMono(
                    color: QuestLogColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            rightSide ?? const SizedBox.shrink(),
          ],
        ),

        const SizedBox(height: 10),

        Divider(height: 1),
      ],
    );
  }
}
