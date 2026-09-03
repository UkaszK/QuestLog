import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/themed_svg_icon.dart';

class QuestLogNavigationBar extends StatefulWidget {
  const QuestLogNavigationBar({
    super.key,
    required this.onDestinationSelected,
    required this.selectedIndex,
  });

  final void Function(int) onDestinationSelected;
  final int selectedIndex;

  @override
  State<StatefulWidget> createState() => _QuestLogNavigationBarState();
}

class _QuestLogNavigationBarState extends State<QuestLogNavigationBar> {
  Widget _buildNavItem({
    required Widget icon,
    required String label,
    required int index,
  }) {
    final isSelected = widget.selectedIndex == index;
    final color = isSelected
        ? QuestLogColors.textPrimary
        : QuestLogColors.textSecondary;

    return InkWell(
      onTap: () => widget.onDestinationSelected(index),
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconTheme(
              data: IconThemeData(color: color, size: 22),
              child: icon,
            ),

            SizedBox(height: 6),

            Text(
              label,
              style: GoogleFonts.jetBrainsMono(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
              maxLines: 1,
              overflow: TextOverflow.visible,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),

        // Drop Shadow Container
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),

          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),

            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: QuestLogColors.surface.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: QuestLogColors.border, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    icon: Icon(Icons.dashboard),
                    label: 'DASHBOARD',
                    index: 0,
                  ),
                  _buildNavItem(
                    icon: ThemedSvgIcon('assets/icons/assembler.svg'),
                    label: 'ASSEMBLER',
                    index: 1,
                  ),

                  SizedBox(width: 50),

                  _buildNavItem(
                    icon: ThemedSvgIcon('assets/icons/analytics.svg'),
                    label: 'ANALYTICS',
                    index: 2,
                  ),
                  _buildNavItem(
                    icon: Icon(Icons.assignment),
                    label: 'BACKLOG',
                    index: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
