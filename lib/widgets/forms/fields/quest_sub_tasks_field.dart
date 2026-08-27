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
      spacing: 5,
      children: [
        Expanded(
          child: isEditing
              ? GestureDetector(
                  onTap: () => _editFocusNode.requestFocus(),
                  child: Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      onFieldSubmitted: (_) => _saveEdit(index),
                      cursorColor: QuestLogColors.textSecondary,
                      style: GoogleFonts.jetBrainsMono(fontSize: 14),
                      decoration: const InputDecoration(
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
                    height: 50,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: QuestLogColors.border,
                      ),
                    ),
                    child: Text(
                      item,
                      style: GoogleFonts.jetBrainsMono(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline, size: 20),
          color: QuestLogColors.textSecondary,
          onPressed: () => _deleteItem(index),
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
        height: 50,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
          maxLength: 30,
          cursorColor: QuestLogColors.textSecondary,
          style: GoogleFonts.jetBrainsMono(fontSize: 14),
          decoration: InputDecoration(
            counterText: '',
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: 'Module Title...',
            hintStyle: GoogleFonts.jetBrainsMono(
              color: QuestLogColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
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
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: QuestLogColors.accent),
                ),
                child: Row(
                  spacing: 5,
                  children: [
                    const Icon(
                      Icons.add,
                      color: QuestLogColors.accent,
                      size: 14,
                    ),
                    Text(
                      'ADD TASK',
                      style: GoogleFonts.jetBrainsMono(
                        color: QuestLogColors.accent,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        for (int i = 0; i < widget.items.length; i++)
          _buildSavedItem(i, widget.items[i]),

        _buildNewSubTaskInputField(),
      ],
    );
  }
}
