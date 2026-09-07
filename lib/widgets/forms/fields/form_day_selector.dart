import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/day.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/forms/fields/questlog_switch.dart';

class FormDaySelector extends StatefulWidget {
  const FormDaySelector({
    super.key,
    required this.weekdays,
    required this.selection,
    required this.onChange,
  });

  final Set<Day> weekdays;
  final Set<Day> selection;
  final void Function(Set<Day>) onChange;

  @override
  State<StatefulWidget> createState() => _FormDaySelectorState();
}

class _FormDaySelectorState extends State<FormDaySelector> {
  bool _isRecurring = false;

  void _updateItems(Day day, bool selected) {
    final updated = {...widget.selection};
    if (selected) {
      updated.add(day);
    } else {
      updated.remove(day);
    }

    widget.onChange(updated);
  }

  void _clearItems() {
    widget.onChange({});
  }

  Widget _buildDayItem(Day day) {
    bool isSelected = widget.selection.contains(day);

    return InkWell(
      onTap: () => _updateItems(day, !isSelected),
      customBorder: CircleBorder(),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? QuestLogColors.accent : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: QuestLogColors.textSecondary, width: 1),
        ),
        child: Text(
          day.name.toString().substring(0, 1).toUpperCase(),
          style: GoogleFonts.jetBrainsMono(
            color: isSelected ? Colors.black : QuestLogColors.textSecondary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'Quest Frequency',
          style: GoogleFonts.jetBrainsMono(
            color: QuestLogColors.textSecondary,
            fontSize: 12,
          ),
        ),

        QuestlogSwitch(
          options: [
            (label: 'One-time', value: false),
            (label: 'Recurring', value: true),
          ],
          selection: _isRecurring,
          onChange: (value) => setState(() {
            _isRecurring = value;
            if (!value) _clearItems();
          }),
        ),

        if (_isRecurring)
          SingleChildScrollView(
            physics: ScrollPhysics(parent: ClampingScrollPhysics()),
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 10,
              children: [for (final day in widget.weekdays) _buildDayItem(day)],
            ),
          ),
      ],
    );
  }
}
