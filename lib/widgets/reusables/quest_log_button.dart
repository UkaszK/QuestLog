import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestLogButton extends StatelessWidget {
  const QuestLogButton({
    super.key,
    required this.primaryColor,
    this.borderColor,
    this.backgroundColor,
    required this.onPress,
    this.prefixIcon,
    required this.label,
    this.fontSize = 12,
    this.suffixIcon,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.glow = false,
    this.expandHorizontally = false,
  });

  final Color primaryColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final dynamic Function() onPress;
  final IconData? prefixIcon;
  final String label;
  final double fontSize;
  final IconData? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final bool glow;
  final bool expandHorizontally;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(3);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: glow
            ? [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.3),
                  blurRadius: 5,
                  blurStyle: BlurStyle.outer,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onPress,
          borderRadius: borderRadius,
          child: Ink(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor ?? primaryColor.withValues(alpha: 0.15),
              borderRadius: borderRadius,
              border: Border.all(color: borderColor ?? primaryColor),
            ),
            child: Row(
              mainAxisSize: expandHorizontally
                  ? MainAxisSize.max
                  : MainAxisSize.min,
              mainAxisAlignment: .center,
              children: [
                if (prefixIcon != null) ...[
                  Icon(prefixIcon, color: primaryColor, size: fontSize + 2.0),
                  const SizedBox(width: 5),
                ],

                Text(
                  label,
                  style: GoogleFonts.jetBrainsMono(
                    color: primaryColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),

                if (suffixIcon != null) ...[
                  const SizedBox(width: 5),
                  Icon(suffixIcon, color: primaryColor, size: fontSize + 2.0),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
