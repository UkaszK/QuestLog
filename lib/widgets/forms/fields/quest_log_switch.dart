import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';

class QuestLogSwitchOption<T> {
  const QuestLogSwitchOption({
    required this.label,
    required this.value,
    this.primaryColor,
  });

  final String label;
  final T value;
  final Color? primaryColor;
}

class QuestLogSwitch<T> extends StatelessWidget {
  const QuestLogSwitch({
    super.key,
    required this.options,
    required this.selection,
    required this.onChange,
    this.primaryColor = QuestLogColors.accent,
  });

  final List<QuestLogSwitchOption> options;
  final T selection;
  final void Function(T) onChange;
  final Color primaryColor;

  Widget _buildSwitchButton({
    required String label,
    required isSelected,
    Color? optionPrimaryColor,
    required VoidCallback onTap,
  }) {
    Color labelColor = isSelected
        ? optionPrimaryColor ?? primaryColor
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
              optionPrimaryColor: option.primaryColor,
              onTap: () {
                onChange(option.value);
              },
            ),
        ],
      ),
    );
  }
}
