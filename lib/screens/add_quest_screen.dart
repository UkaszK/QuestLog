import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/quest_type.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/theme/questlog_text_styles.dart';
import 'package:questlog/widgets/forms/main_quest_form.dart';
import 'package:questlog/widgets/forms/side_quest_form.dart';
import 'package:questlog/widgets/questlog_app_bar.dart';

class AddQuestScreen extends StatefulWidget {
  const AddQuestScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddQuestScreenState();
}

class _AddQuestScreenState extends State<AddQuestScreen> {
  QuestType _selectedQuestType = QuestType.main;

  Widget _buildQuestClassificationSwitch() {
    Widget buildSwitchButton({
      required String label,
      required isSelected,
      required void Function() onTap,
    }) {
      Color labelColor = isSelected
          ? QuestLogColors.accent
          : QuestLogColors.textSecondary;

      return Expanded(
        child: Padding(
          padding: EdgeInsetsGeometry.all(3),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: isSelected
                    ? QuestLogColors.textPrimary.withValues(alpha: 0.1)
                    : Colors.transparent,
              ),
              child: Text(
                label,
                style: GoogleFonts.jetBrainsMono(
                  color: labelColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text('Quest Classification', style: QuestLogTextStyles.headerText),

        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: QuestLogColors.border),
          ),
          child: Row(
            children: [
              buildSwitchButton(
                label: 'Main Quest',
                isSelected: _selectedQuestType == QuestType.main,
                onTap: () {
                  setState(() => _selectedQuestType = QuestType.main);
                },
              ),
              buildSwitchButton(
                label: 'Side Quest',
                isSelected: _selectedQuestType == QuestType.side,
                onTap: () {
                  setState(() => _selectedQuestType = QuestType.side);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget selectedForm = _selectedQuestType == QuestType.main
        ? MainQuestForm()
        : SideQuestForm();

    return Scaffold(
      appBar: QuestLogAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 15,
          children: [_buildQuestClassificationSwitch(), selectedForm],
        ),
      ),
    );
  }
}
