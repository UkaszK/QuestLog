import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';

typedef QuestLogChoiceChipBarOption<T> = ({
  String label,
  T value,
  Color? primaryColor,
});

class QuestLogChoiceChipBar<T> extends StatelessWidget {
  const QuestLogChoiceChipBar({
    super.key,
    required this.options,
    required this.selection,
    required this.onChange,
    this.primaryColor = QuestLogColors.accent,
  });

  final List<QuestLogChoiceChipBarOption> options;
  final T selection;
  final void Function(T) onChange;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        children: [
          for (final option in options) ...[
            _OptionContainer(
              label: option.label,
              onSelect: () => onChange(option.value),
              textColor: option.value == selection
                  ? QuestLogColors.black
                  : QuestLogColors.textSecondary,
              backgroundColor: option.value == selection
                  ? option.primaryColor ?? primaryColor
                  : QuestLogColors.surface,
              borderColor: option.value == selection
                  ? option.primaryColor ?? primaryColor
                  : QuestLogColors.border,
            ),
          ],
        ],
      ),
    );
  }
}

class _OptionContainer<T> extends StatelessWidget {
  const _OptionContainer({
    required this.label,
    required this.onSelect,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
  });

  final String label;
  final VoidCallback onSelect;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(3),
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(3),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: backgroundColor,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.jetBrainsMono(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
