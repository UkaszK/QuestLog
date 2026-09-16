import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/analytics_metrics.dart';
import 'package:questlog/providers/quest_providers.dart';
import 'package:questlog/providers/side_quest_providers.dart';

final analyticsRangeProvider =
    NotifierProvider<AnalyticsRangeNotifier, AnalyticsRange>(
      () => AnalyticsRangeNotifier(),
    );

class AnalyticsRangeNotifier extends Notifier<AnalyticsRange> {
  @override
  AnalyticsRange build() => AnalyticsRange.week;

  void select(AnalyticsRange range) => state = range;
}

final analyticsStateProvider = Provider<AsyncValue<AnalyticsMetrics>>((ref) {
  final range = ref.watch(analyticsRangeProvider);
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
    computeAnalytics(
      range: range,
      today: DateTime.now(),
      mainQuests: mainQuestsAsync.requireValue,
      sideQuestCompletions: sideCompletionsAsync.requireValue,
      sideQuests: sideQuestsAsync.requireValue,
    ),
  );
});
