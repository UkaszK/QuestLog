import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyAssembler extends StatelessWidget {
  const DailyAssembler({super.key, required this.quests});

  final List<Map<String, Object>> quests;

  Widget buildQuestContainer(
    IconData icon,
    String startTime,
    String endTime,
    String label,
  ) {
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
              Icon(icon),
              Icon(Icons.circle, color: Colors.cyanAccent, size: 10),
            ],
          ),
          Column(
            spacing: 3,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$startTime -\n$endTime',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
              Text(
                label,
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
                  for (final data in quests)
                    buildQuestContainer(
                      data['icon'] as IconData,
                      data['startTime'] as String,
                      data['endTime'] as String,
                      data['label'] as String,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
