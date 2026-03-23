import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state_manager.dart';

class EnergyUI extends StatefulWidget {
  const EnergyUI({super.key, this.showEnergyValue = false});

  final bool showEnergyValue;

  @override
  State<EnergyUI> createState() => _EnergyUIState();
}

class _EnergyUIState extends State<EnergyUI>
    with SingleTickerProviderStateMixin {
  final Color uiColor = const Color.fromARGB(255, 49, 141, 151);
  final icon = Icons.bolt_rounded;
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
    _previousValue = value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: PurinStateManager.singleton.energy,
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
                  child: CircularProgressIndicator(
                    color: uiColor,
                    value: (value / 100).clamp(0.0, 1.0),
                    strokeWidth: 3,
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
                    weight: 2,
                    color: iconColor,
                    size: 20,
                    shadows: const [
                      Shadow(color: Colors.black26, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ],
            ),

            if (widget.showEnergyValue) const SizedBox(height: 6),

            if (widget.showEnergyValue)
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
                    Transform.translate(
                      offset: Offset(10, 0),
                      child: SlideTransition(
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
                    ),
                ],
              ),
          ],
        );
      },
    );
  }
}
