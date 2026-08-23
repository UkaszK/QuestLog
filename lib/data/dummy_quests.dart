import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/assembler_quest.dart';
import 'package:questlog/data/quest_info.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/utils/set_time.dart';

final dailyAssemblerQuests = [
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Plan Weekly Goals',
      questCategory: .learning,
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
      questCategory: .chores,
      subTasks: [],
    ),
    startTime: setTime(DateTime.now().subtract(Duration(days: 1)), 16, 0),
    endTime: setTime(DateTime.now().subtract(Duration(days: 1)), 17, 0),
    status: QuestStatus.completed,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Morning Routine',
      questCategory: .personal,
      subTasks: [],
    ),
    startTime: setTime(DateTime.now(), 7, 0),
    endTime: setTime(DateTime.now(), 8, 0),
    status: QuestStatus.completed,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(name: 'Deep Work', questCategory: .work, subTasks: []),
    startTime: setTime(DateTime.now(), 8, 0),
    endTime: setTime(DateTime.now(), 12, 0),
    status: QuestStatus.pending,
  ),
  AssemblerQuest(
    questInfo: QuestInfo(
      name: 'Workout',
      questCategory: .fitness,
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
      questCategory: .work,
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
      questCategory: .health,
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
      questCategory: .work,
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
      questCategory: .fitness,
      subTasks: [],
    ),
    startTime: setTime(DateTime.now().add(const Duration(days: 1)), 18, 30),
    endTime: setTime(DateTime.now().add(const Duration(days: 1)), 19, 15),
    status: QuestStatus.pending,
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
    subTasks: [
      (name: 'Define goals', completed: true),
      (name: 'Prioritize tasks', completed: true),
      (name: 'Ship MVP', completed: false),
    ],
    dueDate: DateTime(2026, 8, 22),
    priority: .high,
  ),
  MainQuest(
    name: 'Weekend Reset',
    questCategory: .chores,
    durationMin: 90,
    subTasks: [
      (name: 'Laundry', completed: true),
      (name: 'Vacuum', completed: false),
      (name: 'Meal prep', completed: false),
    ],
    dueDate: DateTime(2026, 8, 23),
    priority: .low,
  ),
  MainQuest(
    name: 'Marathon Training',
    questCategory: .fitness,
    durationMin: 85,
    subTasks: [
      (name: 'Warm-up', completed: true),
      (name: 'Run intervals', completed: false),
      (name: 'Stretch', completed: false),
    ],
    dueDate: DateTime(2026, 8, 25),
    priority: .high,
  ),
  MainQuest(
    name: 'Reading Streak',
    questCategory: .learning,
    durationMin: 45,
    subTasks: [
      (name: 'Read chapter', completed: true),
      (name: 'Take notes', completed: false),
      (name: 'Summarize insights', completed: false),
    ],
    dueDate: DateTime(2026, 8, 21),
    priority: .medium,
  ),
  MainQuest(
    name: 'Health Check-In',
    questCategory: .health,
    durationMin: 30,
    subTasks: [
      (name: 'Drink water', completed: true),
      (name: 'Go for a walk', completed: false),
      (name: 'Plan sleep', completed: false),
    ],
    dueDate: DateTime(2026, 8, 20),
    priority: .low,
  ),
];
