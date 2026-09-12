import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/theme/questlog_colors.dart';

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

  Widget _buildCategoryBox(QuestCategory questCategory) {
    bool isSelected = selection == questCategory;
    Color color = isSelected ? primaryColor : QuestLogColors.textSecondary;

    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () => onChange(questCategory),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 1,
            color: isSelected ? primaryColor : QuestLogColors.border,
          ),
        ),
        child: Row(
          spacing: 5,
          children: [
            Icon(questCategory.icon, size: 14, color: color),

            Text(
              questCategory.name.toUpperCase(),
              style: GoogleFonts.jetBrainsMono(color: color, fontSize: 12),
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
      children: [
        Text(
          'QUEST CATEGORY',
          style: GoogleFonts.jetBrainsMono(
            color: QuestLogColors.textSecondary,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 8),

        SingleChildScrollView(
          physics: ScrollPhysics(parent: ClampingScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 10,
            children: [
              for (final questCategory in questCategories)
                _buildCategoryBox(questCategory),
            ],
          ),
        ),
      ],
    );
  }
}
