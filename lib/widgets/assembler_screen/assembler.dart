import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/assembler_main_quest.dart';
import 'package:questlog/data/time_slot.dart';
import 'package:questlog/theme/quest_log_colors.dart';
import 'package:questlog/utils/get_time_text.dart';

class Assembler extends StatefulWidget {
  const Assembler({
    super.key,
    required this.baseDate,
    required this.assemblerQuests,
    required this.displayInsertBlocks,
    required this.hasOverlap,
    this.selectedTimeSlot,
    required this.onSelectTimeSlot,
    required this.onUpdateTimeSlot,
    required this.onSelectExistingQuest,
  });

  final DateTime baseDate;
  final List<AssemblerMainQuest> assemblerQuests;
  final bool displayInsertBlocks;
  final bool hasOverlap;
  final TimeSlot? selectedTimeSlot;
  final void Function(TimeSlot) onSelectTimeSlot;
  final void Function(TimeSlot) onUpdateTimeSlot;
  final void Function(AssemblerMainQuest) onSelectExistingQuest;

  @override
  State<StatefulWidget> createState() => _AssemblerState();
}

class _AssemblerState extends State<Assembler> {
  final double _pixelsPerMinute = 1.0;
  final double _leftOffset = 70;
  final double _rightOffset = 15;
  final int _dragStepMinutes = 5;
  final double _blocksOffsetY = 8;

  DateTime? _currentStart;
  DateTime? _currentEnd;
  double _dragAccumulator = 0.0;
  AssemblerMainQuest? _editingQuest;

  DateTime get _endOfDay =>
      widget.baseDate.add(Duration(hours: 23, minutes: 59));

  // Rounds to the nearest 5-minute mark of the day (e.g. 07:13 -> 07:15).
  DateTime _snapToDragStep(DateTime time) {
    final minutesSinceBase = time.difference(widget.baseDate).inMinutes;
    final snapped =
        (minutesSinceBase / _dragStepMinutes).round() * _dragStepMinutes;
    return widget.baseDate.add(Duration(minutes: snapped));
  }

  void _resetSelectedSlot() {
    setState(() {
      _currentStart = null;
      _currentEnd = null;
      _editingQuest = null;
    });
  }

  @override
  void didUpdateWidget(covariant Assembler oldWidget) {
    super.didUpdateWidget(oldWidget);

    final dayChanged = !DateUtils.isSameDay(
      widget.baseDate,
      oldWidget.baseDate,
    );
    final insertBlocksReenabled =
        widget.displayInsertBlocks && !oldWidget.displayInsertBlocks;

    if (dayChanged || insertBlocksReenabled) {
      _resetSelectedSlot();
    } else if (widget.selectedTimeSlot != null &&
        (widget.selectedTimeSlot!.startTime != _currentStart ||
            widget.selectedTimeSlot!.endTime != _currentEnd)) {
      setState(() {
        _currentStart = widget.selectedTimeSlot!.startTime;
        _currentEnd = widget.selectedTimeSlot!.endTime;
      });
    }
  }

  void _notifyTimeSlotUpdated() {
    widget.onUpdateTimeSlot((startTime: _currentStart!, endTime: _currentEnd!));
  }

  void _selectSlot(DateTime start, DateTime end) {
    setState(() {
      _currentStart = start;
      _currentEnd = end;
    });
    widget.onSelectTimeSlot((startTime: start, endTime: end));
    _notifyTimeSlotUpdated();
  }

