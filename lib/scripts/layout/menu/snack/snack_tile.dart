import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';
import 'package:pomodoropompurin/scripts/foundation/snack.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class SnackTile extends StatefulWidget {
  const SnackTile({super.key, required this.snack});

  final Snack snack;

  @override
  State<SnackTile> createState() => _SnackTileState();
}

class _SnackTileState extends State<SnackTile> with TickerProviderStateMixin {
  final assetManager = AssetManager.singleton;
  final purin = Purin.singleton;
  final progSystem = ProgSystem.singleton;

  final double iconSize = 60;
  final double buttonSize = 45;

  late final AnimationController tileOnLoadController;
  late final Animation<double> tileScale;

  late final AnimationController buttonController;
  late final Animation<double> buttonScale;

  void feedSnack() {
    progSystem.useSnack(widget.snack, 1);
    purin.feedSnack(widget.snack);
  }

  final displayCountTextStyle = const TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 0, 0, 0),
  );

  @override
  void initState() {
    super.initState();

    // Button pulse
    buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    buttonScale = Tween(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: buttonController, curve: Curves.easeInOut),
    );

    // Tile entrance animation
    final random = Random().nextInt(300);
    tileOnLoadController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400 + random),
    )..forward();

    tileScale = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: tileOnLoadController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    buttonController.dispose();
    tileOnLoadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: tileScale,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            /// TOP ICON + PROGRESS
            SizedBox(
              height: iconSize,
              width: iconSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: iconSize - 10,
                    height: iconSize - 10,
                    child: Image.asset(widget.snack.iconFlutterPath),
                  ),

                  /// ProcessConsumable Count
                  ValueListenableBuilder(
                    valueListenable: progSystem.snacksInventory[widget.snack]!,
                    builder: (context, value, child) {
                      return Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: Transform.translate(
                          offset: Offset(-20, -5),
                          child: SizedBox(
                            child: Text("$value", style: displayCountTextStyle),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// NAME
            Text(
              widget.snack.displayName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Fredoka',
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 3),

            const Spacer(),

            /// PURCHASE BUTTON
            ValueListenableBuilder(
              valueListenable: progSystem.snacksInventory[widget.snack]!,
              builder: (context, value, child) {
                if (value <= 0) {
                  return Icon(Icons.close, size: 45, color: Colors.black26);
                } else {
                  return child!;
                }
              },
              child: ScaleTransition(
                scale: buttonScale,
                child: GestureDetector(
                  onTapDown: (_) => feedSnack(),
                  child: Container(
                    height: buttonSize,
                    width: buttonSize,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.amber,
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      color: Colors.black,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
