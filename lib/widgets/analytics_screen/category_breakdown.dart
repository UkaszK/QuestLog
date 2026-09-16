import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:questlog/data/analytics_metrics.dart';
import 'package:questlog/data/quest_categories.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/analytics_screen/analytics_card.dart';

class CategoryBreakdown extends StatelessWidget {
  const CategoryBreakdown({super.key, required this.metrics});

  final AnalyticsMetrics metrics;

  IconData _iconFor(String categoryName) {
    return questCategories
            .firstWhereOrNull((c) => c.name == categoryName)
            ?.icon ??
        Icons.category;
  }

  @override
  Widget build(BuildContext context) {
    final categories = metrics.categories;

    return AnalyticsSection(
      title: 'CATEGORY BREAKDOWN',
      icon: Icons.pie_chart_outline,
      isEmpty: categories.isEmpty,
      rightSide: Text('SHARE OF COMPLETED', style: analyticsCaptionStyle()),
      child: Column(
        spacing: 14,
        children: [
          for (final category in categories)
            AnalyticsBarRow(
              leading: Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: QuestLogColors.border),
                  color: QuestLogColors.accentLessOpacity,
                ),
                child: Icon(
                  _iconFor(category.categoryName),
                  size: 14,
                  color: QuestLogColors.accent,
                ),
              ),
              label: category.categoryName.toUpperCase(),
              value: category.share,
              trailing: '${(category.share * 100).round()}%',
              subLabel: '${category.done} / ${category.planned} COMPLETED',
            ),
        ],
      ),
    );
  }
}
