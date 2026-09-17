import 'package:flutter/painting.dart';
import 'package:questlog/theme/quest_log_colors.dart';

enum QuestFilterOption {
  all,
  mainQuests,
  sideQuests,
  highPriority,
  dueToday;

  String get label {
    return switch (this) {
      QuestFilterOption.all => 'All',
      QuestFilterOption.mainQuests => 'Main Quests',
      QuestFilterOption.sideQuests => 'Side Quests',
      QuestFilterOption.highPriority => 'High Priority',
      QuestFilterOption.dueToday => 'Due Today',
    };
  }

  Color get color {
    return switch (this) {
      QuestFilterOption.all => QuestLogColors.accent,
      QuestFilterOption.mainQuests => QuestLogColors.accent,
      QuestFilterOption.sideQuests => QuestLogColors.otherAccent,
      QuestFilterOption.highPriority => QuestLogColors.warning,
      QuestFilterOption.dueToday => QuestLogColors.accent,
    };
  }
}
