import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/quest_type.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/forms/fields/questlog_switch.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUEST CLASSIFICATION',
          style: GoogleFonts.jetBrainsMono(
            color: QuestLogColors.textSecondary,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 8),

        QuestlogSwitch<QuestType>(
          options: [
            QuestLogSwitchOption(label: 'MAIN QUEST', value: QuestType.main),
            QuestLogSwitchOption(
              label: 'SIDE QUEST',
              value: QuestType.side,
              configurations: QuestLogSwitchOptionConfiguration(
                selectedColor: QuestLogColors.otherAccent,
              ),
            ),
          ],
          selection: _selectedQuestType,
          onChange: (value) => setState(() {
            _selectedQuestType = value;
          }),
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
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 96),
          child: Column(
            spacing: 15,
            children: [
              _buildQuestClassificationSwitch(),
              Divider(height: 10),
              selectedForm,
            ],
          ),
        ),
      ),
    );
  }
}
