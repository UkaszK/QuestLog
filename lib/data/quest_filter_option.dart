import 'package:flutter/painting.dart';
import 'package:questlog/theme/quest_log_colors.dart';

enum QuestFilterOption {
  all(label: 'All', color: QuestLogColors.accent),
  mainQuests(label: 'Main Quests', color: QuestLogColors.accent),
  sideQuests(label: 'Side Quests', color: QuestLogColors.otherAccent),
  highPriority(label: 'High Priority', color: QuestLogColors.warning),
  dueToday(label: 'Due Today', color: QuestLogColors.accent);

  const QuestFilterOption({required this.label, required this.color});

  final String label;
  final Color color;
}
