import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestLogBadge extends StatelessWidget {
  const QuestLogBadge({
    super.key,
    required this.label,
    required this.primaryColor,
    this.backgroundColor,
    this.borderColor,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String label;
  final Color primaryColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? primaryColor, width: 0.5),
        borderRadius: BorderRadiusGeometry.circular(2),
        color: backgroundColor ?? primaryColor.withValues(alpha: 0.15),
      ),
      child: Row(
        children: [
          if (prefixIcon != null) ...[
            Icon(prefixIcon, color: primaryColor, size: 12),
            const SizedBox(width: 5),
          ],

          Text(
            label,
            style: GoogleFonts.jetBrainsMono(
              color: primaryColor,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),

          if (suffixIcon != null) ...[
            const SizedBox(width: 5),
            Icon(suffixIcon, color: primaryColor, size: 12),
          ],
        ],
      ),
    );
  }
}
