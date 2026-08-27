import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/theme/questlog_text_styles.dart';

class FormCategorySelector extends StatelessWidget {
  const FormCategorySelector({
    super.key,
    required this.questCategories,
    required this.selection,
    required this.onChange,
  });

  final List<QuestCategory> questCategories;
  final QuestCategory selection;
  final void Function(QuestCategory) onChange;

  Widget buildCategoryBox(QuestCategory questCategory) {
    bool isSelected = selection == questCategory;
    Color color = isSelected
        ? QuestLogColors.accent
        : QuestLogColors.textSecondary;

    return InkWell(
      onTap: () => onChange(questCategory),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: isSelected ? QuestLogColors.accent : QuestLogColors.border,
          ),
        ),
        child: Row(
          spacing: 5,
          children: [
            Icon(questCategory.icon, size: 14, color: color),

            Text(
              questCategory.name,
              style: GoogleFonts.jetBrainsMono(color: color),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text('Quest Category', style: QuestLogTextStyles.headerText),
        SingleChildScrollView(
          physics: ScrollPhysics(parent: ClampingScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 10,
            children: [
              for (final questCategory in questCategories)
                buildCategoryBox(questCategory),
            ],
          ),
        ),
      ],
    );
  }
}
