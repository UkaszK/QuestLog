import 'package:flutter/material.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/data/dummy_quests.dart';
import 'package:questlog/screens/add_assembler_quest_screen.dart';
import 'package:questlog/theme/questlog_colors.dart';
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: QuestLogColors.surface,
        shape: BoxBorder.all(width: 1, color: QuestLogColors.textSecondary),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddAssemblerQuestScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add_to_photos_outlined,
          size: 24,
          color: QuestLogColors.textPrimary,
        ),
      ),
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
