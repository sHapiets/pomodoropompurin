import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/purinArea/purin_area_state_manager.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_entity.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/exterior.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/floor.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/interior_wall.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/selectables/kotatsu.dart';

class PurinAreaHome extends PositionComponent with TapCallbacks {
  PurinAreaHome({required Vector2 position}) {
    this.position = position;
    anchor = Anchor.center;
  }

  final purinAreaStateManager = PurinAreaStateManager.singleton;
  late Floor floorEntity;
  late Kotatsu kotatsuEntity;
  late Exterior exteriorEntity;
  late PurinEntity purinEntity;
  late InteriorWall interiorWallEntity;
  late SequenceEffect onLoadAnim;

  @override
  Future<void> onMount() async {
    super.onMount();

    addOnLoadAnim();

    purinEntity = PurinEntity();
    kotatsuEntity = Kotatsu();
    floorEntity = Floor();
    exteriorEntity = Exterior();
    interiorWallEntity = InteriorWall();
    add(floorEntity);
    add(kotatsuEntity);
    add(purinEntity);
    add(interiorWallEntity);
    add(exteriorEntity);
  }

  void addOnLoadAnim() {
    onLoadAnim = SequenceEffect([
      ScaleEffect.to(
        Vector2.all(1.4),
        EffectController(duration: 0.15, curve: Curves.easeOut),
      ),
      ScaleEffect.to(
        Vector2.all(0.6),
        EffectController(duration: 0.15, curve: Curves.easeIn),
      ),
      ScaleEffect.to(
        Vector2.all(1.1),
        EffectController(duration: 0.15, curve: Curves.easeOut),
      ),
      ScaleEffect.to(
        Vector2.all(0.9),
        EffectController(duration: 0.15, curve: Curves.easeIn),
      ),
      ScaleEffect.to(
        Vector2.all(1),
        EffectController(duration: 0.15, curve: Curves.easeOut),
      ),
    ]);
    add(onLoadAnim);
  }
}
