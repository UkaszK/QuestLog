import 'package:flutter/material.dart';
import 'package:questlog/data/quest_category.dart';

IconData getQuestCategoryIcon(QuestCategory questCategory) {
  return switch (questCategory) {
    .chores => Icons.cleaning_services,
    .creative => Icons.palette,
    .errands => Icons.local_grocery_store,
    .finance => Icons.account_balance_wallet,
    .fitness => Icons.fitness_center,
    .health => Icons.favorite,
    .learning => Icons.menu_book,
    .other => Icons.category,
    .personal => Icons.person,
    .social => Icons.group,
    .travel => Icons.flight,
    .work => Icons.work,
  };
}
