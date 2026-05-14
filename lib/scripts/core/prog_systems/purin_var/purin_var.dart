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
  mama;

  const PurinVar();

  String get displayName =>
      "${name[0].toUpperCase() + name.substring(1)}-Purin";
  String get purinSpritesheetDir => 'purin_sprites/${name}_spritesheet.png';
  String get iconAssetPath => 'assets/images/purin_sprites/${name}_icon.png';
}
