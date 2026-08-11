import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      title: 'QuestLog',
      home: Scaffold(
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: Stack(
          children: [
            BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment),
                  label: 'LOG',
                ),
                BottomNavigationBarItem(
                  icon: ThemedSvgIcon('assets/icons/assembler.svg'),
                  label: 'ASSEMBLER',
                ),
                BottomNavigationBarItem(
                  icon: ThemedSvgIcon('assets/icons/analytics.svg'),
                  label: 'ANALYTICS',
                ),
                BottomNavigationBarItem(
                  icon: ThemedSvgIcon('assets/icons/settings.svg'),
                  label: 'SETTINGS',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color(0xFFe6fcfe),
              unselectedItemColor: const Color(0xFF879495),
              selectedLabelStyle: GoogleFonts.jetBrainsMono(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.jetBrainsMono(
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
              backgroundColor: const Color(0xFF131718),
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
                          color: const Color(0xFFe6fcfe),
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
