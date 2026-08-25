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
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NavigationBarTheme(
          data: NavigationBarThemeData(
            iconTheme: WidgetStateProperty.resolveWith((state) {
              return IconThemeData(
                color: state.contains(WidgetState.selected)
                    ? const Color(0xFFe6fcfe)
                    : const Color(0xFF879495),
              );
            }),
          ),
          child: NavigationBar(
            destinations: [
              NavigationDestination(icon: Icon(Icons.assignment), label: 'LOG'),
              NavigationDestination(
                icon: ThemedSvgIcon('assets/icons/assembler.svg'),
                label: 'ASSEMBLER',
              ),
              NavigationDestination(
                icon: ThemedSvgIcon('assets/icons/analytics.svg'),
                label: 'ANALYTICS',
              ),
              NavigationDestination(
                icon: ThemedSvgIcon('assets/icons/settings.svg'),
                label: 'SETTINGS',
              ),
            ],
            selectedIndex: widget.selectedIndex,
            onDestinationSelected: widget.onDestinationSelected,
            indicatorColor: Colors.transparent,
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              final isSelected = states.contains(WidgetState.selected);
              return GoogleFonts.jetBrainsMono(
                color: isSelected
                    ? QuestLogColors.textPrimary
                    : QuestLogColors.textSecondary,
                fontSize: isSelected ? 12 : 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              );
            }),
            backgroundColor: QuestLogColors.background,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: MediaQuery.of(context).padding.bottom + 4,
          child: Row(
            children: List.generate(
              4,
              (i) => Expanded(
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    height: 2,
                    width: i == widget.selectedIndex ? 32.0 : 0.0,
                    decoration: BoxDecoration(
                      color: QuestLogColors.textPrimary,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
