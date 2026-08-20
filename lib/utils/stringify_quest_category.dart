import 'package:questlog/data/quest_category.dart';

String stringifyQuestCategory(QuestCategory questCategory) {
  return switch (questCategory) {
    .chores => 'Chores',
    .creative => 'Creative',
    .errands => 'Errands',
    .finance => 'Finance',
    .fitness => 'Fitness',
    .health => 'Health',
    .learning => 'Learning',
    .other => 'Other',
    .personal => 'Personal',
    .social => 'Social',
    .travel => 'Travel',
    .work => 'Work',
  };
}
