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

  // Past days are read-only, so insert blocks are not offered there.
  bool get _isPastDay {
    final today = DateTime.now();
    final selectedDate = DateTime(
      _selectedDay.year,
      _selectedDay.month,
      _selectedDay.day,
    );
    return selectedDate.isBefore(DateTime(today.year, today.month, today.day));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _isPastDay
          ? null
          : Padding(
              padding: EdgeInsetsGeometry.only(bottom: 100),
              child: SizedBox(
                width: 48,
                height: 48,
                child: FloatingActionButton(
                  heroTag: 'assembler_fab',
                  backgroundColor: QuestLogColors.surface,
                  elevation: 0,
                  shape: BoxBorder.all(
                    width: 1,
                    color: QuestLogColors.textSecondary.withValues(alpha: 0.5),
                  ),
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
              ),
            ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
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

            Divider(height: 1),

            Expanded(
              child: Assembler(
                day: _selectedDay,
                assemblerQuests: _selectedDayQuests,
                isPastDay: _isPastDay,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
