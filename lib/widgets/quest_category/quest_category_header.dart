import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/reusables/quest_log_badge.dart';
import 'package:questlog/widgets/reusables/quest_log_section_header.dart';

class QuestCategoryHeader extends StatelessWidget {
  const QuestCategoryHeader({
    super.key,
    required this.label,
    required this.questCount,
  });

  final String label;
  final int questCount;

  @override
  Widget build(BuildContext context) {
    return QuestLogSectionHeader(
      title: label.toUpperCase(),
      rightSide: QuestLogBadge(
        label:
            '$questCount ${Intl.plural(questCount, one: 'QUEST', other: 'QUESTS')}',
        primaryColor: QuestLogColors.textSecondary,
        backgroundColor: QuestLogColors.surface,
        borderColor: QuestLogColors.border,
      ),
      dividerStyle: (dividerDistance: 4),
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}
