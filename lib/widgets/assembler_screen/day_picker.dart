import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/theme/questlog_colors.dart';

class DayPicker extends StatefulWidget {
  const DayPicker({
    super.key,
    required this.selectedDay,
    required this.onDaySelected,
    required this.assemblerQuests,
  });

  final DateTime selectedDay;
  final ValueChanged<DateTime> onDaySelected;
  final List<AssemblerQuest> assemblerQuests;

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  late DateTime _baseDate;

  @override
  void initState() {
    super.initState();
    _baseDate = widget.selectedDay;
  }

  void _shiftDays(int offset) {
    setState(() {
      _baseDate = _baseDate.add(Duration(days: offset));
      widget.onDaySelected(_baseDate);
    });
  }

  List<Map<String, dynamic>> get availableDays {
    const weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    return List.generate(5, (index) {
      final date = _baseDate.add(Duration(days: index - 2));
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
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => _shiftDays(-1),
            icon: Icon(Icons.chevron_left),
          ),

          for (final dayData in availableDays)
            GestureDetector(
              onTap: () => {
                setState(() {
                  _baseDate = dayData['fullDate'];
                }),
                widget.onDaySelected(dayData['fullDate']),
              },
              behavior: HitTestBehavior.opaque,
              child: _buildDayField(
                dayData['day'],
                dayData['dayNum'],
                dayData['isSelected'],
              ),
            ),

          IconButton(
            onPressed: () => _shiftDays(1),
            icon: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
