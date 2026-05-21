import 'package:pomodoropompurin/scripts/core/purin/purin_attributes/purin_attributes.dart';

enum PurinVar {
  boku,
  pumpkin,
  summer,
  bee,
  pika,
  yana,
  pol,
  fragaria,
  winter,
  atenean,
  beach,
  tokimeki,
  angel,
  chef,
  kimono,
  vampire,
  mama,
  cheer;

  const PurinVar();

  String get displayName =>
      "${name[0].toUpperCase() + name.substring(1)}-Purin";
  String get purinSpritesheetDir => 'purin_sprites/${name}_spritesheet.png';
  String get iconAssetPath => 'assets/images/purin_sprites/${name}_icon.png';
  String get purinFaceSpritesheetDir {
    if (this == PurinVar.yana) {
      return 'purin_sprites/faces/white_spritesheet.png';
    }
    if (this == PurinVar.vampire) {
      return 'purin_sprites/faces/vampire_spritesheet.png';
    }
    return 'purin_sprites/faces/default_spritesheet.png';
  }

  Map<PurinAttributes, int> passiveAttributeBoost(int purinVarLevel) {
    final purinVar = this;
    Map<PurinAttributes, int> ret = {};

    switch (purinVar) {
      case PurinVar.boku:
        return {PurinAttributes.comfort: purinVarLevel * 5};

      default:
        return ret;
    }
  }
}
