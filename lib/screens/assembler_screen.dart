import 'package:flutter/material.dart';
import 'package:questlog/data/dummy_quests.dart';
import 'package:questlog/widgets/assembler_screen/day_picker.dart';

class AssemblerScreen extends StatefulWidget {
  const AssemblerScreen({super.key});

  @override
  State<AssemblerScreen> createState() => _AssemblerScreenState();
}

class _AssemblerScreenState extends State<AssemblerScreen> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DayPicker(
          selectedDay: _selectedDay,
          onDaySelected: (value) {
            setState(() {
              _selectedDay = value;
            });
          },
          assemblerQuests: dailyAssemblerQuests,
        ),
      ],
    );
  }
}
