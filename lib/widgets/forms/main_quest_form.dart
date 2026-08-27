import 'package:flutter/material.dart';
import 'package:questlog/data/dummy_data.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/data/quest_priority.dart';
import 'package:questlog/widgets/forms/fields/form_category_selector.dart';
import 'package:questlog/widgets/forms/fields/quest_due_date_field.dart';
import 'package:questlog/widgets/forms/fields/quest_duration_field.dart';
import 'package:questlog/widgets/forms/fields/quest_notes_input_field.dart';
import 'package:questlog/widgets/forms/fields/quest_priority_selector.dart';
import 'package:questlog/widgets/forms/fields/quest_sub_tasks_field.dart';
import 'package:questlog/widgets/forms/fields/quest_title_input_field.dart';

class MainQuestForm extends StatefulWidget {
  const MainQuestForm({super.key});

  @override
  State<StatefulWidget> createState() => _MainQuestFormState();
}

class _MainQuestFormState extends State<MainQuestForm> {
  // Form
  QuestCategory _questCategory = questCategories.first;
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime? _dueDate;
  final _durationController = TextEditingController();
  QuestPriority _questPriority = QuestPriority.medium;
  List<String> _subTasks = [];

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final category = _questCategory;
    final title = _titleController.text;
    final notes = _notesController.text;
    final dueDate = _dueDate.toString();
    final duration = _durationController.text;
    final priority = _questPriority;
    final subTasks = _subTasks.join(', ');
    debugPrint(
      '$category | $title | $notes | $dueDate | $duration | $priority | $subTasks',
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        child: Column(
          spacing: 15,
          children: [
            FormCategorySelector(
              questCategories: questCategories,
              selection: _questCategory,
              onChange: (questCategory) =>
                  setState(() => _questCategory = questCategory),
            ),

            QuestTitleInputField(controller: _titleController),

            QuestNotesInputField(controller: _notesController),

            QuestDueDateField(
              selectedDate: _dueDate,
              onChange: (date) => setState(() => _dueDate = date),
            ),

            QuestDurationField(controller: _durationController),

            QuestPrioritySelector(
              questPriorities: QuestPriority.values,
              selection: _questPriority,
              onChange: (priority) => setState(() => _questPriority = priority),
            ),

            Divider(height: 20),

            QuestSubTasksField(
              items: _subTasks,
              onChange: (subTasks) => setState(() => _subTasks = subTasks),
            ),

            TextButton(
              onPressed: () => _submitForm(),
              child: Text('Test Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
