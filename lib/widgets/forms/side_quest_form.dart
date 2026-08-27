import 'package:flutter/material.dart';
import 'package:questlog/data/day.dart';
import 'package:questlog/data/dummy_data.dart';
import 'package:questlog/data/quest_category.dart';
import 'package:questlog/widgets/forms/fields/form_category_selector.dart';
import 'package:questlog/widgets/forms/fields/form_day_selector.dart';
import 'package:questlog/widgets/forms/fields/form_submit_button.dart';
import 'package:questlog/widgets/forms/fields/quest_title_input_field.dart';

class SideQuestForm extends StatefulWidget {
  const SideQuestForm({super.key});

  @override
  State<StatefulWidget> createState() => _SideQuestFormState();
}

class _SideQuestFormState extends State<SideQuestForm> {
  // Form
  QuestCategory _questCategory = questCategories.first;
  final _titleController = TextEditingController();
  Set<Day> _repeatDays = {};

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
    final category = _questCategory;
    final title = _titleController.text;
    final repeatDays = _repeatDays;
    debugPrint('$category | $title | ${repeatDays.join(', ')}');
  }

  @override
  Widget build(BuildContext context) {
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

          FormDaySelector(
            weekdays: Day.values.toSet(),
            selection: _repeatDays,
            onChange: (repeatDays) => setState(() => _repeatDays = repeatDays),
          ),

          FormSubmitButton(
            onSubmit: _submitForm,
            disabled: _titleController.text.isEmpty,
          ),
        ],
      ),
    );
  }
}
