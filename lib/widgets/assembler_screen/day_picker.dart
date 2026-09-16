import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';

class DayPicker extends StatefulWidget {
  DayPicker({
    super.key,
    required DateTime selectedDay,
    required this.onDaySelected,
  }) : selectedDay = DateUtils.dateOnly(selectedDay);

  final DateTime selectedDay;
  final ValueChanged<DateTime> onDaySelected;

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  void _shiftDays(int offset) {
    final updatedDate = widget.selectedDay.add(Duration(days: offset));
    widget.onDaySelected(updatedDate);
  }

  List<Map<String, dynamic>> get availableDays {
    const weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    return List.generate(5, (index) {
      final date = widget.selectedDay.add(Duration(days: index - 2));
      return {
        'day': weekdays[date.weekday - 1],
        'dayNum': date.day,
        'isSelected': DateUtils.isSameDay(date, widget.selectedDay),
        'fullDate': date,
      };
    });
  }

  Widget _buildDayField(String day, int dayNum, bool isSelected) {
    final color = isSelected
        ? QuestLogColors.accent
        : QuestLogColors.textSecondary.withValues(alpha: 0.3);
    final fontSizeIncrement = isSelected ? 2 : 0;

    TextStyle createFont(double fontSize) {
      return GoogleFonts.jetBrainsMono(
        color: color,
        fontSize: fontSize + fontSizeIncrement,
        fontWeight: FontWeight.w900,
        shadows: isSelected
            ? [Shadow(color: QuestLogColors.accent, blurRadius: 24)]
            : [],
      );
    }

    return (Column(
      children: [
        Text(day.substring(0, 3), style: createFont(9)),
        Text(dayNum.toString(), style: createFont(16)),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 35),
      child: Row(
        spacing: 25,
        children: [
          GestureDetector(
            onTap: () => _shiftDays(-1),
            child: Icon(Icons.chevron_left),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (final dayData in availableDays)
                  GestureDetector(
                    onTap: () => {widget.onDaySelected(dayData['fullDate'])},
                    behavior: HitTestBehavior.opaque,
                    child: _buildDayField(
                      dayData['day'],
                      dayData['dayNum'],
                      dayData['isSelected'],
                    ),
                  ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () => _shiftDays(1),
            child: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
