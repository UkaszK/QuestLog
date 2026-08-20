import 'package:flutter/material.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/quest.dart';
import 'package:questlog/data/side_quest.dart';

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

const dummySideQuests = [
  SideQuest(
    name: 'Read a Book',
    questCategory: .learning,
    repeatDays: {.monday, .tuesday, .wednesday, .thursday, .friday},
  ),
  SideQuest(
    name: 'Care for Plants',
    questCategory: .chores,
    repeatDays: {.monday, .thursday},
  ),
  SideQuest(
    name: 'Tidy Desk',
    questCategory: .chores,
    repeatDays: {.saturday, .sunday},
  ),
  SideQuest(name: 'Gym', questCategory: .fitness, repeatDays: {}),
];

final dummyMainQuests = [
  MainQuest(
    name: 'Launch Product Sprint',
    questCategory: .work,
    durationMin: 150,
    subTasks: {
      'Define goals': true,
      'Prioritize tasks': true,
      'Ship MVP': false,
    },
    dueDate: DateTime(2026, 8, 22),
    priority: .high,
  ),
  MainQuest(
    name: 'Weekend Reset',
    questCategory: .chores,
    durationMin: 90,
    subTasks: {'Laundry': true, 'Vacuum': false, 'Meal prep': false},
    dueDate: DateTime(2026, 8, 23),
    priority: .low,
  ),
  MainQuest(
    name: 'Marathon Training',
    questCategory: .fitness,
    durationMin: 85,
    subTasks: {'Warm-up': true, 'Run intervals': false, 'Stretch': false},
    dueDate: DateTime(2026, 8, 25),
    priority: .high,
  ),
  MainQuest(
    name: 'Reading Streak',
    questCategory: .learning,
    durationMin: 45,
    subTasks: {
      'Read chapter': true,
      'Take notes': false,
      'Summarize insights': false,
    },
    dueDate: DateTime(2026, 8, 21),
    priority: .medium,
  ),
  MainQuest(
    name: 'Health Check-In',
    questCategory: .health,
    durationMin: 30,
    subTasks: {
      'Drink water': true,
      'Go for a walk': false,
      'Plan sleep': false,
    },
    dueDate: DateTime(2026, 8, 20),
    priority: .low,
  ),
];
