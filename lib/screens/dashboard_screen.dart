import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/providers/dashboard_providers.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/dashboard_screen/daily_progress/dashboard_daily_progress.dart';
import 'package:questlog/widgets/dashboard_screen/scheduled_main_quests/assembler_main_quests.dart';
import 'package:questlog/widgets/dashboard_screen/side_quests/side_quests.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(dashboardNotifierProvider.notifier);

    final dashboardStateAsync = ref.watch(
      dashboardStateProvider(DateTime.now()),
    );

    return dashboardStateAsync.when(
      data: (state) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 150),
          child: Column(
            spacing: 25,
            children: [
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
          ),
        );
      },
      error: (_, _) => CircularProgressIndicator(color: QuestLogColors.accent),
      loading: () => CircularProgressIndicator(color: QuestLogColors.accent),
    );
  }
}
