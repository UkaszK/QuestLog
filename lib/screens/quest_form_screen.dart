import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/quest_type.dart';
import 'package:questlog/providers/quest_form_providers.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/forms/fields/quest_log_switch.dart';
import 'package:questlog/widgets/forms/main_quest_form.dart';
import 'package:questlog/widgets/forms/side_quest_form.dart';
import 'package:questlog/widgets/reusables/quest_log_new_screen_container.dart';

class QuestFormScreen extends ConsumerStatefulWidget {
  const QuestFormScreen({super.key});

  @override
  ConsumerState<QuestFormScreen> createState() => _QuestFormScreenState();
}

class _QuestFormScreenState extends ConsumerState<QuestFormScreen> {
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

        QuestLogSwitch<QuestType>(
          options: [
            QuestLogSwitchOption(label: 'MAIN QUEST', value: QuestType.main),
            QuestLogSwitchOption(
              label: 'SIDE QUEST',
              value: QuestType.side,
              primaryColor: QuestLogColors.otherAccent,
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
    final notifier = ref.read(questFormNotifierProvider.notifier);

    Widget selectedForm = _selectedQuestType == QuestType.main
        ? MainQuestForm(onSubmit: notifier.submitMainQuest)
        : SideQuestForm(onSubmit: notifier.submitSideQuest);

    return QuestLogNewScreenContainer(
      children: [
        _buildQuestClassificationSwitch(),
        Divider(height: 32),
        selectedForm,
      ],
    );
  }
}
