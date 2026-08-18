import 'package:flutter/material.dart';
import 'package:questlog/data/quest.dart';

const dailyAssemblerQuests = [
  Quest(
    icon: Icons.sunny_snowing,
    startTime: '06:00',
    endTime: '08:00',
    name: 'Morning Routine',
    status: QuestStatus.completed,
  ),
  Quest(
    icon: Icons.coffee,
    startTime: '08:30',
    endTime: '09:00',
    name: 'Breakfast',
    status: QuestStatus.active,
  ),
  Quest(
    icon: Icons.work,
    startTime: '09:00',
    endTime: '12:00',
    name: 'Work Session',
    status: QuestStatus.pending,
  ),
  Quest(
    icon: Icons.fitness_center,
    startTime: '18:00',
    endTime: '19:00',
    name: 'Workout',
    status: QuestStatus.pending,
  ),
  Quest(
    icon: Icons.nights_stay,
    startTime: '22:00',
    endTime: '23:30',
    name: 'Wind Down',
    status: QuestStatus.pending,
  ),
];
