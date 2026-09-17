import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/quest_log_colors.dart';

class QuestLogDropdown<T> extends StatelessWidget {
  const QuestLogDropdown({
    super.key,
    required this.options,
    required this.selection,
    required this.onChange,
    required this.labelOf,
    required this.primaryColorOf,
  });

  final List<T> options;
  final T selection;
  final void Function(T) onChange;
  final String Function(T) labelOf;
  final Color Function(T) primaryColorOf;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColorOf(selection)),
        borderRadius: BorderRadius.circular(3),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: selection,
          isDense: true,
          dropdownColor: QuestLogColors.surface,
          icon: Icon(
            Icons.expand_more,
            color: primaryColorOf(selection),
            size: 18,
          ),
          onChanged: (filter) {
            if (filter == null) return;
            onChange(filter);
          },
          items: [
            for (final option in options)
              DropdownMenuItem(
                value: option,
                child: Row(
                  children: [
                    Text(
                      labelOf(option).toUpperCase(),
                      style: GoogleFonts.jetBrainsMono(
                        color: option == selection
                            ? primaryColorOf(selection)
                            : QuestLogColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
                onTap: () => onChange(option),
              ),
          ],
        ),
      ),
    );
  }
}
