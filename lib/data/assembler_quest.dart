import 'package:isar/isar.dart';
import 'package:questlog/data/quest_status.dart';
import 'package:questlog/data/sub_task.dart';
import 'package:questlog/utils/get_time_text.dart';

part 'assembler_quest.g.dart';

// Scheduled execution of a MainQuest for a specific time slot; not a template.
@collection
class AssemblerMainQuest implements Comparable<AssemblerMainQuest> {
  AssemblerMainQuest({
    required this.mainQuestId,
    required this.name,
    required this.questCategoryName,
    required this.subTasks,
    required this.startTime,
    required this.endTime,
    this.completed = false,
  });

  Id id = Isar.autoIncrement;

  final int mainQuestId;
  final String name;
  final String questCategoryName;
  final List<SubTask> subTasks;
  final DateTime startTime;
  final DateTime endTime;
  final bool completed;

  @ignore
  QuestStatus get status {
    if (completed) return QuestStatus.completed;

    final now = DateTime.now();
    if (startTime.isBefore(now) && endTime.isAfter(now)) {
      return QuestStatus.active;
    }

    if (endTime.isBefore(now)) {
      return QuestStatus.pending;
    }

    if (startTime.isAfter(now)) {
      return QuestStatus.open;
    }

    return QuestStatus.completed;
  }

  @ignore
  String get timeLabel {
    return switch (status) {
      QuestStatus.completed => 'COMPLETED',
      QuestStatus.pending => 'PENDING',
      _ => timeText,
    };
  }

  @ignore
  int get durationInMinutes => endTime.difference(startTime).inMinutes;

  @ignore
  String get timeText => getTimeText(startTime, endTime);

  @override
  int compareTo(AssemblerMainQuest other) {
    return startTime.compareTo(other.startTime);
  }
}
