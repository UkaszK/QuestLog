import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/questlog_app_bar.dart';

import 'screens/log_screen.dart';
import 'screens/assembler_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/settings_screen.dart';
import 'widgets/themed_svg_icon.dart';

class QuestLogApp extends StatefulWidget {
  const QuestLogApp({super.key});

  @override
  State<QuestLogApp> createState() => _QuestLogAppState();
}

class _QuestLogAppState extends State<QuestLogApp> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    LogScreen(),
    AssemblerScreen(),
    AnalyticsScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: .dark(),
      home: Scaffold(
        appBar: QuestLogAppBar(),
        body: IndexedStack(index: _selectedIndex, children: _pages),
        bottomNavigationBar: Stack(
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
                  NavigationDestination(
                    icon: Icon(Icons.assignment),
                    label: 'LOG',
                  ),
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
                selectedIndex: _selectedIndex,
                onDestinationSelected: _onItemTapped,
                indicatorColor: Colors.transparent,
                labelTextStyle: WidgetStateProperty.resolveWith((states) {
                  final isSelected = states.contains(WidgetState.selected);
                  return GoogleFonts.jetBrainsMono(
                    color: isSelected
                        ? QuestLogColors.textPrimary
                        : QuestLogColors.textSecondary,
                    fontSize: isSelected ? 12 : 11,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
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
                        width: i == _selectedIndex ? 32.0 : 0.0,
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
        ),
      ),
    );
  }
}
