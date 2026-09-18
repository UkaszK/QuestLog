import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:questlog/providers/dashboard_providers.dart';
import 'package:questlog/theme/quest_log_colors.dart';
import 'package:questlog/widgets/dashboard_screen/daily_progress/dashboard_daily_progress.dart';
import 'package:questlog/widgets/dashboard_screen/scheduled_main_quests/assembler_main_quests.dart';
import 'package:questlog/widgets/dashboard_screen/side_quests/side_quests.dart';
import 'package:questlog/widgets/quest_log_loading_screen.dart';
import 'package:questlog/widgets/reusables/quest_log_screen_container.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  Future<void> _selectDate(
    BuildContext context,
    DateTime selectedDay,
    void Function(DateTime) onChange,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDay,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: QuestLogColors.accent,
              onPrimary: Colors.black,
              surface: Colors.black,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onChange(picked);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(dashboardViewStateNotifierProvider.notifier);
    final dashboardViewState = ref.watch(dashboardViewStateNotifierProvider);
    final selectedDay = dashboardViewState.selectedDay;
    final dashboardStateAsync = ref.watch(dashboardStateProvider(selectedDay));

    return dashboardStateAsync.when(
      data: (state) {
        return QuestLogScreenContainer(
          spacing: 25,
          children: [
            _Header(
              selectedDay: selectedDay,
              leftAction: () => notifier.shiftDay(-1),
              rightAction: () => notifier.shiftDay(1),
              onClickDate: () =>
                  _selectDate(context, selectedDay, notifier.setDay),
            ),

            DashboardDailyProgress(progress: state.progress),

            AssemblerMainQuests(
              assemblerMainQuests: state.assemblerMainQuests,
              onCheckAssemblerMainQuest: notifier.checkAssemblerMainQuest,
              onCheckSubTask: notifier.checkSubTask,
            ),

            SideQuests(
              sideQuests: state.sideQuests,
              completedSideQuestIds: state.completedSideQuestIds,
              onCheckSideQuest: (sideQuest, newValue) =>
                  notifier.checkSideQuest(
                    sideQuest,
                    newValue,
                    state.assemblerSideQuests,
                  ),
            ),
          ],
        );
      },
      error: (error, stack) => Center(child: Text('Error loading: $error')),
      loading: () => QuestLogLoadingScreen(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.selectedDay,
    required this.leftAction,
    required this.rightAction,
    required this.onClickDate,
  });

  final DateTime selectedDay;
  final VoidCallback leftAction;
  final VoidCallback rightAction;
  final VoidCallback onClickDate;

  static final _dayFormat = DateFormat('EEE, d MMM');

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DASHBOARD',
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'DAILY OVERVIEW',
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            _DayNavButton(icon: Icons.chevron_left, onTap: leftAction),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onClickDate,
              child: Text(
                _dayFormat.format(selectedDay).toUpperCase(),
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            _DayNavButton(icon: Icons.chevron_right, onTap: rightAction),
          ],
        ),
      ],
    );
  }
}

class _DayNavButton extends StatelessWidget {
  const _DayNavButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 20,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: QuestLogColors.border, width: 1),
        ),
        child: Icon(icon, size: 14, color: QuestLogColors.textSecondary),
      ),
    );
  }
}
