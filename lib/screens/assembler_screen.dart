import 'package:flutter/material.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/data/dummy_data.dart';
import 'package:questlog/data/time_slot.dart';
import 'package:questlog/utils/get_time_text.dart';
import 'package:questlog/widgets/assembler_screen/assemble_quest_screen/active_time_slot_bar.dart';
import 'package:questlog/widgets/assembler_screen/assembler.dart';
import 'package:questlog/widgets/assembler_screen/assembler_title.dart';
import 'package:questlog/widgets/assembler_screen/day_picker.dart';

class AssemblerScreen extends StatefulWidget {
  const AssemblerScreen({super.key});

  @override
  State<AssemblerScreen> createState() => _AssemblerScreenState();
}

class _AssemblerScreenState extends State<AssemblerScreen> {
  DateTime _selectedDay = DateTime.now();
  TimeSlot? _selectedTimeSlot;

  List<AssemblerQuest> get _selectedDayQuests {
    return dailyAssemblerQuests
        .where((quest) => DateUtils.isSameDay(quest.startTime, _selectedDay))
        .toList();
  }

  bool get _isPastDay {
    final today = DateTime.now();
    final selectedDate = DateTime(
      _selectedDay.year,
      _selectedDay.month,
      _selectedDay.day,
    );
    return selectedDate.isBefore(DateTime(today.year, today.month, today.day));
  }

  void _resetTimeSlot() {
    setState(() {
      _selectedTimeSlot = null;
    });
  }

  void _updateSelectedTimeSlot(TimeSlot slot) {
    setState(() {
      _selectedTimeSlot = slot;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasTimeSlot = _selectedTimeSlot != null;
    final DateTime baseDate = DateTime(
      _selectedDay.year,
      _selectedDay.month,
      _selectedDay.day,
    );

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 20,
                left: 16,
                right: 16,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DayPicker(
                    selectedDay: _selectedDay,
                    onDaySelected: (value) {
                      setState(() {
                        _selectedDay = value;
                        _selectedTimeSlot = null;
                      });
                    },
                    assemblerQuests: dailyAssemblerQuests,
                  ),
                  AssemblerTitle(),

                  const SizedBox(height: 10),

                  const Divider(height: 1),

                  Assembler(
                    baseDate: baseDate,
                    assemblerQuests: _selectedDayQuests,
                    displayInsertBlocks: !_isPastDay && !hasTimeSlot,
                    onSelectTimeSlot: _updateSelectedTimeSlot,
                    onUpdateTimeSlot: _updateSelectedTimeSlot,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, -1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              child: hasTimeSlot
                  ? ActiveTimeSlotBar(
                      key: const ValueKey('active-slot-bar'),
                      timeSlotText: getTimeText(
                        _selectedTimeSlot!.startTime,
                        _selectedTimeSlot!.endTime,
                        false,
                      ),
                      onReset: _resetTimeSlot,
                    )
                  : const SizedBox.shrink(key: ValueKey('slot-bar-empty')),
            ),
          ),
        ],
      ),
    );
  }
}
