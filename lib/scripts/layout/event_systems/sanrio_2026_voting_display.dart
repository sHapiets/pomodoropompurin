import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/event_systems/misc/sanrio_2026_voting.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class Sanrio2026VotingDisplay extends StatelessWidget {
  final assetManager = AssetManager.singleton;
  final sanrio2026Voting = Sanrio2026Voting.singleton;

  Sanrio2026VotingDisplay({Key? key}) : super(key: key);

  Future<void> launchVotingPage() async {
    final Uri url = Uri.parse(
      'https://ranking.sanrio.co.jp/en/characters/#profile_pompompurin',
    );

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void onConfirmedVote() {
    sanrio2026Voting.addVote();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE4F1),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: const Color(0xFFFF82B2), width: 4),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFB6D5).withOpacity(0.35),
                blurRadius: 25,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 200,
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFC7DF),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  assetManager.flutterAssetPaths['sanrio2026_purin_icon']!,
                ),
              ),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7FB),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFB3D3).withOpacity(0.45),
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
                child: const Text(
                  "- SANRIO 2026 VOTING -",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF6D4C41),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "( this dialog automatically popups everyday for a valid vote )",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF8D6E63),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "It's the final stretch, and the goal is near!\nBut it ain't over yet!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF8D6E63),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Cast your vote, then come back to\nlog it here too. With enough "
                "votes, you might \nrecieve a new Purin??",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF8D6E63),
                ),
              ),

              const SizedBox(height: 15),

              Container(
                height: 50,
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF7FB),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "${sanrio2026Voting.votes.value}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8D6E63),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                "Current Logged Votes",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF8D6E63),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: launchVotingPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF78B5),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: const Color(0xFFFFB0D2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "Open Purin's Voting Page!",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFF0F7),
                        foregroundColor: const Color(0xFF6D4C41),
                        elevation: 3,
                        shadowColor: const Color(0xFFFFC7DF),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        "I'll come back later!",
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onConfirmedVote();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          113,
                          190,
                          103,
                        ),
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: const Color(0xFFFFA8CD),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        "I Voted!",
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
