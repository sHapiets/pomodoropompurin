import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:pomodoropompurin/scripts/core/prog_systems/purin_var/purin_var.dart';
import 'package:pomodoropompurin/scripts/core/purin/purin.dart';
import 'package:pomodoropompurin/scripts/layout/purin/purin_anim.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/effects/energy_gloom_effect.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/effects/hunger_pulse_effect.dart';
import 'package:pomodoropompurin/scripts/layout/purin_area/load_animation.dart';

class PurinStatusEffects extends PositionComponent {
  PurinStatusEffects() {
    anchor = Anchor.center;
    priority = 999;
  }

  late SequenceEffect loadAnim;
  late HungerPulseEffect hungerPulseAnim;
  late EnergyGloomEffect energyGloomAnim;
  final purin = Purin.singleton;
  PurinVar lastPurinVar = PurinVar.angel;

  @override
  void onMount() {
    super.onMount();

    loadAnim = LoadAnimation()..removeOnFinish = true;
    energyGloomAnim = EnergyGloomEffect(position: Vector2(-30, -20));
    hungerPulseAnim = HungerPulseEffect(position: Vector2(6, 7));

    add(IdleBreathingAnimation());
    add(loadAnim);
    add(energyGloomAnim);
    add(hungerPulseAnim);

    updateFlip();
    updatePostion();
    purin.addListener(updateFlip);
    purin.addListener(updatePostion);

    showHungerPulse();
    showEnergyGloom();
    purin.stateManager.hunger.addListener(showHungerPulse);
    purin.stateManager.energy.addListener(showEnergyGloom);

    lastPurinVar = purin.equipManager.equippedPurinVar;
  }

  void updatePostion() {
    if (position != purin.purinPositionVect2) {
      position = purin.purinPositionVect2;
      add(loadAnim..reset());
    }
  }

  void updateFlip() {
    bool flip = purin.stateManager.position.flipSprite;

    if (flip && !hungerPulseAnim.isFlippedHorizontally) {
      hungerPulseAnim.flipHorizontally();
      energyGloomAnim.flipHorizontally();
    } else if (!flip && hungerPulseAnim.isFlippedHorizontally) {
      hungerPulseAnim.flipHorizontally();
      energyGloomAnim.flipHorizontally();
    }

    if (lastPurinVar != purin.equipManager.equippedPurinVar) {
      lastPurinVar = purin.equipManager.equippedPurinVar;
      add(loadAnim..reset());
    }
  }

  void showHungerPulse() {
    final hunger = purin.stateManager.hunger.value;
    if (hunger >= 35) {
      hungerPulseAnim.show = false;
      return;
    }

    hungerPulseAnim.show = true;
  }

  void showEnergyGloom() {
    final energy = purin.stateManager.energy.value;
    if (energy >= 35) {
      energyGloomAnim.show = false;
      return;
    }

    energyGloomAnim.show = true;
  }
}
