import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/theme/questlog_colors.dart';

class Assembler extends StatelessWidget {
  Assembler({super.key, required this.assemblerQuests});

  final List<AssemblerQuest> assemblerQuests;

  final double _pixelsPerMinute = 1.0;
  final double _leftOffset = 70;

  final DateTime baseDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    0,
  );

  Widget _buildTimeGrid() {
    List<Widget> gridElements = [];

    gridElements.add(
      Positioned(
        left: _leftOffset,
        top: 0,
        bottom: 0,
        child: Container(width: 1, color: QuestLogColors.textSecondary),
      ),
    );

    for (int hour = baseDate.hour; hour < 24; hour += 2) {
      double topPosition = (hour - baseDate.hour) * 60 * _pixelsPerMinute;

      gridElements.add(
        Positioned(
          top: topPosition,
          left: 10,
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  '${hour.toString().padLeft(2, '0')}:00',
                  style: GoogleFonts.jetBrainsMono(
                    color: QuestLogColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),

              SizedBox(width: 5),

              Container(
                width: 11,
                height: 11,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: QuestLogColors.textSecondary,
                    width: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(clipBehavior: Clip.none, children: gridElements);
  }

  Widget _buildTimeBlocks() {
    List<Widget> blocks = [];

    for (final assemblerQuest in assemblerQuests) {
      int minutesFromStart = assemblerQuest.startTime
          .difference(baseDate)
          .inMinutes;
      double topPosition = minutesFromStart * _pixelsPerMinute;
      double height = assemblerQuest.durationInMinutes * _pixelsPerMinute;

      String title = assemblerQuest.questInfo.name;
      String description = assemblerQuest.questInfo.subTasks
          .map((el) => el.name)
          .join(', ');
      Color statusColor = assemblerQuest.statusColor;
      String timeText = assemblerQuest.timeText;

      blocks.add(
        Positioned(
          top: topPosition + 2,
          left: _leftOffset,
          right: 15,
          height: height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 15,
                height: 1,
                color: statusColor,
                margin: EdgeInsets.only(top: 6),
              ),

              // The actual quest block
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: height < 40 ? 4 : 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: statusColor, width: 1),
                  ),
                  child: ClipRect(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.jetBrainsMono(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            if (height >= 60)
                              Text(
                                timeText,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: QuestLogColors.textPrimary,
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                ),
                              ),
                          ],
                        ),

                        if (height >= 70 && description.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: QuestLogColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(clipBehavior: Clip.none, children: blocks);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: (24 - baseDate.hour) * 60 * _pixelsPerMinute,
        child: Stack(children: [_buildTimeGrid(), _buildTimeBlocks()]),
      ),
    );
  }
}
