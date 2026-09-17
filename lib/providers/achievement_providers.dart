import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/achievement.dart';
import 'package:questlog/data/achievement_catalog.dart';
import 'package:questlog/data/achievement_unlock.dart';
import 'package:questlog/data/gamification_metrics.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/providers/quest_providers.dart';
import 'package:questlog/providers/side_quest_providers.dart';

final gamificationStateProvider = Provider<AsyncValue<GamificationMetrics>>((
  ref,
) {
  final mainQuestsAsync = ref.watch(assemblerMainQuestsProvider);
  final sideCompletionsAsync = ref.watch(assemblerSideQuestsProvider);
  final sideQuestsAsync = ref.watch(sideQuestsProvider);

  final states = [mainQuestsAsync, sideCompletionsAsync, sideQuestsAsync];

  if (states.any((state) => state.isLoading)) {
    return const AsyncLoading();
  }

  for (final state in states) {
    if (state.hasError) return AsyncError(state.error!, state.stackTrace!);
  }

  return AsyncData(
    computeGamification(
      today: DateTime.now(),
      mainQuests: mainQuestsAsync.requireValue,
      sideQuestCompletions: sideCompletionsAsync.requireValue,
      sideQuests: sideQuestsAsync.requireValue,
    ),
  );
});

final achievementUnlockControllerProvider =
    NotifierProvider<AchievementUnlockController, void>(
      () => AchievementUnlockController(),
    );

/// Compares freshly computed progress against the tiers already announced and
/// persists the difference. Returns the tiers that are newly unlocked, so the
/// caller can celebrate them once.
class AchievementUnlockController extends Notifier<void> {
  @override
  void build() {}

  List<({AchievementDefinition definition, AchievementTier tier})> sync(
    GamificationMetrics metrics,
  ) {
    final announced = IsarDataStore.getAnnouncedAchievementKeys();
    final earned = metrics.earnedTierKeys;

    // First run: adopt everything already earned without celebrating it.
    if (!announced.contains(achievementBackfillKey)) {
      IsarDataStore.addAchievementUnlocks({achievementBackfillKey, ...earned});
      return const [];
    }

    final newKeys = earned.difference(announced);
    if (newKeys.isEmpty) return const [];

    IsarDataStore.addAchievementUnlocks(newKeys);

    return [
      for (final definition in achievementCatalog)
        for (final tier in AchievementTier.values)
          if (newKeys.contains(achievementTierKey(definition.id, tier)))
            (definition: definition, tier: tier),
    ];
  }
}
