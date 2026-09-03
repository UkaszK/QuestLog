import 'package:flutter/material.dart';
import 'package:questlog/screens/add_quest_screen.dart';
import 'package:questlog/screens/analytics_screen.dart';
import 'package:questlog/screens/assembler_screen.dart';
import 'package:questlog/screens/backlog_screen.dart';
import 'package:questlog/screens/dashboard_screen.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/questlog_app_bar.dart';
import 'package:questlog/widgets/questlog_navigation_bar.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    DashboardScreen(),
    AssemblerScreen(),
    AnalyticsScreen(),
    BacklogScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: QuestLogAppBar(),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: QuestLogNavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Builder(
        builder: (context) => Container(
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddQuestScreen()),
              );
            },
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
