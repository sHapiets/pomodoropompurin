import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class CursorMovingSprite extends SpriteComponent {
  CursorMovingSprite({required Vector2 position, required int priority})
    : super(
        position: position,
        sprite: Sprite(Flame.images.fromCache('cursors/move.png')),
        size: Vector2.all(60),
        anchor: Anchor.center,
        priority: priority,
      );
}

class CursorScalingSprite extends SpriteComponent {
  CursorScalingSprite({required Vector2 position, required int priority})
    : super(
        position: position,
        sprite: Sprite(Flame.images.fromCache('SamplePurin.png')),
        size: Vector2.all(60),
        anchor: Anchor.center,
        priority: priority,
      );
}
