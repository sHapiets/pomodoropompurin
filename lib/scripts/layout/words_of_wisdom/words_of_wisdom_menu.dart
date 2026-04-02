import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_dialog.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/script_manager.dart';
import 'package:pomodoropompurin/scripts/core/dialog/script_dialog/scripts_map.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/page/main_page.dart';

class WordsOfWisdomMenu extends StatelessWidget {
  const WordsOfWisdomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    const pudding = Color.fromARGB(207, 255, 255, 255);
    const caramel = Color(0xFFC87A2A);
    const softCaramel = Color(0xFFE8B77D);

    final currentLevel = ProgSystem.singleton.oshiriLevel.value;

    final unlockedScripts =
        ScriptsMap.fromLevelUp.entries
            .where((entry) => entry.key <= currentLevel)
            .toList()
          ..sort((a, b) => a.key.compareTo(b.key));

    return Center(
      child: Transform.translate(
        offset: const Offset(50, -50),
        child: Container(
          width: 260,
          height: 320,
          padding: const EdgeInsets.all(14),

          child: Column(
            children: [
              _header("words of wisdom", Icons.chat_bubble, caramel),

              const SizedBox(height: 8),

              _softContent(
                color: caramel,
                child: const Text(
                  "Replay Purin's most random thoughts....",
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 11,
                    color: Colors.brown,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 8),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      239,
                      255,
                      220,
                      177,
                    ).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: unlockedScripts.isEmpty
                      ? const Center(
                          child: Text(
                            "Purin has yet to impart his wisdom...",
                            style: TextStyle(
                              fontFamily: 'Fredoka',
                              fontSize: 10,
                              color: Colors.brown,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: unlockedScripts.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final entry = unlockedScripts[index];
                            final level = entry.key;
                            final script = entry.value;

                            return _wisdomTile(
                              context,
                              level: level,
                              script: script,
                              pudding: pudding,
                              softCaramel: softCaramel,
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2).darken(0.3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(spreadRadius: 4, color: color.withOpacity(0.2))],
      ),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Fredoka',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
                shadows: [Shadow(color: Colors.black38, offset: Offset(2, 2))],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _softContent({required Widget child, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: child,
    );
  }

  Widget _wisdomTile(
    BuildContext context, {
    required int level,
    required ScriptDialog script,
    required Color pudding,
    required Color softCaramel,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        purinAreaKey.currentState!.currentGame.overlays.removeAll(
          purinAreaKey.currentState!.currentGame.overlays.activeOverlays,
        );
        ScriptManager.singleton.removeAllDialogs();
        ScriptManager.singleton.addLevelUpDialog(level);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: softCaramel.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: softCaramel.darken(0.3)),
        ),
        child: Row(
          children: [
            /// Icon
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: pudding,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 45,
              child: Image.asset(script.imagePaths.first),
            ),

            const SizedBox(width: 10),

            /// Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    script.title,
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      color: Colors.brown,
                    ),
                  ),
                  Text(
                    "Level $level",
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 10,
                      color: Color.fromARGB(255, 148, 117, 61),
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.play_arrow, color: Colors.brown, size: 16),
          ],
        ),
      ),
    );
  }
}
