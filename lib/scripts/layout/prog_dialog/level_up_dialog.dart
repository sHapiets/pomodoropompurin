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
    const pudding = Color(0xFFFFF4D6);
    const caramel = Color(0xFFC87A2A);
    const softCaramel = Color(0xFFE8B77D);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          constraints: const BoxConstraints(
            maxHeight: 400,
            minWidth: 300,
            maxWidth: 350,
          ),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFF8EC), pudding],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
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
              Column(
                children: [
                  const Text(
                    "* Oshiri Level Up!",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: caramel,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "You reached Level $newLevel",
                    style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Rewards
              Expanded(
                child: levelRewards.isEmpty
                    ? const Center(
                        child: Text(
                          "No new rewards this level.",
                          style: TextStyle(
                            fontFamily: 'Fredoka',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.brown,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: levelRewards.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final reward = levelRewards[index];

                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.6),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: softCaramel),
                            ),
                            child: Row(
                              children: [
                                if (reward.length > 2 && reward[2] is String)
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: pudding,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    width: 50,
                                    child: Image.asset(reward[2]),
                                  ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reward[0]?.toString() ?? "",
                                        style: const TextStyle(
                                          fontFamily: 'Fredoka',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.brown,
                                        ),
                                      ),
                                      if (reward.length > 1)
                                        Text(
                                          reward[1]?.toString() ?? "",
                                          style: const TextStyle(
                                            fontFamily: 'Fredoka',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                              255,
                                              148,
                                              117,
                                              61,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                                if (reward.length > 3)
                                  Text(
                                    reward[3]?.toString() ?? "",
                                    style: const TextStyle(
                                      fontFamily: 'Fredoka',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: caramel,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 20),

              /// Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: caramel,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Sweet!",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
