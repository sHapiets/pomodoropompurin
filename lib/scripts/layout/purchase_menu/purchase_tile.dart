import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';
import 'package:pomodoropompurin/scripts/memory/asset_manager.dart';

class PurchaseTile extends StatefulWidget {
  const PurchaseTile({super.key, required this.ingridient});

  final Ingridient ingridient;

  @override
  State<PurchaseTile> createState() => _PurchaseTileState();
}

class _PurchaseTileState extends State<PurchaseTile>
    with TickerProviderStateMixin {
  final assetManager = AssetManager.singleton;
  final progSystem = ProgSystem.singleton;

  final double iconSize = 60;
  final double buttonSize = 45;

  late final AnimationController tileOnLoadController;
  late final Animation<double> tileScale;

  late final AnimationController buttonController;
  late final Animation<double> buttonScale;

  Timer? purchaseTimer;
  double purchaseSpeed = 0.03;
  double purchaseIndicator = 0.0;

  bool get insufficientPomPoints {
    if (progSystem.pomPoints.value < widget.ingridient.price) {
      return true;
    }
    return false;
  }

  void purchase() {
    progSystem.usePomPoints(widget.ingridient.price);
    progSystem.addIngridient(widget.ingridient, 1);
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

  void buttonHold() {
    purchaseTimer?.cancel();
    purchaseTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        if (insufficientPomPoints) {
          timer.cancel();
          return;
        }

        purchaseIndicator = (purchaseIndicator + purchaseSpeed).clamp(0.0, 1.0);
        if (purchaseIndicator == 1.0) {
          purchase();
          purchaseSpeed = (purchaseSpeed >= 0.036)
              ? 0.036
              : purchaseSpeed + 0.003;
          purchaseIndicator = 0;
        }
      });
    });
  }

  void buttonCancel() {
    purchaseTimer?.cancel();
    purchaseSpeed = 0.03;
    purchaseTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        purchaseIndicator = (purchaseIndicator - 0.05).clamp(0.0, 1.0);
        if (purchaseIndicator == 0.0) timer.cancel();
      });
    });
  }

  @override
  void dispose() {
    purchaseTimer?.cancel();
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
                    child: Image.asset(widget.ingridient.spriteFlutterPath),
                  ),

                  SizedBox(
                    height: iconSize,
                    width: iconSize,
                    child: CircularProgressIndicator(
                      value: purchaseIndicator,
                      backgroundColor: const Color.fromARGB(151, 221, 221, 221),
                      color: const Color.fromARGB(255, 255, 209, 24),
                    ),
                  ),

                  /// ProcessConsumable Count
                  Align(
                    alignment: AlignmentGeometry.topLeft,
                    child: Transform.translate(
                      offset: Offset(-20, -5),
                      child: SizedBox(
                        child: Text(
                          "${progSystem.ingridientInventory[widget.ingridient]!.value}",
                          style: displayCountTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// NAME
            Text(
              widget.ingridient.displayName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Fredoka',
                fontWeight: FontWeight.w600,
                fontSize: 11,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 3),

            /// PRICE
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    assetManager.flutterAssetPaths['pP_icon']!,
                  ),
                ),
                const SizedBox(width: 4),
                ValueListenableBuilder(
                  valueListenable: progSystem.pomPoints,
                  builder: (context, value, child) {
                    return Text(
                      '${widget.ingridient.price}',
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: (insufficientPomPoints)
                            ? Colors.red
                            : Colors.green,
                      ),
                    );
                  },
                ),
              ],
            ),

            const Spacer(),

            /// PURCHASE BUTTON
            ValueListenableBuilder(
              valueListenable: progSystem.pomPoints,
              builder: (context, value, child) {
                if (insufficientPomPoints) {
                  return Icon(Icons.close, size: 45, color: Colors.black26);
                } else {
                  return child!;
                }
              },
              child: ScaleTransition(
                scale: buttonScale,
                child: GestureDetector(
                  onTapDown: (_) => buttonHold(),
                  onTapUp: (_) => buttonCancel(),
                  onTapCancel: buttonCancel,
                  child: Container(
                    height: buttonSize,
                    width: buttonSize,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.amber,
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
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
