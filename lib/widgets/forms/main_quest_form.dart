import 'package:flutter/material.dart';
import 'package:questlog/data/dummy_data.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/data/quest_priority.dart';
import 'package:questlog/widgets/forms/fields/form_category_selector.dart';
import 'package:questlog/widgets/forms/fields/form_submit_button.dart';
import 'package:questlog/widgets/forms/fields/quest_due_date_field.dart';
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
  DateTime? _dueDate;
  QuestPriority _questPriority = QuestPriority.normal;
  List<String> _subTasks = [];

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_onTitleChanged);
  }

  void _onTitleChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _titleController.removeListener(_onTitleChanged);
    _titleController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final newMainQuest = MainQuest(
      name: _titleController.text.trim(),
      questCategory: _questCategory,
      dueDate: _dueDate,
      priority: _questPriority,
      subTasks: _subTasks,
    );

    setState(() {
      dummyMainQuests.add(newMainQuest);
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitDisabled = _titleController.text.isEmpty;

    return Form(
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

          QuestDueDateField(
            selectedDate: _dueDate,
            onChange: (date) => setState(() => _dueDate = date),
          ),

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

          FormSubmitButton(onSubmit: _submitForm, disabled: isSubmitDisabled),
        ],
      ),
    );
  }
}
