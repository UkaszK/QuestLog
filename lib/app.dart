import 'package:flutter/material.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/questlog_app_bar.dart';
import 'package:questlog/widgets/questlog_navigation_bar.dart';

import 'screens/log_screen.dart';
import 'screens/assembler_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/settings_screen.dart';

class QuestLogApp extends StatefulWidget {
  const QuestLogApp({super.key});

  @override
  State<QuestLogApp> createState() => _QuestLogAppState();
}

class _QuestLogAppState extends State<QuestLogApp> {
  int _selectedIndex = 1;

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
        extendBody: true,
        appBar: QuestLogAppBar(),
        body: IndexedStack(index: _selectedIndex, children: _pages),
        bottomNavigationBar: QuestLogNavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: QuestLogColors.accent.withValues(alpha: 0.4),
                blurRadius: 3,
                spreadRadius: 1,
              ),
            ],
          ),
          child: FloatingActionButton(
            heroTag: 'main_center_fab',
            onPressed: () {},
            backgroundColor: QuestLogColors.accent,
            shape: CircleBorder(
              side: BorderSide(
                color: QuestLogColors.black.withValues(alpha: 0.8),
                width: 3,
              ),
            ),
            elevation: 2,
            child: Icon(Icons.add, color: QuestLogColors.black, size: 32),
          ),
        ),
      ),
    );
  }
}
