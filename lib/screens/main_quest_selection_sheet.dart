import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/providers/quest_providers.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/backlog_screen/main_quest_block.dart';

class MainQuestSelectionSheet extends ConsumerStatefulWidget {
  const MainQuestSelectionSheet({super.key, required this.onAssemble});

  final void Function(MainQuest) onAssemble;

  @override
  ConsumerState<MainQuestSelectionSheet> createState() =>
      _MainQuestSelectionSheetState();
}

class _MainQuestSelectionSheetState
    extends ConsumerState<MainQuestSelectionSheet> {
  final Set<QuestCategory> _expandedCategories = {};
  Map<QuestCategory, List<MainQuest>> _mainQuestsByCategory = {};

  void _toggleCategory(QuestCategory questCategory) {
    setState(() {
      if (_expandedCategories.contains(questCategory)) {
        _expandedCategories.remove(questCategory);
      } else {
        _expandedCategories.add(questCategory);
      }
    });
  }

  Widget _buildHeader() {
    return Text(
      'MAIN QUEST BACKLOG',
      style: GoogleFonts.jetBrainsMono(
        color: QuestLogColors.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCategoryBlock(QuestCategory questCategory) {
    final mainQuests = _mainQuestsByCategory[questCategory]!
      ..sort(((a, b) => a.compareTo(b)));

    final isExpanded = _expandedCategories.contains(questCategory);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: QuestLogColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => _toggleCategory(questCategory),
            child: Container(
              alignment: AlignmentGeometry.centerLeft,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    QuestLogColors.accent.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
                border: Border(
                  bottom: BorderSide(width: 1, color: QuestLogColors.border),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Icon(questCategory.icon, size: 14),

                      Text(
                        questCategory.name.toUpperCase(),
                        style: GoogleFonts.jetBrainsMono(
                          color: QuestLogColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        '(${mainQuests.length.toString()})',
                        style: GoogleFonts.jetBrainsMono(
                          color: QuestLogColors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: isExpanded ? 1.0 : 0.0,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    spacing: 16,
                    children: [
                      for (final mainQuest in mainQuests)
                        MainQuestBlock(
                          mainQuest: mainQuest,
                          onAssemble: widget.onAssemble,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainQuestsByCategoryAsync = ref.watch(mainQuestsByCategoryProvider);

    return mainQuestsByCategoryAsync.when(
      data: (mainQuestsByCategory) {
        _mainQuestsByCategory = mainQuestsByCategory;

        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 168),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),

                for (final questCategory in mainQuestsByCategory.keys)
                  _buildCategoryBlock(questCategory),
              ],
            ),
          ),
        );
      },
      loading: () => Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: QuestLogColors.accent),
        ),
      ),
      error: (_, _) => Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: QuestLogColors.accent),
        ),
      ),
    );
  }
}
