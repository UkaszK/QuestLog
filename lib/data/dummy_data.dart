import 'package:flutter/material.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/data/quest_info.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/utils/set_time.dart';

final questCategories = [
  QuestCategory(name: 'Chores', icon: Icons.cleaning_services),
  QuestCategory(name: 'Creative', icon: Icons.palette),
  QuestCategory(name: 'Errands', icon: Icons.local_grocery_store),
  QuestCategory(name: 'Finance', icon: Icons.account_balance_wallet),
  QuestCategory(name: 'Fitness', icon: Icons.fitness_center),
  QuestCategory(name: 'Health', icon: Icons.favorite),
  QuestCategory(name: 'Learning', icon: Icons.menu_book),
  QuestCategory(name: 'Other', icon: Icons.category),
  QuestCategory(name: 'Personal', icon: Icons.person),
  QuestCategory(name: 'Social', icon: Icons.group),
  QuestCategory(name: 'Travel', icon: Icons.flight),
  QuestCategory(name: 'Work', icon: Icons.work),
];

final dailyAssemblerQuests = [
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Plan Weekly Goals',
      questCategory: questCategories.firstWhere((q) => q.name == 'Learning'),
      subTasks: [
        (name: 'Review last week', completed: true),
        (name: 'Choose priorities', completed: true),
      ],
    ),
    startTime: setTime(DateTime.now().subtract(const Duration(days: 1)), 9, 0),
    endTime: setTime(DateTime.now().subtract(const Duration(days: 1)), 10, 30),
    status: QuestStatus.completed,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Grocery Shopping',
      questCategory: questCategories.firstWhere((q) => q.name == 'Chores'),
      subTasks: [],
    ),
    startTime: setTime(DateTime.now().subtract(Duration(days: 1)), 16, 0),
    endTime: setTime(DateTime.now().subtract(Duration(days: 1)), 17, 0),
    status: QuestStatus.completed,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Morning Routine',
      questCategory: questCategories.firstWhere((q) => q.name == 'Personal'),
      subTasks: [],
    ),
    startTime: setTime(DateTime.now(), 7, 0),
    endTime: setTime(DateTime.now(), 8, 0),
    status: QuestStatus.completed,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Deep Work',
      questCategory: questCategories.firstWhere((q) => q.name == 'Work'),
      subTasks: [],
    ),
    startTime: setTime(DateTime.now(), 8, 0),
    endTime: setTime(DateTime.now(), 12, 0),
    status: QuestStatus.pending,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Workout',
      questCategory: questCategories.firstWhere((q) => q.name == 'Fitness'),
      subTasks: [
        (name: 'Warm up', completed: true),
        (name: 'Workout set', completed: false),
        (name: 'Stretch', completed: false),
      ],
    ),
    startTime: setTime(DateTime.now(), 12, 30),
    endTime: setTime(DateTime.now(), 15, 0),
    status: QuestStatus.active,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Meeting',
      questCategory: questCategories.firstWhere((q) => q.name == 'Work'),
      subTasks: [
        (name: 'Review agenda', completed: true),
        (name: 'Take notes', completed: false),
        (name: 'Send follow-up', completed: false),
      ],
    ),
    startTime: setTime(DateTime.now(), 18, 0),
    endTime: setTime(DateTime.now(), 19, 0),
    status: QuestStatus.open,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Evening Routine',
      questCategory: questCategories.firstWhere((q) => q.name == 'Health'),
      subTasks: [
        (name: 'Wash face', completed: true),
        (name: 'Prepare for bed', completed: false),
        (name: 'Read a chapter', completed: false),
      ],
    ),
    startTime: setTime(DateTime.now(), 22, 0),
    endTime: setTime(DateTime.now(), 22, 30),
    status: QuestStatus.open,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Plan Next Sprint',
      questCategory: questCategories.firstWhere((q) => q.name == 'Work'),
      subTasks: [
        (name: 'Review backlog', completed: false),
        (name: 'Set sprint goals', completed: false),
      ],
    ),
    startTime: setTime(DateTime.now().add(const Duration(days: 1)), 9, 30),
    endTime: setTime(DateTime.now().add(const Duration(days: 1)), 11, 0),
    status: QuestStatus.open,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Evening Walk',
      questCategory: questCategories.firstWhere((q) => q.name == 'Fitness'),
      subTasks: [],
    ),
    startTime: setTime(DateTime.now().add(const Duration(days: 1)), 18, 30),
    endTime: setTime(DateTime.now().add(const Duration(days: 1)), 19, 15),
    status: QuestStatus.pending,
  ),
];

final dummySideQuests = [
  SideQuest(
    name: 'Read a Book',
    questCategory: questCategories.firstWhere((q) => q.name == 'Learning'),
    repeatDays: {.monday, .tuesday, .wednesday, .thursday, .friday},
  ),
  SideQuest(
    name: 'Care for Plants',
    questCategory: questCategories.firstWhere((q) => q.name == 'Chores'),
    repeatDays: {.monday, .thursday},
  ),
  SideQuest(
    name: 'Tidy Desk',
    questCategory: questCategories.firstWhere((q) => q.name == 'Chores'),
    repeatDays: {.saturday, .sunday},
  ),
  SideQuest(
    name: 'Gym',
    questCategory: questCategories.firstWhere((q) => q.name == 'Fitness'),
    repeatDays: {},
  ),
];

final dummyMainQuests = [
  MainQuest(
    name: 'Launch Product Sprint',
    questCategory: questCategories.firstWhere((q) => q.name == 'Work'),
    durationMin: 150,
    subTasks: ['Define goals', 'Prioritize tasks', 'Ship MVP'],
    dueDate: DateTime(2026, 8, 22),
    priority: .high,
  ),
  MainQuest(
    name: 'Weekend Reset',
    questCategory: questCategories.firstWhere((q) => q.name == 'Chores'),
    durationMin: 90,
    subTasks: ['Laundry', 'Vacuum', 'Meal prep'],
    dueDate: DateTime(2026, 8, 23),
    priority: .low,
  ),
  MainQuest(
    name: 'Marathon Training',
    questCategory: questCategories.firstWhere((q) => q.name == 'Fitness'),
    durationMin: 85,
    subTasks: ['Warm-up', 'Run intervals', 'Stretch'],
    dueDate: DateTime(2026, 8, 25),
    priority: .high,
  ),
  MainQuest(
    name: 'Reading Streak',
    questCategory: questCategories.firstWhere((q) => q.name == 'Learning'),
    durationMin: 45,
    subTasks: ['Read chapter', 'Take notes', 'Summarize insights'],
    dueDate: DateTime(2026, 8, 21),
    priority: .medium,
  ),
  MainQuest(
    name: 'Health Check-In',
    questCategory: questCategories.firstWhere((q) => q.name == 'Health'),
    durationMin: 30,
    subTasks: ['Drink water', 'Go for a walk', 'Eat Fruit', 'Plan sleep'],
    dueDate: DateTime(2026, 8, 20),
    priority: .low,
  ),
];
