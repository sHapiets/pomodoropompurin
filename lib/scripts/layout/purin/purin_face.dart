import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/purin_var/purin_var.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state/purin_mood.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin_state/purin_state_manager.dart';

class PurinFace extends PositionComponent with HasVisibility {
  final purin = Purin.singleton;

  SpriteComponent faceSprite = SpriteComponent(
    sprite: Sprite(Flame.images.fromCache('purinEntity.png')),
    size: Vector2.all(70),
    position: Vector2.zero(),
    anchor: Anchor.center,
  );
  late SpriteSheet faceSpritesheet;

  int moodColumn = 0;
  bool blink = false;

  final _random = Random();
  double _blinkTimer = 0;
  double _nextBlinkTime = 3;
  final double _blinkDuration = 0.08;
  bool _isBlinking = false;
  bool _queuedSecondBlink = false;

  final moodSheetColumnFromMood = {
    PurinMood.drained: 0,
    PurinMood.down: 1,
    PurinMood.neutral: 2,
    PurinMood.satisfied: 3,
    PurinMood.elated: 4,
  };

  @override
  void onMount() {
    super.onMount();

    faceSpritesheet = SpriteSheet(
      image: Flame.images.fromCache(
        purin.equipManager.equippedPurinVar.purinFaceSpritesheetDir,
      ),
      srcSize: Vector2(500, 500),
    );

    updateFaceSpritesheet();
    updateMoodColumn();

    add(faceSprite);

    _scheduleNextBlink();

    purin.stateManager.mood.addListener(updateMoodColumn);

    purin.addListener(updateFaceSpritesheet);
  }

  @override
  void update(double dt) {
    super.update(dt);

    _blinkTimer += dt;

    if (!_isBlinking && _blinkTimer >= _nextBlinkTime) {
      _startBlink();
    }

    if (_isBlinking && _blinkTimer >= _blinkDuration) {
      _endBlink();
    }
  }

  @override
  void onRemove() {
    purin.stateManager.mood.removeListener(updateMoodColumn);

    purin.removeListener(updateFaceSpritesheet);

    super.onRemove();
  }

  void updateFace() {
    final isBeachPurin = purin.equipManager.equippedPurinVar == PurinVar.beach;
    final isNotIdle = purin.stateManager.action != PurinAction.idle;
    final isRestPos =
        purin.stateManager.position == PurinPosition.futon ||
        purin.stateManager.position == PurinPosition.sofaRest;
    if (isBeachPurin || isNotIdle || isRestPos) {
      isVisible = false;
      return;
    }

    isVisible = true;
    final blinkRow = blink ? 1 : 0;
    faceSprite.sprite = faceSpritesheet.getSprite(blinkRow, moodColumn);
  }

  void updateMoodColumn() {
    final PurinMood mood = purin.stateManager.mood.value;

    moodColumn = moodSheetColumnFromMood[mood]!;

    updateFace();
  }

  void updateFaceSpritesheet() {
    final purinVar = purin.equipManager.equippedPurinVar;

    faceSpritesheet = SpriteSheet(
      image: Flame.images.fromCache(purinVar.purinFaceSpritesheetDir),
      srcSize: Vector2(500, 500),
    );

    updateFace();
  }

  void _startBlink() {
    _isBlinking = true;
    blink = true;
    _blinkTimer = 0;
    updateFace();
  }

  void _endBlink() {
    _isBlinking = false;

    blink = false;
    _blinkTimer = 0;
    updateFace();

    if (_queuedSecondBlink) {
      _queuedSecondBlink = false;
      _nextBlinkTime = 0.12;
    } else {
      _queuedSecondBlink = _random.nextDouble() < 0.25;
      _scheduleNextBlink();
    }
  }

  void _scheduleNextBlink() {
    _nextBlinkTime = 2.5 + (_random.nextDouble() * 1.5);
  }
}
