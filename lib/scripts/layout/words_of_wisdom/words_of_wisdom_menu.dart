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
    const pudding = Color.fromARGB(255, 255, 255, 255);
    const caramel = Color(0xFFC87A2A);
    const softCaramel = Color(0xFFE8B77D);

    final currentLevel = ProgSystem.singleton.oshiriLevel.value;

    final unlockedScripts =
        ScriptsMap.fromLevelUp.entries
            .where((entry) => entry.key <= currentLevel)
            .toList()
          ..sort((a, b) => a.key.compareTo(b.key));

    return Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Transform.translate(
          offset: Offset(50, -50),
          child: Container(
            width: 260,
            height: 320,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: pudding,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: Column(
              children: [
                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat_bubble, color: caramel),
                    const SizedBox(width: 8),
                    const Text(
                      "Words of Wisdom",
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: caramel,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  "Replay Purin's most random thoughts....",
                  style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 14,
                    color: Colors.brown,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                /// List
                Expanded(
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
                              const SizedBox(height: 12),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Reusable tile builder (your "helper widget function")
  Widget _wisdomTile(
    BuildContext context, {
    required int level,
    required ScriptDialog script,
    required Color pudding,
    required Color softCaramel,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        purinAreaKey.currentState!.currentGame.overlays.removeAll(
          purinAreaKey.currentState!.currentGame.overlays.activeOverlays,
        );
        ScriptManager.singleton.removeAllDialogs();
        ScriptManager.singleton.addLevelUpDialog(level);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: softCaramel.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: softCaramel.darken(0.3)),
        ),
        child: Row(
          children: [
            /// Icon (first image)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: pudding,
                borderRadius: BorderRadius.circular(12),
              ),
              width: 50,
              child: Image.asset(script.imagePaths.first),
            ),

            const SizedBox(width: 12),

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
                      fontSize: 12,
                      color: Colors.brown,
                    ),
                  ),
                  Text(
                    "Level $level",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 12,
                      color: Color.fromARGB(255, 148, 117, 61),
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.play_arrow, color: Colors.brown),
          ],
        ),
      ),
    );
  }
}
