import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/day.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/providers/assembler_providers.dart';
import 'package:questlog/providers/backlog_providers.dart';
import 'package:questlog/providers/navigation_bar_providers.dart';
import 'package:questlog/theme/questlog_colors.dart';
import 'package:questlog/widgets/quest_log_loading_screen.dart';
import 'package:questlog/widgets/reusables/quest_log_badge.dart';
import 'package:questlog/widgets/reusables/quest_log_button.dart';
import 'package:questlog/widgets/reusables/quest_log_screen_container.dart';
import 'package:questlog/widgets/reusables/quest_log_section_header.dart';

class BacklogScreen extends ConsumerWidget {
  const BacklogScreen({super.key});

  Future<void> _dialogBuilder(
    BuildContext context,
    Object quest,
    VoidCallback onDelete,
  ) async {
    String name;
    if (quest is! MainQuest && quest is! SideQuest) return;
    if (quest is MainQuest) {
      name = quest.name;
    } else if (quest is SideQuest) {
      name = quest.name;
    } else {
      name = '';
    }

    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 12),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: QuestLogColors.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: QuestLogColors.warning, width: 0.67),
              boxShadow: [
                BoxShadow(
                  color: QuestLogColors.warning.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: 1,
                  offset: Offset.zero,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CONFIRM // ARCHIVE QUEST',
                    style: GoogleFonts.jetBrainsMono(
                      color: QuestLogColors.warning,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text.rich(
                    TextSpan(
                      text: 'Are you sure you want to archive ',
                      children: [
                        TextSpan(
                          text: '"$name"',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              '? The Quest will no longer be available for use. This action cannot be undone.',
                        ),
                      ],
                    ),
                    style: TextStyle(
                      color: QuestLogColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Divider(height: 1),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      QuestLogButton(
                        primaryColor: QuestLogColors.textSecondary,
                        onPress: () => Navigator.pop(context, false),
                        label: 'CANCEL',
                        borderColor: QuestLogColors.border,
                        backgroundColor: QuestLogColors.surface,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),

                      const SizedBox(width: 8),

                      QuestLogButton(
                        primaryColor: QuestLogColors.warning,
                        backgroundColor: QuestLogColors.surfaceOnSurface,
                        onPress: () => Navigator.pop(context, true),
                        prefixIcon: Icons.archive_outlined,
                        label: 'ARCHIVE QUEST',
                        glow: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (shouldDelete ?? false) {
      onDelete();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backlogScreenAsync = ref.watch(backlogStateProvider);
    final notifier = ref.read(backlogControllerProvider.notifier);
    final navigationNotifier = ref.read(navigationProvider.notifier);
    final assemblerNotifier = ref.read(
      assemblerViewStateNotifierProvider.notifier,
    );

    return backlogScreenAsync.when(
      data: (state) {
        final sortedCategories = state.questsByCategory.keys.toList()
          ..sort((a, b) {
            final aQuests = state.questsByCategory[a]!;
            final bQuests = state.questsByCategory[b]!;
            final aCount = aQuests.$1.length + aQuests.$2.length;
            final bCount = bQuests.$1.length + bQuests.$2.length;

            return bCount.compareTo(aCount);
          });
        final categoryCounts = <dynamic, int>{
          for (final category in sortedCategories)
            category:
                state.questsByCategory[category]!.$1.length +
                state.questsByCategory[category]!.$2.length,
        };

        if (sortedCategories.isEmpty) {
          return _BacklogEmptyNote();
        } else {
          return QuestLogScreenContainer(
            children: [
              for (final category in sortedCategories) ...[
                _Header(
                  label: category.name,
                  questCount: categoryCounts[category],
                ),

                const SizedBox(height: 10),

                Column(
                  spacing: 10,
                  children: [
                    for (final mainQuest
                        in state.questsByCategory[category]!.$1) ...[
                      _MainQuestBlock(
                        mainQuest: mainQuest,
                        onArchive: () => _dialogBuilder(
                          context,
                          mainQuest,
                          () => notifier.archiveMainQuest(mainQuest),
                        ),
                        onClickEdit: () {},
                        onUpdate: () => notifier.updateMainQuest(mainQuest),
                        onAssemble: () {
                          assemblerNotifier.handleAddMainQuestToAssemble(
                            mainQuest,
                          );
                          navigationNotifier.setIndex(1);
                        },
                      ),
                    ],

                    for (final sideQuest
                        in state.questsByCategory[category]!.$2) ...[
                      _SideQuestBlock(
                        sideQuest: sideQuest,
                        onArchive: () => _dialogBuilder(
                          context,
                          sideQuest,
                          () => notifier.archiveSideQuest(sideQuest),
                        ),
                        onClickEdit: () {},
                        onUpdate: () => notifier.updateSideQuest(sideQuest),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 32),
              ],
            ],
          );
        }
      },
      error: (error, stack) => Center(child: Text('Fehler beim Laden: $error')),
      loading: () => QuestLogLoadingScreen(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.label, this.questCount});

  final String label;
  final int? questCount;

  @override
  Widget build(BuildContext context) {
    return QuestLogSectionHeader(
      title: label.toUpperCase(),

      rightSide: QuestLogBadge(
        label: '$questCount QUESTS',
        primaryColor: QuestLogColors.textSecondary,
        backgroundColor: QuestLogColors.surface,
        borderColor: QuestLogColors.border,
      ),
    );
  }
}

class _QuestContainer extends StatelessWidget {
  const _QuestContainer({required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: QuestLogColors.surface,
        border: Border(
          top: BorderSide(color: color, width: 0.5),
          right: BorderSide(color: color, width: 0.5),
          bottom: BorderSide(color: color, width: 0.5),
          left: BorderSide(color: color, width: 5),
        ),
      ),
      child: child,
    );
  }
}

class _MainQuestBlock extends StatelessWidget {
  const _MainQuestBlock({
    required this.mainQuest,
    required this.onArchive,
    required this.onClickEdit,
    required this.onUpdate,
    required this.onAssemble,
  });

  final MainQuest mainQuest;
  final VoidCallback onArchive;
  final VoidCallback onClickEdit;
  final VoidCallback onUpdate;
  final VoidCallback onAssemble;

  @override
  Widget build(BuildContext context) {
    return _QuestContainer(
      color: QuestLogColors.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  QuestLogBadge(
                    label: 'MAIN QUEST',
                    primaryColor: QuestLogColors.accent,
                  ),

                  const SizedBox(width: 5),

                  QuestLogBadge(
                    label: mainQuest.priority.label.toUpperCase(),
                    primaryColor: mainQuest.priority.color,
                    prefixIcon: mainQuest.priority.icon,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: QuestLogColors.accent,
                    size: 10,
                  ),

                  const SizedBox(width: 5),

                  Text(
                    'DUE: ${mainQuest.dueText}',
                    style: GoogleFonts.jetBrainsMono(
                      color: QuestLogColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            mainQuest.name,
            style: GoogleFonts.jetBrainsMono(
              color: QuestLogColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight(1000),
            ),
          ),

          if (mainQuest.subTasks.isNotEmpty) ...[
            const SizedBox(height: 10),

            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: QuestLogColors.black,
                border: Border.all(color: QuestLogColors.border, width: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.checklist,
                        size: 14,
                        color: QuestLogColors.accent,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        'SUB-TASKS',
                        style: GoogleFonts.jetBrainsMono(
                          color: QuestLogColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  for (final subTask in mainQuest.subTasks) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: QuestLogColors.accent,
                          size: 5,
                        ),

                        const SizedBox(width: 10),

                        Text(
                          subTask,
                          style: GoogleFonts.jetBrainsMono(
                            color: QuestLogColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],

          const SizedBox(height: 10),

          Divider(height: 1),

          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _QuestBlockFooterActions(
                onArchive: onArchive,
                onEdit: onClickEdit,
              ),

              QuestLogButton(
                primaryColor: QuestLogColors.accent,
                onPress: onAssemble,
                label: 'ASSEMBLE',
                fontSize: 10,
                prefixIcon: Icons.bolt_outlined,
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SideQuestBlock extends StatelessWidget {
  const _SideQuestBlock({
    required this.sideQuest,
    required this.onArchive,
    required this.onClickEdit,
    required this.onUpdate,
  });

  final SideQuest sideQuest;
  final VoidCallback onArchive;
  final VoidCallback onClickEdit;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return _QuestContainer(
      color: QuestLogColors.otherAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  QuestLogBadge(
                    label: 'SIDE QUEST',
                    primaryColor: QuestLogColors.otherAccent,
                  ),

                  const SizedBox(width: 5),

                  if (sideQuest.repeatDays.isNotEmpty) ...[
                    QuestLogBadge(
                      label: sideQuest.timeIntervalString()!.toUpperCase(),
                      primaryColor: QuestLogColors.otherAccent,
                      backgroundColor: QuestLogColors.surface,
                      borderColor: QuestLogColors.border,
                    ),
                  ],
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            sideQuest.name,
            style: GoogleFonts.jetBrainsMono(
              color: QuestLogColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight(1000),
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 10),

          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: QuestLogColors.black,
              border: Border.all(color: QuestLogColors.border, width: 0.5),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 5,
                  children: [
                    Text(
                      'REPEAT:',
                      style: GoogleFonts.jetBrainsMono(
                        color: QuestLogColors.textPrimary,
                        fontSize: 10,
                      ),
                    ),

                    const SizedBox(height: 10),

                    for (final day in Day.values) ...[
                      Container(
                        decoration: BoxDecoration(
                          color: sideQuest.repeatDays.contains(day)
                              ? QuestLogColors.otherAccent
                              : QuestLogColors.surface,
                          border: Border.all(color: QuestLogColors.border),
                          borderRadius: BorderRadiusGeometry.circular(5),
                        ),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              day.label[0],
                              style: GoogleFonts.jetBrainsMono(
                                color: sideQuest.repeatDays.contains(day)
                                    ? QuestLogColors.black
                                    : QuestLogColors.textSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),

                if (sideQuest.repeatDays.contains(
                  Day.fromDateTime(DateTime.now()),
                )) ...[
                  Text(
                    'TODAY',
                    style: GoogleFonts.jetBrainsMono(
                      color: QuestLogColors.otherAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ] else if (sideQuest.repeatDays.isEmpty) ...[
                  Text(
                    'NO REPEAT',
                    style: GoogleFonts.jetBrainsMono(
                      color: QuestLogColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 10),

          Divider(height: 1),

          const SizedBox(height: 5),

          _QuestBlockFooterActions(onArchive: onArchive, onEdit: onClickEdit),
        ],
      ),
    );
  }
}

class _QuestBlockFooterActions extends StatelessWidget {
  const _QuestBlockFooterActions({
    required this.onArchive,
    required this.onEdit,
  });

  final VoidCallback onArchive;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            radius: 10,
            customBorder: const CircleBorder(),
            onTap: onEdit,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.edit,
                size: 16,
                color: QuestLogColors.textSecondary,
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        Material(
          color: Colors.transparent,
          child: InkWell(
            radius: 10,
            customBorder: const CircleBorder(),
            onTap: onArchive,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.archive,
                size: 16,
                color: QuestLogColors.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BacklogEmptyNote extends StatefulWidget {
  const _BacklogEmptyNote();

  @override
  State<StatefulWidget> createState() => _BacklogEmptyNoteState();
}

class _BacklogEmptyNoteState extends State<_BacklogEmptyNote>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0,
      end: 12,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              Text(
                'BACKLOG EMPTY',
                style: GoogleFonts.jetBrainsMono(
                  letterSpacing: 3,
                  color: QuestLogColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                'NO QUESTS DETECTED IN LOCAL SECTOR',
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 160),
            ],
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 160,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animation.value),
                child: child,
              );
            },
            child: Column(
              children: [
                Text(
                  'INITIALIZE AN OBJECTIVE',
                  style: GoogleFonts.jetBrainsMono(
                    color: QuestLogColors.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 16),

                const Icon(
                  Icons.arrow_downward_rounded,
                  color: QuestLogColors.accent,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
