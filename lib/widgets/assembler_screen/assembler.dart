import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/assembler_main_quest.dart';
import 'package:questlog/data/time_slot.dart';
import 'package:questlog/theme/quest_log_colors.dart';
import 'package:questlog/widgets/assembler_screen/insert_block_widget.dart';
import 'package:questlog/widgets/assembler_screen/interactive_block_widget.dart';
import 'package:questlog/widgets/assembler_screen/quest_block_widget.dart';

abstract class _TimelineBlock {
  _TimelineBlock(this.startTime, this.endTime);

  final DateTime startTime;
  final DateTime endTime;
}

class _QuestBlock extends _TimelineBlock {
  _QuestBlock(this.quest) : super(quest.startTime, quest.endTime);

  final AssemblerMainQuest quest;
}

class _InsertBlock extends _TimelineBlock {
  _InsertBlock(super.startTime, super.endTime);
}

class _InteractiveBlock extends _TimelineBlock {
  _InteractiveBlock(super.startTime, super.endTime);
}

class Assembler extends StatelessWidget {
  const Assembler({
    super.key,
    required this.baseDate,
    required this.assemblerQuests,
    required this.displayInsertBlocks,
    required this.hasOverlap,
    this.selectedTimeSlot,
    this.editingQuest,
    required this.onSelectTimeSlot,
    required this.onUpdateTimeSlot,
    required this.onSelectExistingQuest,
  });

  final DateTime baseDate;
  final List<AssemblerMainQuest> assemblerQuests;
  final bool displayInsertBlocks;
  final bool hasOverlap;
  final TimeSlot? selectedTimeSlot;
  final AssemblerMainQuest? editingQuest;
  final void Function(TimeSlot) onSelectTimeSlot;
  final void Function(TimeSlot) onUpdateTimeSlot;
  final void Function(AssemblerMainQuest) onSelectExistingQuest;

  static const _pixelsPerMinute = 1.0;
  static const _leftOffset = 70.0;
  static const _rightOffset = 15.0;
  static const _dragStepMinutes = 5;
  static const _blocksOffsetY = 8.0;
  void _selectSlot(DateTime start, DateTime end) {
    onSelectTimeSlot((startTime: start, endTime: end));
    onUpdateTimeSlot((startTime: start, endTime: end));
  }

  void _selectExistingQuest(AssemblerMainQuest assemblerQuest) {
    onSelectExistingQuest(assemblerQuest);
    onUpdateTimeSlot((
      startTime: assemblerQuest.startTime,
      endTime: assemblerQuest.endTime,
    ));
  }

  List<_TimelineBlock> _generateTimelineBlocks() {
    final List<_TimelineBlock> blocks = [];

    final sortedQuests = List.of(assemblerQuests)
      ..sort((a, b) => a.compareByDate(b));

    final endOfDay = baseDate.add(const Duration(hours: 23, minutes: 59));

    DateTime currentTracker = baseDate;

    final bool showInsertBlocks =
        displayInsertBlocks && selectedTimeSlot == null;

    void fillWithInsertBlocks(DateTime gapStart, DateTime gapEnd) {
      DateTime tracker = gapStart;
      while (tracker.isBefore(gapEnd)) {
        final desiredEndTime = tracker.add(const Duration(hours: 4));
        final actualEndTime = desiredEndTime.isBefore(gapEnd)
            ? desiredEndTime
            : gapEnd;

        blocks.add(_InsertBlock(tracker, actualEndTime));
        tracker = actualEndTime;
      }
    }

    for (final quest in sortedQuests) {
      if (showInsertBlocks && currentTracker.isBefore(quest.startTime)) {
        fillWithInsertBlocks(currentTracker, quest.startTime);
      }

      if (editingQuest?.id == quest.id) {
        currentTracker = quest.endTime;
      } else {
        blocks.add(_QuestBlock(quest));

        if (quest.endTime.isAfter(currentTracker)) {
          currentTracker = quest.endTime;
        }
      }
    }

    if (showInsertBlocks && currentTracker.isBefore(endOfDay)) {
      fillWithInsertBlocks(currentTracker, endOfDay);
    }

    if (selectedTimeSlot != null) {
      blocks.add(
        _InteractiveBlock(
          selectedTimeSlot!.startTime,
          selectedTimeSlot!.endTime,
        ),
      );
    }

    return blocks;
  }

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

    for (int hour = baseDate.hour; hour <= 24; hour += 2) {
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
                  maxLines: 1,
                  style: GoogleFonts.jetBrainsMono(
                    color: QuestLogColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ),

              const SizedBox(width: 5),

              Container(
                width: 11,
                height: 1,
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

    return Stack(children: gridElements);
  }

  Widget _buildQuestBlock(AssemblerMainQuest quest) {
    // Calculate position by start time and height by duration
    int minutesFromStart = quest.startTime.difference(baseDate).inMinutes;
    double topPosition = minutesFromStart * _pixelsPerMinute + _blocksOffsetY;
    double height = quest.durationInMinutes * _pixelsPerMinute;

    return Positioned(
      top: topPosition,
      left: _leftOffset,
      right: _rightOffset,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 15),

          // The actual quest block
          Expanded(
            child: QuestBlockWidget(
              quest: quest,
              onTap: () => _selectExistingQuest(quest),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsertBlock(DateTime start, DateTime end) {
    int minutesFromStart = start.difference(baseDate).inMinutes;
    int duration = end.difference(start).inMinutes;

    double topPosition =
        minutesFromStart * _pixelsPerMinute + _blocksOffsetY + 3;
    double height = duration * _pixelsPerMinute - 6;

    return Positioned(
      top: topPosition,
      left: _leftOffset,
      right: _rightOffset,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 15),

          Expanded(
            child: InsertBlockWidget(
              startTime: start,
              endTime: end,
              onTap: () => _selectSlot(start, end),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveSlotBlock(DateTime start, DateTime end) {
    int minutesFromStart = start.difference(baseDate).inMinutes;
    int duration = end.difference(start).inMinutes;

    double topPosition = minutesFromStart * _pixelsPerMinute + _blocksOffsetY;
    double height = duration * _pixelsPerMinute;

    final slotColor = hasOverlap
        ? QuestLogColors.danger
        : QuestLogColors.accent;

    return Positioned(
      top: topPosition,
      left: _leftOffset,
      right: _rightOffset,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 15),

          Expanded(
            child: InteractiveBlockWidget(
              baseDate: baseDate,
              startTime: start,
              endTime: end,
              color: slotColor,
              onUpdateTimeSlot: onUpdateTimeSlot,
              dragStepMinutes: _dragStepMinutes,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificBlock(_TimelineBlock block) {
    if (block is _QuestBlock) {
      return _buildQuestBlock(block.quest);
    } else if (block is _InsertBlock) {
      return _buildInsertBlock(block.startTime, block.endTime);
    } else if (block is _InteractiveBlock) {
      return _buildInteractiveSlotBlock(block.startTime, block.endTime);
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final blocks = _generateTimelineBlocks();

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 30, bottom: 150),
      child: SizedBox(
        width: double.infinity,
        height:
            (24 - baseDate.hour) * 60 * _pixelsPerMinute + _blocksOffsetY * 2,
        child: Stack(
          children: [
            _buildTimeGrid(),
            for (final block in blocks) _buildSpecificBlock(block),
          ],
        ),
      ),
    );
  }
}
