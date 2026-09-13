import 'package:flutter/material.dart';
import 'package:questlog/screens/main_home_screen.dart';
import 'package:questlog/theme/questlog_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: QuestLogColors.background,
      ),
      home: const MainHomeScreen(),
    );
  }
}
