import 'package:flutter/material.dart';
import 'package:questlog/data/quest.dart';

const dailyAssemblerQuests = [
  Quest(
    icon: Icons.sunny_snowing,
    startTime: '06:00',
    endTime: '07:00',
    name: 'Morning Routine',
    status: QuestStatus.completed,
    subTasks: {'Brush teeth': true, 'Shower': false, 'Get dressed': false},
  ),
  Quest(
    icon: Icons.work,
    startTime: '08:00',
    endTime: '12:00',
    name: 'Work Session',
    status: QuestStatus.pending,
    subTasks: {
      'Plan tasks': true,
      'Focus block': false,
      'Check messages': false,
    },
  ),
  Quest(
    icon: Icons.fitness_center,
    startTime: '12:30',
    endTime: '15:00',
    name: 'Workout',
    status: QuestStatus.active,
    subTasks: {'Warm up': true, 'Workout set': false, 'Stretch': false},
  ),
  Quest(
    icon: Icons.laptop,
    startTime: '18:00',
    endTime: '19:00',
    name: 'Meeting',
    status: QuestStatus.open,
    subTasks: {
      'Review agenda': true,
      'Take notes': false,
      'Send follow-up': false,
    },
  ),
  Quest(
    icon: Icons.nights_stay,
    startTime: '22:00',
    endTime: '22:30',
    name: 'Evening Routine',
    status: QuestStatus.open,
    subTasks: {
      'Wash face': true,
      'Prepare for bed': false,
      'Read a chapter': false,
    },
  ),
];
