import 'package:flutter/material.dart';

class VignetteUI extends StatefulWidget {
  const VignetteUI({super.key, required this.visible});

  final bool visible;

  @override
  State<VignetteUI> createState() => _VignetteUIState();
}

class _VignetteUIState extends State<VignetteUI> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: 0,
      duration: Duration(),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        opacity: widget.visible ? 1.0 : 0.0,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(1)),
          ),
        ),
      ),
    );
  }
}
