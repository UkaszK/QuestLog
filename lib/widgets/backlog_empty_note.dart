import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:questlog/theme/quest_log_colors.dart';

class BacklogEmptyNote extends StatefulWidget {
  const BacklogEmptyNote({super.key});

  @override
  State<StatefulWidget> createState() => BacklogEmptyNoteState();
}

class BacklogEmptyNoteState extends State<BacklogEmptyNote>
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
    return Center(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: QuestLogColors.border),
                ),
                child: Icon(
                  Icons.radar,
                  size: 48,
                  color: QuestLogColors.border,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'BACKLOG EMPTY',
                style: GoogleFonts.jetBrainsMono(
                  letterSpacing: 3,
                  color: QuestLogColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'NO QUESTS DETECTED IN LOCAL SECTOR',
                style: GoogleFonts.jetBrainsMono(
                  color: QuestLogColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 64),

          AnimatedBuilder(
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
        ],
      ),
    );
  }
}
