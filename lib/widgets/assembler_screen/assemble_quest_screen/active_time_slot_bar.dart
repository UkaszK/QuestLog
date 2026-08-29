import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/screens/main_quest_selection_sheet.dart';
import 'package:questlog/theme/questlog_colors.dart';

class ActiveTimeSlotBar extends StatelessWidget {
  const ActiveTimeSlotBar({
    super.key,
    required this.timeSlotText,
    required this.onReset,
    required this.hasAssembledQuest,
    required this.mainQuestsByCategory,
    required this.onQuestAssembled,
    required this.assembledQuestName,
    required this.onSave,
    required this.onClearQuest,
    required this.hasOverlap,
    required this.isEditingExistingQuest,
    required this.onDelete,
  });

  final String timeSlotText;
  final VoidCallback onReset;
  final bool hasAssembledQuest;
  final Map<QuestCategory, List<MainQuest>> mainQuestsByCategory;
  final void Function(MainQuest) onQuestAssembled;
  final String assembledQuestName;
  final VoidCallback onSave;
  final VoidCallback onClearQuest;
  final bool hasOverlap;
  final bool isEditingExistingQuest;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: QuestLogColors.surface,
        border: const Border(
          bottom: BorderSide(width: 1, color: QuestLogColors.accent),
        ),
        boxShadow: [
          BoxShadow(
            color: QuestLogColors.accent.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        size: 16,
                        color: QuestLogColors.accent,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'SLOT: $timeSlotText',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.jetBrainsMono(
                            color: QuestLogColors.accent,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: onReset,
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: QuestLogColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            if (hasAssembledQuest) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          hasOverlap
                              ? Icons.error_outline
                              : Icons.check_circle_outline,
                          size: 16,
                          color: hasOverlap
                              ? QuestLogColors.danger
                              : QuestLogColors.accent,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            assembledQuestName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.jetBrainsMono(
                              color: hasOverlap
                                  ? QuestLogColors.danger
                                  : QuestLogColors.accent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.check, size: 16),
                    label: Text(
                      'SAVE',
                      style: GoogleFonts.jetBrainsMono(fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: QuestLogColors.accent,
                      foregroundColor: QuestLogColors.surface,
                      disabledBackgroundColor: QuestLogColors.textSecondary
                          .withValues(alpha: 0.2),
                      disabledForegroundColor: QuestLogColors.textSecondary,
                    ),
                    onPressed: hasOverlap ? null : onSave,
                  ),
                  const SizedBox(width: 8),
                  if (isEditingExistingQuest)
                    InkWell(
                      onTap: onDelete,
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: QuestLogColors.danger,
                        ),
                      ),
                    )
                  else
                    InkWell(
                      onTap: onClearQuest,
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: QuestLogColors.textSecondary,
                        ),
                      ),
                    ),
                ],
              ),

              if (hasOverlap) ...[
                const SizedBox(height: 4),
                Text(
                  'OVERLAPS AN EXISTING QUEST',
                  style: GoogleFonts.jetBrainsMono(
                    color: QuestLogColors.danger,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ] else
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.add, size: 16),
                  label: Text(
                    'QUEST',
                    style: GoogleFonts.jetBrainsMono(fontSize: 12),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: QuestLogColors.accent,
                    side: const BorderSide(color: QuestLogColors.accent),
                  ),
                  onPressed: () {
                    late final PersistentBottomSheetController controller;
                    controller = showBottomSheet(
                      context: context,
                      builder: (context) => MainQuestSelectionSheet(
                        mainQuestsByCategory: mainQuestsByCategory,
                        onAssemble: (mainQuest) {
                          onQuestAssembled(mainQuest);
                          controller.close();
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