  void _selectExistingQuest(AssemblerMainQuest assemblerQuest) {
    setState(() {
      _currentStart = assemblerQuest.startTime;
      _currentEnd = assemblerQuest.endTime;
      _editingQuest = assemblerQuest;
    });
    widget.onSelectExistingQuest(assemblerQuest);
    _notifyTimeSlotUpdated();
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

    for (int hour = widget.baseDate.hour; hour <= 24; hour += 2) {
      double topPosition =
          (hour - widget.baseDate.hour) * 60 * _pixelsPerMinute;

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

  Widget _buildTimeBlocks(BuildContext context) {
    List<Widget> blocks = [];

    final sortedAssemblerQuests = List.of(widget.assemblerQuests)
      ..sort((a, b) => a.compareTo(b));

    DateTime currentTracker =
        widget.baseDate; // Used for generating insert blocks
    final endOfDay = widget.baseDate.add(
      const Duration(hours: 23, minutes: 59),
    );

    final bool showInsertBlocks =
        widget.displayInsertBlocks && _currentStart == null;

    for (final assemblerQuest in sortedAssemblerQuests) {
      if (showInsertBlocks) {
        while (currentTracker.isBefore(assemblerQuest.startTime)) {
          final desiredEndTime = currentTracker.add(Duration(hours: 4));

          if (desiredEndTime.isBefore(assemblerQuest.startTime)) {
            blocks.add(
              _buildInsertBlock(context, currentTracker, desiredEndTime),
            );

            currentTracker = desiredEndTime;
            continue;
          }

          blocks.add(
            _buildInsertBlock(
              context,
              currentTracker,
              assemblerQuest.startTime,
            ),
          );

          currentTracker = assemblerQuest.startTime;
        }
      }

      // Don't build time block for selected quest
      if (_editingQuest?.id == assemblerQuest.id) {
        currentTracker = assemblerQuest.endTime;
        continue;
      }

      // Calculate position by start time and height by duration
      int minutesFromStart = assemblerQuest.startTime
          .difference(widget.baseDate)
          .inMinutes;
      double topPosition = minutesFromStart * _pixelsPerMinute + _blocksOffsetY;
      double height = assemblerQuest.durationInMinutes * _pixelsPerMinute;

      final tinySized = height < 30;
      final smallSized =
          height < 60; // only title and one-line time text visible
      final largeSized = height >= 80; // two-line time text and description

      String title = assemblerQuest.name;
      String description = assemblerQuest.subTasks
          .map((el) => el.name)
          .join(', ');
      Color statusColor = assemblerQuest.status.color;
      String timeText = getTimeText(
        assemblerQuest.startTime,
        assemblerQuest.endTime,
        !smallSized,
      );

      blocks.add(
        Positioned(
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
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _selectExistingQuest(assemblerQuest),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: smallSized ? 4 : 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: statusColor, width: 1),
                    ),
                    child: ClipRect(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!tinySized) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: smallSized
                                  ? CrossAxisAlignment.center
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: GoogleFonts.jetBrainsMono(
                                    color: statusColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),

                                Flexible(
                                  child: Text(
                                    timeText,
                                    maxLines: smallSized ? 1 : 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.jetBrainsMono(
                                      color: QuestLogColors.textPrimary,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],

                          if (largeSized && description.isNotEmpty) ...[
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
              ),
            ],
          ),
        ),
      );
      currentTracker = assemblerQuest.endTime;
    }

    if (showInsertBlocks) {
      while (currentTracker.isBefore(endOfDay)) {
        final desiredEndTime = currentTracker.add(Duration(hours: 4));

        if (desiredEndTime.isBefore(endOfDay)) {
          blocks.add(
            _buildInsertBlock(context, currentTracker, desiredEndTime),
          );

          currentTracker = desiredEndTime;
          continue;
        }

        blocks.add(_buildInsertBlock(context, currentTracker, endOfDay));
        currentTracker = endOfDay;
      }
    }

    if (_currentStart != null && _currentEnd != null) {
      blocks.add(_buildInteractiveSlotBlock());
    }

    return Stack(children: blocks);
  }

