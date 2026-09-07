import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questlog/data/main_quest.dart';
import 'package:questlog/data/side_quest.dart';
import 'package:questlog/providers/main_quest_providers.dart';
import 'package:questlog/providers/side_quest_providers.dart';

typedef BacklogState = ({
  List<MainQuest> mainQuests,
  List<SideQuest> sideQuests,
});

final backlogStateProvider = Provider<AsyncValue<BacklogState>>((ref) {
  final mainQuestsAsync = ref.watch(mainQuestsProvider);
  final sideQuestsAsync = ref.watch(sideQuestsProvider);

  if (mainQuestsAsync.isLoading || sideQuestsAsync.isLoading) {
    return AsyncLoading();
  }

  if (mainQuestsAsync.hasError) {
    return AsyncError(mainQuestsAsync.error!, mainQuestsAsync.stackTrace!);
  }
  if (sideQuestsAsync.hasError) {
    return AsyncError(sideQuestsAsync.error!, sideQuestsAsync.stackTrace!);
  }

  final mainQuests = mainQuestsAsync.requireValue;
  final sideQuests = sideQuestsAsync.requireValue;

  return AsyncValue.data((mainQuests: mainQuests, sideQuests: sideQuests));
});
