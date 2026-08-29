import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';

class QuestlogSwitch<T> extends StatelessWidget {
  const QuestlogSwitch({
    super.key,
    required this.options,
    required this.selection,
    required this.onChange,
  });

  final List<({String label, T value})> options;
  final T selection;
  final void Function(T) onChange;

  Widget _buildSwitchButton({
    required String label,
    required isSelected,
    required VoidCallback onTap,
  }) {
    Color labelColor = isSelected
        ? QuestLogColors.accent
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
      ),
      child: Row(
        children: [
          for (final option in options)
            _buildSwitchButton(
              label: option.label,
              isSelected: option.value == selection,
              onTap: () {
                onChange(option.value);
              },
            ),
        ],
      ),
    );
  }
}
