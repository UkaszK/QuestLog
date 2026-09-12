import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';

class QuestLogSwitchOptionConfiguration {
  const QuestLogSwitchOptionConfiguration({this.selectedColor});

  final Color? selectedColor;
}

class QuestLogSwitchOption<T> {
  const QuestLogSwitchOption({
    required this.label,
    required this.value,
    this.configurations,
  });

  final String label;
  final T value;
  final QuestLogSwitchOptionConfiguration? configurations;
}

class QuestlogSwitch<T> extends StatelessWidget {
  const QuestlogSwitch({
    super.key,
    required this.options,
    required this.selection,
    required this.onChange,
    this.primaryColor = QuestLogColors.accent,
  });

  final List<QuestLogSwitchOption<T>> options;
  final T selection;
  final void Function(T) onChange;
  final Color primaryColor;

  Widget _buildSwitchButton({
    required String label,
    required isSelected,
    QuestLogSwitchOptionConfiguration? options,
    required VoidCallback onTap,
  }) {
    Color labelColor = isSelected
        ? options?.selectedColor ?? primaryColor
        : QuestLogColors.textSecondary;

    return Expanded(
      child: Padding(
        padding: EdgeInsetsGeometry.all(3),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: isSelected
                  ? QuestLogColors.textPrimary.withValues(alpha: 0.1)
                  : Colors.transparent,
            ),
            child: Text(
              label,
              style: GoogleFonts.jetBrainsMono(
                color: labelColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: QuestLogColors.border),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          for (final option in options)
            _buildSwitchButton(
              label: option.label,
              isSelected: option.value == selection,
              options: option.configurations,
              onTap: () {
                onChange(option.value);
              },
            ),
        ],
      ),
    );
  }
}
