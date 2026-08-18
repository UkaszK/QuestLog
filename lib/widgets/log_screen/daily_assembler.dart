import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/data/quest.dart';

class DailyAssembler extends StatelessWidget {
  const DailyAssembler({super.key, required this.quests});

  final List<Quest> quests;

  Widget buildQuestContainer(Quest quest) {
    final isPending = quest.status == QuestStatus.pending;
    return Container(
      width: 100,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.2),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        spacing: 3,
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 20,
            mainAxisAlignment: .spaceBetween,
            children: [
              if (isPending)
                Icon(Icons.warning, color: Colors.red)
              else
                Icon(quest.icon),

              Icon(
                Icons.circle,
                color: Quest.statusColor(quest.status),
                size: 10,
              ),
            ],
          ),
          Column(
            spacing: 3,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isPending)
                Text(
                  'PENDING',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 13,
                    color: Colors.red,
                    fontWeight: .w900,
                  ),
                )
              else
                Text(
                  '${quest.startTime} -\n${quest.endTime}',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),

              Text(
                quest.name,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DAILY ASSEMBLER',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.white70,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final data in quests) buildQuestContainer(data),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
