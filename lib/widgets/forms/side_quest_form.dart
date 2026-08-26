import 'package:flutter/material.dart';
import 'package:questlog/data/dummy_data.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/widgets/forms/fields/form_category_selector.dart';

class SideQuestForm extends StatefulWidget {
  const SideQuestForm({super.key});

  @override
  State<StatefulWidget> createState() => _SideQuestFormState();
}

class _SideQuestFormState extends State<SideQuestForm> {
  // Form
  QuestCategory _selectedCategory = questCategories.first;
  void _setSelectedCategory(QuestCategory newCategory) =>
      setState(() => _selectedCategory = newCategory);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        spacing: 15,
        children: [
          FormCategorySelector(
            questCategories: questCategories,
            selection: _selectedCategory,
            onChange: _setSelectedCategory,
          ),
        ],
      ),
    );
  }
}
