import 'package:flutter/material.dart';

class LevelUpDialog extends StatelessWidget {
  const LevelUpDialog({
    super.key,
    required this.newLevel,
    required this.levelRewards,
  });

  final int newLevel;
  final List<List<dynamic>> levelRewards;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxHeight: 450, minWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🎉 Header
            Column(
              children: [
                const Text(
                  "Oshiri Level Up!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  "You reached Level $newLevel",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Rewards list
            Expanded(
              child: levelRewards.isEmpty
                  ? const Center(child: Text("No new rewards this level."))
                  : ListView.separated(
                      itemCount: levelRewards.length,
                      separatorBuilder: (_, __) => const Divider(height: 20),
                      itemBuilder: (context, index) {
                        final reward = levelRewards[index];

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// Optional icon
                            if (reward.length > 2 && reward[2] is IconData)
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Icon(
                                  reward[2],
                                  size: 28,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),

                            /// Title & subtitle
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reward[0]?.toString() ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (reward.length > 1)
                                    Text(
                                      reward[1]?.toString() ?? "",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            /// Optional trailing info
                            if (reward.length > 3)
                              Text(
                                reward[3]?.toString() ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
            ),

            const SizedBox(height: 20),

            /// Close button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Awesome!"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
