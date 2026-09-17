import 'package:flutter/material.dart';
import 'package:questlog/widgets/quest_log_app_bar.dart';
import 'package:questlog/widgets/reusables/quest_log_screen_container.dart';

class QuestLogNewScreenContainer extends StatelessWidget {
  const QuestLogNewScreenContainer({
    super.key,
    required this.children,
    this.spacing = 0.0,
  });

  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuestLogAppBar(),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: QuestLogScreenContainer(spacing: spacing, children: children),
      ),
    );
  }
}
