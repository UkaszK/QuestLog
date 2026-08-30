import 'package:isar/isar.dart';

part 'sub_task.g.dart';

@embedded
class SubTask {
  SubTask({this.name = '', this.completed = false});

  final String name;
  final bool completed;
}
