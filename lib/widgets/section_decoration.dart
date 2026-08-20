import 'package:flutter/material.dart';
import 'package:questlog/theme/questlog_colors.dart';

class SectionDecoration extends BoxDecoration {
  SectionDecoration()
    : super(
        border: Border.all(color: QuestLogColors.border, width: 1),
        borderRadius: BorderRadius.circular(2),
        color: QuestLogColors.surface,
      );
}
