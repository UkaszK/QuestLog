import 'package:flutter/material.dart';
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
        appBar: QuestLogAppBar(),
        body: IndexedStack(index: _selectedIndex, children: _pages),
        bottomNavigationBar: QuestLogNavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
        ),
      ),
    );
  }
}
