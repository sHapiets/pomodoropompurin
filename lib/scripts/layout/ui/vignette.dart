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
    return Align(
      alignment: Alignment.topCenter,
      child: IgnorePointer(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  const Color.fromARGB(0, 167, 43, 43),
                  const Color.fromARGB(146, 0, 0, 0),
                ],
                stops: [0.8, 1],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
