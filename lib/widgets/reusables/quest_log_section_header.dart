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
    this.dividerOptions = (dividerDistance: 8),
  });

  final String title;
  final IconData? icon;
  final Color? iconColor;
  final Widget? rightSide;
  final ({double? dividerDistance})? dividerOptions;

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

        if (dividerOptions != null) ...[
          SizedBox(height: dividerOptions!.dividerDistance),

          Divider(height: 1),
        ],
      ],
    );
  }
}
