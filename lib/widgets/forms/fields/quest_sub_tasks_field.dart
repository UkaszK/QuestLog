import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/questlog_colors.dart';

class QuestSubTasksField extends StatefulWidget {
  const QuestSubTasksField({
    super.key,
    required this.items,
    required this.onChange,
  });

  final List<String> items;
  final void Function(List<String>) onChange;

  @override
  State<StatefulWidget> createState() => _QuestSubTasksFieldState();
}

class _QuestSubTasksFieldState extends State<QuestSubTasksField> {
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _editController = TextEditingController();

  final FocusNode _newFocusNode = FocusNode();
  final FocusNode _editFocusNode = FocusNode();

  int? _editingIndex;
  bool _newFocused = false;

  final double subTaskFieldHeight = 40;

  @override
  void initState() {
    super.initState();

    _newFocusNode.addListener(() {
      setState(() {
        _newFocused = _newFocusNode.hasFocus;
      });
      if (!_newFocusNode.hasFocus) {
        _trySaveNew();
      }
    });

    _editFocusNode.addListener(() {
      setState(() {});
      if (!_editFocusNode.hasFocus && _editingIndex != null) {
        _saveEdit(_editingIndex!);
      }
    });
  }

  @override
  void dispose() {
    _newController.dispose();
    _editController.dispose();
    _newFocusNode.dispose();
    _editFocusNode.dispose();
    super.dispose();
  }

  void _trySaveNew() {
    final text = _newController.text.trim();
    if (text.isNotEmpty) {
      List<String> updated = [...widget.items, text];
      widget.onChange(updated);
      _newController.clear();
    }
  }

  void _saveEdit(int index) {
    if (_editingIndex != index) return;

    final text = _editController.text.trim();
    List<String> updated = List.from(widget.items);

    if (text.isNotEmpty) {
      updated[index] = text;
    } else {
      updated.removeAt(index);
    }

    widget.onChange(updated);

    setState(() {
      _editingIndex = null;
    });
  }

  void _deleteItem(int index) {
    List<String> updated = List.from(widget.items);
    updated.removeAt(index);
    widget.onChange(updated);

    if (_editingIndex == index) {
      setState(() {
        _editingIndex = null;
      });
    }
  }

  Widget _buildSavedItem(int index, String item) {
    final isEditing = _editingIndex == index;

    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Icon(
            Icons.chevron_right,
            size: 20,
            color: QuestLogColors.accent,
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: isEditing
              ? GestureDetector(
                  onTap: () => _editFocusNode.requestFocus(),
                  child: Container(
                    height: subTaskFieldHeight,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: _editFocusNode.hasFocus
                            ? QuestLogColors.accent
                            : QuestLogColors.border,
                      ),
                    ),
                    child: TextFormField(
                      controller: _editController,
                      focusNode: _editFocusNode,
                      autocorrect: false,
                      maxLength: 30,
                      onFieldSubmitted: (_) => _saveEdit(index),
                      cursorColor: QuestLogColors.textSecondary,
                      style: GoogleFonts.jetBrainsMono(fontSize: 12),
                      decoration: const InputDecoration(
                        counterText: '',
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    setState(() {
                      _editingIndex = index;
                      _editController.text = item;
                    });
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _editFocusNode.requestFocus();
                    });
                  },
                  child: Container(
                    height: subTaskFieldHeight,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: QuestLogColors.border,
                      ),
                    ),
                    child: Text(
                      item,
                      style: GoogleFonts.jetBrainsMono(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
        ),

        const SizedBox(width: 8),

        SizedBox(
          width: 24,
          height: 24,
          child: InkWell(
            onTap: () => _deleteItem(index),
            child: const Icon(
              Icons.delete_outline,
              size: 20,
              color: QuestLogColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewSubTaskInputField() {
    return GestureDetector(
      onTap: () {
        _newFocusNode.requestFocus();
      },
      child: Container(
        height: subTaskFieldHeight,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: _newFocused ? QuestLogColors.accent : QuestLogColors.border,
          ),
        ),
        child: TextFormField(
          controller: _newController,
          focusNode: _newFocusNode,
          autocorrect: false,
          onFieldSubmitted: (_) => _trySaveNew(),
          maxLength: 25,
          cursorColor: QuestLogColors.textSecondary,
          style: GoogleFonts.jetBrainsMono(fontSize: 12),
          decoration: InputDecoration(
            counterText: '',
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: 'Sub-task description...',
            hintStyle: GoogleFonts.jetBrainsMono(
              color: QuestLogColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SUB-TASKS (Optional)',
              style: GoogleFonts.jetBrainsMono(
                color: QuestLogColors.accent,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () => _trySaveNew(),
              child: Row(
                spacing: 5,
                children: [
                  const Icon(Icons.add, color: QuestLogColors.accent, size: 14),
                  Text(
                    'ADD TASK',
                    style: GoogleFonts.jetBrainsMono(
                      color: QuestLogColors.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        for (int i = 0; i < widget.items.length; i++) ...[
          _buildSavedItem(i, widget.items[i]),
          const SizedBox(height: 12),
        ],

        _buildNewSubTaskInputField(),
      ],
    );
  }
}
