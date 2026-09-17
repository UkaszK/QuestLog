import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/quest_priority.dart';
import 'package:questlog/theme/quest_log_colors.dart';

class QuestPrioritySelector extends StatelessWidget {
  const QuestPrioritySelector({
    super.key,
    required this.questPriorities,
    required this.selection,
    required this.onChange,
  });

  final List<QuestPriority> questPriorities;
  final QuestPriority selection;
  final void Function(QuestPriority) onChange;

  Widget _buildPriorityBox(QuestPriority questPriority) {
    bool isSelected = questPriority == selection;
    String label = questPriority.label.toUpperCase();
    Color color = questPriority.color;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () => onChange(questPriority),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
              color: isSelected ? color : QuestLogColors.border,
            ),
          ),
          alignment: AlignmentGeometry.center,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Icon(Icons.square, size: 12, color: color),
              Text(
                label,
                style: GoogleFonts.jetBrainsMono(color: color, fontSize: 12),
              ),
            ],
          ),
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
          'PRIORITY',
          style: GoogleFonts.jetBrainsMono(
            color: QuestLogColors.textSecondary,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          spacing: 10,
          children: [
            for (final questPriority in QuestPriority.values)
              _buildPriorityBox(questPriority),
          ],
        ),
      ],
    );
  }
}
