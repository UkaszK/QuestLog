import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/assembler_main_quest.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/forms/fields/form_submit_button.dart';
import 'package:questlog/widgets/forms/fields/quest_sub_tasks_field.dart';
import 'package:questlog/widgets/forms/fields/quest_title_input_field.dart';

typedef AssemblerQuestDetails = ({String name, List<SubTask> subTasks});

/// Opens a modal sheet to edit name and sub tasks of a scheduled quest.
/// Resolves with the edited details, or null if dismissed without saving.
Future<AssemblerQuestDetails?> showEditAssemblerQuestSheet(
  BuildContext context,
  AssemblerMainQuest quest,
) {
  return showModalBottomSheet<AssemblerQuestDetails>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => EditAssemblerQuestSheet(quest: quest),
  );
}

class EditAssemblerQuestSheet extends StatefulWidget {
  const EditAssemblerQuestSheet({super.key, required this.quest});

  final AssemblerMainQuest quest;

  @override
  State<EditAssemblerQuestSheet> createState() =>
      _EditAssemblerQuestSheetState();
}

class _EditAssemblerQuestSheetState extends State<EditAssemblerQuestSheet> {
  final _titleController = TextEditingController();
  late List<SubTask> _subTasks;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.quest.name;
    _titleController.addListener(_onTitleChanged);
    _subTasks = List.of(widget.quest.subTasks);
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

  void _handleSubmit() {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(
      context,
    ).pop((name: _titleController.text.trim(), subTasks: _subTasks));
  }

  Widget _buildSubTaskLeading(SubTask subTask) {
    return Icon(
      subTask.completed ? Icons.check_circle : Icons.chevron_right,
      size: 20,
      color: subTask.completed ? QuestLogColors.success : QuestLogColors.accent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitDisabled = _titleController.text.trim().isEmpty;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Container(
          decoration: BoxDecoration(
            color: QuestLogColors.surface,
            border: const Border(
              top: BorderSide(width: 1, color: QuestLogColors.accent),
            ),
            boxShadow: [
              BoxShadow(
                color: QuestLogColors.accent.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.edit_outlined,
                            size: 16,
                            color: QuestLogColors.accent,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'EDIT QUEST',
                            style: GoogleFonts.jetBrainsMono(
                              color: QuestLogColors.accent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: QuestLogColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const Divider(height: 1),

                  const SizedBox(height: 16),

                  QuestTitleInputField(controller: _titleController),

                  const SizedBox(height: 20),

                  QuestSubTasksField<SubTask>(
                    items: _subTasks,
                    onChange: (subTasks) =>
                        setState(() => _subTasks = subTasks),
                    labelOf: (subTask) => subTask.name,
                    create: (text) => SubTask(name: text),
                    rename: (subTask, text) =>
                        SubTask(name: text, completed: subTask.completed),
                    leadingBuilder: _buildSubTaskLeading,
                  ),

                  const SizedBox(height: 20),

                  FormSubmitButton(
                    onSubmit: _handleSubmit,
                    disabled: isSubmitDisabled,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