  Widget _buildInsertBlock(BuildContext context, DateTime start, DateTime end) {
    int minutesFromStart = start.difference(widget.baseDate).inMinutes;
    int duration = end.difference(start).inMinutes;

    double topPosition =
        minutesFromStart * _pixelsPerMinute + _blocksOffsetY + 3;
    double height = duration * _pixelsPerMinute - 6;

    String timeText = getTimeText(start, end, false);

    bool tinySized = height < 20;
    bool smallSized = height < 60;

    Color color = QuestLogColors.textSecondary.withValues(alpha: 0.3);

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
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _selectSlot(start, end),
              child: DottedBorder(
                options: RectDottedBorderOptions(strokeWidth: 1, color: color),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  child: !tinySized
                      ? Text(
                          '+ INSERT BLOCK ($timeText)',
                          maxLines: smallSized ? 1 : 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.jetBrainsMono(
                            color: color,
                            fontSize: smallSized ? 10 : 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveSlotBlock() {
    int minutesFromStart = _currentStart!.difference(widget.baseDate).inMinutes;
    int duration = _currentEnd!.difference(_currentStart!).inMinutes;

    double topPosition = minutesFromStart * _pixelsPerMinute + _blocksOffsetY;
    double height = duration * _pixelsPerMinute;

    final smallSized = height < 60; // one-line time text

    String timeText = getTimeText(_currentStart!, _currentEnd!, !smallSized);

    final slotColor = widget.hasOverlap
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
            child: Container(
              decoration: BoxDecoration(
                color: slotColor.withValues(alpha: 0.1),
                border: Border.all(color: slotColor, width: 2),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onVerticalDragStart: (_) => _dragAccumulator = 0.0,
                      onVerticalDragUpdate: (details) {
                        _dragAccumulator += details.delta.dy;
                        if (_dragAccumulator.abs() >= _dragStepMinutes) {
                          int steps = (_dragAccumulator / _dragStepMinutes)
                              .truncate();
                          int mins = steps * _dragStepMinutes;
                          _dragAccumulator -= mins;
                          setState(() {
                            final currentDuration = _currentEnd!.difference(
                              _currentStart!,
                            );
                            var newStart = _snapToDragStep(
                              _currentStart!.add(Duration(minutes: mins)),
                            );
                            var newEnd = newStart.add(currentDuration);
                            if (newStart.isBefore(widget.baseDate)) {
                              newStart = widget.baseDate;
                              newEnd = widget.baseDate.add(currentDuration);
                            } else if (newEnd.isAfter(_endOfDay)) {
                              newEnd = _endOfDay;
                              newStart = _endOfDay.subtract(currentDuration);
                            }
                            _currentStart = newStart;
                            _currentEnd = newEnd;
                          });
                          _notifyTimeSlotUpdated();
                        }
                      },

                      child: height >= 30
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  timeText,
                                  style: GoogleFonts.jetBrainsMono(
                                    color: slotColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),

                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onVerticalDragStart: (_) => _dragAccumulator = 0.0,
                      onVerticalDragUpdate: (details) {
                        _dragAccumulator += details.delta.dy;
                        if (_dragAccumulator.abs() >= _dragStepMinutes) {
                          int steps = (_dragAccumulator / _dragStepMinutes)
                              .truncate();
                          int mins = steps * _dragStepMinutes;
                          _dragAccumulator -= mins;
                          setState(() {
                            var newStart = _snapToDragStep(
                              _currentStart!.add(Duration(minutes: mins)),
                            );
                            if (newStart.isBefore(widget.baseDate)) {
                              newStart = widget.baseDate;
                            }

                            if (!newStart.isBefore(widget.baseDate) &&
                                newStart.isBefore(
                                  _currentEnd!.subtract(
                                    const Duration(minutes: 15),
                                  ),
                                )) {
                              _currentStart = newStart;
                            }
                          });
                          _notifyTimeSlotUpdated();
                        }
                      },

                      child: Container(
                        height: 15,
                        color: Colors.transparent,
                        child: const Center(
                          child: Icon(
                            Icons.drag_handle,
                            size: 16,
                            color: QuestLogColors.accent,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onVerticalDragStart: (_) => _dragAccumulator = 0.0,
                      onVerticalDragUpdate: (details) {
                        _dragAccumulator += details.delta.dy;
                        if (_dragAccumulator.abs() >= _dragStepMinutes) {
                          int steps = (_dragAccumulator / _dragStepMinutes)
                              .truncate();
                          int mins = steps * _dragStepMinutes;
                          _dragAccumulator -= mins;
                          setState(() {
                            var newEnd = _snapToDragStep(
                              _currentEnd!.add(Duration(minutes: mins)),
                            );
                            if (newEnd.isAfter(_endOfDay)) {
                              newEnd = _endOfDay;
                            }
                            if (newEnd.isAfter(
                              _currentStart!.add(const Duration(minutes: 15)),
                            )) {
                              _currentEnd = newEnd;
                            }
                          });
                          _notifyTimeSlotUpdated();
                        }
                      },
                      child: Container(
                        height: 15,
                        color: Colors.transparent,
                        child: const Center(
                          child: Icon(
                            Icons.drag_handle,
                            size: 16,
                            color: QuestLogColors.accent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
      padding: EdgeInsets.only(top: 30, bottom: 150),
      child: SizedBox(
        width: double.infinity,
        height:
            (24 - widget.baseDate.hour) * 60 * _pixelsPerMinute +
            _blocksOffsetY * 2,
        child: Stack(children: [_buildTimeGrid(), _buildTimeBlocks(context)]),
      ),
    );
  }
}
