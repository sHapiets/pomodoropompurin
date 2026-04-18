import 'package:flutter/material.dart';

class NotificationDotWrapper extends StatefulWidget {
  final Widget child;
  final ValueNotifier<bool> notifier;
  final double dotSize;
  final Offset offset;

  const NotificationDotWrapper({
    Key? key,
    required this.child,
    required this.notifier,
    this.dotSize = 10.0,
    this.offset = const Offset(2, -2),
  }) : super(key: key);

  @override
  State<NotificationDotWrapper> createState() => _NotificationDotWrapperState();
}

class _NotificationDotWrapperState extends State<NotificationDotWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _bobAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _bobAnim = Tween<double>(
      begin: 0.0,
      end: -3.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    widget.notifier.addListener(_handleNotifier);

    if (widget.notifier.value) {
      _controller.repeat(reverse: true);
    }
  }

  void _handleNotifier() {
    if (widget.notifier.value) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.value = 0; // reset
    }
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_handleNotifier);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.notifier,
      builder: (context, value, _) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _bobAnim.value),
              child: Transform.scale(scale: _scaleAnim.value, child: child),
            );
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              widget.child,
              if (value)
                Positioned(
                  top: widget.offset.dy,
                  right: widget.offset.dx,
                  child: Container(
                    width: widget.dotSize,
                    height: widget.dotSize,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 241, 93, 93),
                        width: 2,
                      ),
                      color: const Color.fromARGB(255, 244, 133, 125),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
