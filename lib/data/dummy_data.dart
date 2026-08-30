import 'package:flutter/material.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/data/quest_info.dart';
import 'package:questlog/data/side_quest.dart';

DateTime _setTime(DateTime date, int hour, int minute) {
  return DateTime(date.year, date.month, date.day, hour, minute);
}

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
    startTime: _setTime(DateTime.now().subtract(const Duration(days: 1)), 9, 0),
    endTime: _setTime(DateTime.now().subtract(const Duration(days: 1)), 10, 30),
    status: QuestStatus.completed,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Grocery Shopping',
      questCategory: questCategories.firstWhere((q) => q.name == 'Chores'),
      subTasks: [],
    ),
    startTime: _setTime(DateTime.now().subtract(Duration(days: 1)), 16, 0),
    endTime: _setTime(DateTime.now().subtract(Duration(days: 1)), 17, 0),
    status: QuestStatus.completed,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Morning Routine',
      questCategory: questCategories.firstWhere((q) => q.name == 'Personal'),
      subTasks: [],
    ),
    startTime: _setTime(DateTime.now(), 7, 0),
    endTime: _setTime(DateTime.now(), 8, 0),
    status: QuestStatus.completed,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Deep Work',
      questCategory: questCategories.firstWhere((q) => q.name == 'Work'),
      subTasks: [],
    ),
    startTime: _setTime(DateTime.now(), 8, 0),
    endTime: _setTime(DateTime.now(), 12, 0),
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
    startTime: _setTime(DateTime.now(), 12, 30),
    endTime: _setTime(DateTime.now(), 15, 0),
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
    startTime: _setTime(DateTime.now(), 18, 0),
    endTime: _setTime(DateTime.now(), 19, 0),
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
    startTime: _setTime(DateTime.now(), 22, 0),
    endTime: _setTime(DateTime.now(), 22, 30),
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
    startTime: _setTime(DateTime.now().add(const Duration(days: 1)), 9, 30),
    endTime: _setTime(DateTime.now().add(const Duration(days: 1)), 11, 0),
    status: QuestStatus.open,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Evening Walk',
      questCategory: questCategories.firstWhere((q) => q.name == 'Fitness'),
      subTasks: [],
    ),
    startTime: _setTime(DateTime.now().add(const Duration(days: 1)), 18, 30),
    endTime: _setTime(DateTime.now().add(const Duration(days: 1)), 19, 15),
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
    name: 'Work',
    questCategory: questCategories.firstWhere((q) => q.name == 'Work'),
    subTasks: [],
    priority: .normal,
  ),
  MainQuest(
    name: 'Launch Product Sprint',
    questCategory: questCategories.firstWhere((q) => q.name == 'Work'),
    subTasks: ['Define goals', 'Prioritize tasks', 'Ship MVP'],
    dueDate: _setTime(DateTime.now(), 0, 0),
    priority: .high,
  ),
  MainQuest(
    name: 'Weekend Reset',
    questCategory: questCategories.firstWhere((q) => q.name == 'Chores'),
    subTasks: ['Laundry', 'Vacuum', 'Meal prep'],
    dueDate: _setTime(DateTime.now().add(Duration(days: 2)), 0, 0),
    priority: .low,
  ),
  MainQuest(
    name: 'Marathon Training',
    questCategory: questCategories.firstWhere((q) => q.name == 'Fitness'),
    subTasks: ['Warm-up', 'Run intervals', 'Stretch'],
    dueDate: _setTime(DateTime.now().subtract(Duration(days: 2)), 0, 0),
    priority: .high,
  ),
  MainQuest(
    name: 'Reading Streak',
    questCategory: questCategories.firstWhere((q) => q.name == 'Learning'),
    subTasks: ['Read chapter', 'Take notes', 'Summarize insights'],
    dueDate: _setTime(DateTime.now().subtract(Duration(days: 1)), 0, 0),
    priority: .normal,
  ),
  MainQuest(
    name: 'Health Check-In',
    questCategory: questCategories.firstWhere((q) => q.name == 'Health'),
    subTasks: ['Drink water', 'Go for a walk', 'Eat Fruit', 'Plan sleep'],
    dueDate: _setTime(DateTime.now().add(Duration(days: 1)), 0, 0),
    priority: .low,
  ),
];
