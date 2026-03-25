import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';

class HungerUI extends StatefulWidget {
  const HungerUI({super.key, this.showHungerValue = false});

  final bool showHungerValue;

  @override
  State<HungerUI> createState() => _HungerUIState();
}

class _HungerUIState extends State<HungerUI>
    with SingleTickerProviderStateMixin {
  final uiColor = const Color.fromARGB(255, 184, 93, 84);
  final icon = Icons.restaurant_rounded;
  final iconColor = Colors.white;

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  int _previousValue = 0;
  int _delta = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fade = Tween<double>(begin: 1, end: 0).animate(_controller);

    _slide = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.8),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkDelta(int value) {
    if (value > _previousValue) {
      _delta = value - _previousValue;
      _controller.forward(from: 0);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _previousValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: PurinStateManager.singleton.hunger,
      builder: (context, value, _) {
        _checkDelta(value);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(
                      begin: (_previousValue / 100).clamp(0.0, 1.0),
                      end: (value / 100).clamp(0.0, 1.0),
                    ),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutBack,
                    builder: (context, animatedValue, _) {
                      return CircularProgressIndicator(
                        color: uiColor,
                        value: animatedValue,
                        strokeWidth: 3,
                      );
                    },
                  ),
                ),

                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: uiColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                    shadows: const [
                      Shadow(color: Colors.black26, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ],
            ),

            if (widget.showHungerValue) const SizedBox(height: 6),

            if (widget.showHungerValue)
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: uiColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$value',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Fredoka',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (_delta > 0)
                    SlideTransition(
                      position: _slide,
                      child: FadeTransition(
                        opacity: _fade,
                        child: Text(
                          '+$_delta',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Fredoka',
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
          ],
        );
      },
    );
  }
}
