import 'package:flutter/material.dart';
import 'package:questlog/data/dummy_data.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/widgets/forms/fields/form_category_selector.dart';
import 'package:questlog/widgets/forms/fields/quest_duration_field.dart';
import 'package:questlog/widgets/forms/fields/quest_notes_input_field.dart';
import 'package:questlog/widgets/forms/fields/quest_title_input_field.dart';

class MainQuestForm extends StatefulWidget {
  const MainQuestForm({super.key});

  @override
  State<StatefulWidget> createState() => _MainQuestFormState();
}

class _MainQuestFormState extends State<MainQuestForm> {
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  final _durationController = TextEditingController();

  QuestCategory _selectedCategory = questCategories.first;

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final title = _titleController.text;
    final notes = _notesController.text;
    final category = _selectedCategory;
    debugPrint('$title | $notes | $category');
  }

  // Form
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

          QuestTitleInputField(controller: _titleController),

          QuestNotesInputField(controller: _notesController),

          QuestDurationField(controller: _durationController),

          TextButton(
            onPressed: () => _submitForm(),
            child: Text('Test Submit'),
          ),
        ],
      ),
    );
  }
}
