import 'package:flutter/painting.dart';
import 'package:questlog/theme/questlog_colors.dart';

enum QuestType {
  main,
  side;

  String get label {
    return switch (this) {
      QuestType.main => 'Main Quest',
      QuestType.side => 'Side Quest',
    };
  }

  Color get color {
    return switch (this) {
      QuestType.main => QuestLogColors.accent,
      QuestType.side => QuestLogColors.otherAccent,
    };
  }
}
