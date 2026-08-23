import 'package:flutter/material.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/data/dummy_quests.dart';
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

  List<AssemblerQuest> get _selectedDayQuests {
    return dailyAssemblerQuests
        .where((quest) => DateUtils.isSameDay(quest.startTime, _selectedDay))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

            AssemblerTitle(),

            SizedBox(height: 10),

            Divider(),

            SizedBox(height: 35),

            Expanded(
              child: Assembler(
                day: _selectedDay,
                assemblerQuests: _selectedDayQuests,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
