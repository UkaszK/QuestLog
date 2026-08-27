import 'package:flutter/material.dart';
import 'package:questlog/data/dummy_data.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/data/quest_priority.dart';
import 'package:questlog/widgets/forms/fields/form_category_selector.dart';
import 'package:questlog/widgets/forms/fields/quest_duration_field.dart';
import 'package:questlog/widgets/forms/fields/quest_notes_input_field.dart';
import 'package:questlog/widgets/forms/fields/quest_priority_selector.dart';
import 'package:questlog/widgets/forms/fields/quest_title_input_field.dart';

class MainQuestForm extends StatefulWidget {
  const MainQuestForm({super.key});

  @override
  State<StatefulWidget> createState() => _MainQuestFormState();
}

class _MainQuestFormState extends State<MainQuestForm> {
  // Form
  QuestCategory _selectedCategory = questCategories.first;
  void _setSelectedCategory(QuestCategory newCategory) =>
      setState(() => _selectedCategory = newCategory);
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  final _durationController = TextEditingController();
  QuestPriority _selectedPriority = QuestPriority.medium;
  void _setSelectedPriority(QuestPriority newPriority) =>
      setState(() => _selectedPriority = newPriority);

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final category = _selectedCategory;
    final title = _titleController.text;
    final notes = _notesController.text;
    final duration = _durationController.text;
    final priority = _selectedPriority;
    debugPrint('$category | $title | $notes | $duration | $priority');
  }

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

          QuestPrioritySelector(
            questPriorities: QuestPriority.values,
            selection: _selectedPriority,
            onChange: _setSelectedPriority,
          ),

          TextButton(
            onPressed: () => _submitForm(),
            child: Text('Test Submit'),
          ),
        ],
      ),
    );
  }
}
