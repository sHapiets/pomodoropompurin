import 'package:flutter/material.dart';

class ItemDisplayEntity extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;

  const ItemDisplayEntity({
    super.key,
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  State<ItemDisplayEntity> createState() => _ItemDisplayEntityState();
}

class _ItemDisplayEntityState extends State<ItemDisplayEntity> {
  double xPosition = 0;
  double yPosition = 0;

  static const double itemSize = 300;

  bool onEditMode = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: xPosition,
      top: yPosition,
      child: Stack(
        children: [
          GestureDetector(
            onDoubleTap: () {
              onEditMode = !onEditMode;
              setState(() {});
            },
            child: Image.asset('assets/L8.jpg'),
          ),
          if (onEditMode)
            GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  xPosition = (xPosition + details.delta.dx).clamp(
                    -(0.5 * itemSize),
                    widget.maxWidth - (0.5 * itemSize),
                  );

                  yPosition = (yPosition + details.delta.dy).clamp(
                    -(0.5 * itemSize),
                    widget.maxHeight - (0.5 * itemSize),
                  );
                });
              },
              child: Container(
                width: 30,
                height: 30,
                color: const Color.fromARGB(255, 88, 153, 72),
              ),
            ),
        ],
      ),
    );
  }
}
