import 'package:flutter/material.dart';
import 'package:questlog/data/quest.dart';

const dailyAssemblerQuests = [
  Quest(
    icon: Icons.sunny_snowing,
    startTime: '06:00',
    endTime: '07:00',
    name: 'Morning Routine',
    status: QuestStatus.completed,
  ),
  Quest(
    icon: Icons.work,
    startTime: '08:00',
    endTime: '12:00',
    name: 'Work Session',
    status: QuestStatus.pending,
  ),
  Quest(
    icon: Icons.fitness_center,
    startTime: '12:30',
    endTime: '15:00',
    name: 'Workout',
    status: QuestStatus.active,
  ),
  Quest(
    icon: Icons.laptop,
    startTime: '18:00',
    endTime: '19:00',
    name: 'Meeting',
    status: QuestStatus.open,
  ),
  Quest(
    icon: Icons.nights_stay,
    startTime: '22:00',
    endTime: '22:30',
    name: 'Evening Routine',
    status: QuestStatus.open,
  ),
];
