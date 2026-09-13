import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/reusables/quest_log_choice_chip_bar.dart';

class FormCategorySelector extends StatelessWidget {
  const FormCategorySelector({
    super.key,
    required this.questCategories,
    required this.selection,
    required this.onChange,
    this.primaryColor = QuestLogColors.accent,
  });

  final List<QuestCategory> questCategories;
  final QuestCategory selection;
  final void Function(QuestCategory) onChange;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUEST CATEGORY',
          style: GoogleFonts.jetBrainsMono(
            color: QuestLogColors.textSecondary,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 8),

        QuestLogChoiceChipBar<QuestCategory>(
          options: questCategories
              .map(
                (category) => QuestLogChoiceChipBarOption(
                  label: category.name,
                  value: category,
                  prefixIcon: category.icon,
                  primaryColor: primaryColor,
                ),
              )
              .toList(),
          selection: selection,
          onChange: onChange,
          style: .outlined,
        ),
      ],
    );
  }
}
