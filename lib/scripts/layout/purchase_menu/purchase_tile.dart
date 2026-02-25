import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/prog_system.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

class PurchaseTile extends StatefulWidget {
  const PurchaseTile({super.key, required this.ingridient});

  final Ingridient ingridient;

  @override
  State<PurchaseTile> createState() => _PurchaseTileState();
}

class _PurchaseTileState extends State<PurchaseTile>
    with TickerProviderStateMixin {
  final progSystem = ProgSystem.singleton;

  final double iconSize = 60;
  final double buttonSize = 45;

  late final AnimationController tileOnLoadController;
  late final Animation<double> tileScale;

  late final AnimationController buttonController;
  late final Animation<double> buttonScale;

  Timer? purchaseTimer;
  double purchaseIndicator = 0.0;

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
        purchaseIndicator = (purchaseIndicator + 0.05).clamp(0.0, 1.0);
        if (purchaseIndicator == 1.0) timer.cancel();
      });
    });
  }

  void buttonCancel() {
    purchaseTimer?.cancel();
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
                  Container(
                    height: iconSize,
                    width: iconSize,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),

                  CircularProgressIndicator(
                    value: purchaseIndicator,
                    backgroundColor: const Color.fromARGB(151, 221, 221, 221),
                    color: const Color.fromARGB(255, 255, 209, 24),
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
                fontSize: 11,
                color: Colors.black,
              ),
            ),

            const Spacer(),

            /// PURCHASE BUTTON
            ScaleTransition(
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
          ],
        ),
      ),
    );
  }
}
