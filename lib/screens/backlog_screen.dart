import 'package:flutter/material.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'package:questlog/widgets/backlog_screen/backlog_empty_note.dart';

class BacklogScreen extends StatelessWidget {
  const BacklogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sideQuests = IsarDataStore.getAllSideQuests();
    final mainQuests = IsarDataStore.getAllMainQuests();

    return Column(
      children: [
        if (sideQuests.isEmpty && mainQuests.isEmpty) BacklogEmptyNote(),
      ],
    );
  }
}
