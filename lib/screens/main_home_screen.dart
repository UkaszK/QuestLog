import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/providers/navigation_bar_providers.dart';
import 'package:questlog/screens/quest_form_screen.dart';
import 'package:questlog/screens/analytics_screen.dart';
import 'package:questlog/screens/assembler_screen.dart';
import 'package:questlog/screens/backlog_screen.dart';
import 'package:questlog/screens/dashboard_screen.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/achievements_screen/achievement_unlock_listener.dart';
import 'package:questlog/widgets/questlog_app_bar.dart';
import 'package:questlog/widgets/questlog_navigation_bar.dart';

class MainHomeScreen extends ConsumerWidget {
  const MainHomeScreen({super.key});

  static const List<Widget> _pages = [
    DashboardScreen(),
    AssemblerScreen(),
    AnalyticsScreen(),
    BacklogScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);
    final notifier = ref.read(navigationProvider.notifier);

    return Scaffold(
      extendBody: true,
      appBar: QuestLogAppBar(),
      body: AchievementUnlockListener(
        child: IndexedStack(index: currentIndex, children: _pages),
      ),
      bottomNavigationBar: QuestLogNavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: notifier.setIndex,
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
                MaterialPageRoute(builder: (context) => QuestFormScreen()),
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
