import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/utils/get_time_text.dart';

class Assembler extends StatelessWidget {
  Assembler({super.key, required this.day, required this.assemblerQuests});

  final DateTime day;
  final List<AssemblerQuest> assemblerQuests;

  final double _pixelsPerMinute = 1.0;
  final double _leftOffset = 70;
  final double _rightOffset = 15;

  late final DateTime baseDate = DateTime(day.year, day.month, day.day);

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

    final sortedQuests = List<AssemblerQuest>.from(assemblerQuests)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    DateTime currentTracker = baseDate;
    final endOfDay = baseDate.add(const Duration(hours: 24));

    for (final quest in sortedQuests) {
      if (quest.startTime.isAfter(currentTracker)) {
        blocks.add(_buildInsertBlock(currentTracker, quest.startTime));
      }

      int minutesFromStart = quest.startTime.difference(baseDate).inMinutes;
      double topPosition = minutesFromStart * _pixelsPerMinute;
      double height = quest.durationInMinutes * _pixelsPerMinute;

      String title = quest.questInfo.name;
      String description = quest.questInfo.subTasks
          .map((el) => el.name)
          .join(', ');
      Color statusColor = quest.statusColor;
      String timeText = getTimeText(
        quest.startTime,
        quest.endTime,
        height >= 50,
      );

      blocks.add(
        Positioned(
          top: topPosition + 2,
          left: _leftOffset,
          right: _rightOffset,
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
      currentTracker = quest.endTime;
    }

    if (currentTracker.isBefore(endOfDay)) {
      blocks.add(_buildInsertBlock(currentTracker, endOfDay));
    }

    return Stack(clipBehavior: Clip.none, children: blocks);
  }

  Widget _buildInsertBlock(DateTime start, DateTime end) {
    int minutesFromStart = start.difference(baseDate).inMinutes;
    int duration = end.difference(start).inMinutes;

    double topPosition = minutesFromStart * _pixelsPerMinute;
    double topOffset = 2;
    double height = duration * _pixelsPerMinute - topOffset * 2;

    String timeText = getTimeText(start, end, false);

    bool isSmallBlock = height < 50;

    Color color = QuestLogColors.textSecondary.withValues(alpha: 0.3);

    return Positioned(
      top: topPosition + 5 + topOffset,
      left: _leftOffset,
      right: _rightOffset,
      height: height - 5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 15,
            height: 1,
            color: color,
            margin: EdgeInsets.only(top: 1),
          ),
          Expanded(
            child: DottedBorder(
              options: RectDottedBorderOptions(strokeWidth: 1, color: color),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                child: Text(
                  '+ INSERT BLOCK ($timeText)',
                  maxLines: isSmallBlock ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.jetBrainsMono(
                    color: color,
                    fontSize: isSmallBlock ? 10 : 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
