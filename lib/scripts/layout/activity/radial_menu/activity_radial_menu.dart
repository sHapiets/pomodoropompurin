import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/layout/activity/radial_menu/radial_menu_item.dart';
import 'package:pomodoropompurin/scripts/layout/activity/radial_menu/radial_painter.dart';

class ActivityRadialMenu extends StatefulWidget {
  final Widget child;
  final List<RadialMenuItem> items;
  final Function(RadialMenuItem item, int index)? onSelected;
  final double radius;
  final Duration holdDuration;

  const ActivityRadialMenu({
    super.key,
    required this.child,
    required this.items,
    this.onSelected,
    this.radius = 100,
    this.holdDuration = const Duration(milliseconds: 300),
  });

  @override
  State<ActivityRadialMenu> createState() => _ActivityRadialMenuState();
}

class _ActivityRadialMenuState extends State<ActivityRadialMenu> {
  OverlayEntry? _overlayEntry;

  Offset _pressPosition = Offset.zero;
  Offset _currentPointer = Offset.zero;

  bool _menuVisible = false;
  int? _hoveredIndex;

  void _showMenu() {
    if (_menuVisible) return;

    _menuVisible = true;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setOverlayState) {
            _updateOverlay = setOverlayState;

            return Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onPanUpdate: (details) {
                      _currentPointer = details.globalPosition;
                      _updateHoveredItem();
                    },
                    child: CustomPaint(
                      painter: RadialPainter(
                        center: _pressPosition,
                        items: widget.items,
                        radius: widget.radius,
                        hoveredIndex: _hoveredIndex,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void Function(VoidCallback fn)? _updateOverlay;

  void _hideMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    _menuVisible = false;
    _hoveredIndex = null;
  }

  void _updateHoveredItem() {
    final dx = _currentPointer.dx - _pressPosition.dx;
    final dy = _currentPointer.dy - _pressPosition.dy;

    final distance = sqrt(dx * dx + dy * dy);

    if (distance < 40 || distance > widget.radius + 40) {
      _hoveredIndex = null;
      _updateOverlay?.call(() {});
      return;
    }

    double angle = atan2(dy, dx);

    angle = angle + pi / 2;

    if (angle < 0) {
      angle += pi * 2;
    }

    final sliceAngle = (2 * pi) / widget.items.length;

    final index = (angle / sliceAngle).floor() % widget.items.length;

    _hoveredIndex = index;

    _updateOverlay?.call(() {});
  }

  void _selectCurrent() {
    if (_hoveredIndex != null) {
      widget.onSelected?.call(widget.items[_hoveredIndex!], _hoveredIndex!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onLongPressStart: (details) {
          _pressPosition = details.globalPosition;
          _currentPointer = details.globalPosition;
          _showMenu();
        },
        onLongPressMoveUpdate: (details) {
          _currentPointer = details.globalPosition;
          _updateHoveredItem();
        },
        onLongPressEnd: (_) {
          _selectCurrent();
          _hideMenu();
        },
        child: widget.child,
      ),
    );
  }
}
