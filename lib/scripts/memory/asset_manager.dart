import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pomodoropompurin/scripts/core/acquirables.dart';
import 'package:pomodoropompurin/scripts/foundation/consumable.dart';
import 'package:pomodoropompurin/scripts/foundation/ingridient.dart';

/// Singleton class to manage all materials in the assets folder
///
/// In contrast to the DatabaseManager, this memory-based class is
/// essentially created to link external materials for access to all
/// other classes and widgets. It does not contain the actual assets,
/// per se, but only links/paths. Its main function, however, is centered
/// on preloading the assets, which are called during the splash page/
/// loading screen.
class AssetManager {
  AssetManager._internal();
  static final AssetManager singleton = AssetManager._internal();

  final Map<String, ImageProvider> _images = {}; // Preloaded images
  final Map<String, bool> _lazyLoaded = {}; // Tracks lazy-loaded shop assets

  /// Flutter Image links are accessed via a string of the asset path rooted
  /// at the asset folder (e.g. 'assets/..../image.png'). Due to foreseeable changes
  /// in directories of certain images, a map is created as a reliable way
  /// to lay a permanent set key per asset, such that the associated value (path) of
  /// the key is mutable.
  Map<String, String> flutterAssetPaths = {
    'pT_FG': 'assets/images/pomTimer/pomTimer_foreground.png',
    'pT_BG': 'assets/images/pomTimer/pomTimer_background.png',
    'pT_WP': 'assets/images/pomTimer/pomTimer_work_pointer.png',
    'pT_BP': 'assets/images/pomTimer/pomTimer_break_pointer.png',
    'pT_SB': 'assets/images/pomTimer/pomTimer_start_button.png',
    'pP_icon': 'assets/images/pomPoints_icon.png',

    'curious_purin_icon': 'assets/images/character_icons/purin/curious.png',
    'happy_purin_icon': 'assets/images/character_icons/purin/happy.png',
    'eating_purin_icon': 'assets/images/character_icons/purin/eating.png',
    'blank_purin_icon': 'assets/images/character_icons/purin/blank.png',
    'thinking_purin_icon': 'assets/images/character_icons/purin/thinking.png',
    'down_purin_icon': 'assets/images/character_icons/purin/down.png',
    'please_purin_icon': 'assets/images/character_icons/purin/please.png',
    'shadow_purin_icon': 'assets/images/character_icons/purin/shadow.png',
    'excited_purin_icon': 'assets/images/character_icons/purin/excited.png',
    'pumped_purin_icon': 'assets/images/character_icons/purin/pumped.png',
    'calm_purin_icon': 'assets/images/character_icons/purin/calm.png',

    'mixer_objects_icon': 'assets/images/character_icons/objects/mixer.png',
    'mixer_shadow_objects_icon':
        'assets/images/character_icons/objects/mixer_shadow.png',

    ...{for (final ing in Ingridient.values) ing.name: ing.spriteFlutterPath},
    ...{for (final con in Consumable.values) con.name: con.iconFlutterPath},
    ...{
      for (final purinVar in Acquirables.singleton.purinVars.values)
        purinVar.displayName: purinVar.iconAssetPath,
    },
  };

  /// Preload one asset globally
  Future<void> preloadImage(String assetPath, BuildContext context) async {
    if (_images.containsKey(assetPath)) return;

    final image = AssetImage(assetPath, bundle: rootBundle);
    try {
      await precacheImage(image, context);
      _images[assetPath] = image;
    } catch (e) {
      debugPrint('Failed to preload image $assetPath: $e');
    }
  }

  Future<void> preloadImages(BuildContext context) async {
    List<String> assetPaths = flutterAssetPaths.values.toList();
    await Future.wait(
      assetPaths.map((assetPath) {
        return preloadImage(assetPath, context);
      }),
    );
  }

  Future<void> preloadFlameImages() async {
    // NOTE: all paths are rooted at assets/images/
    List<String> allFlameImages = [
      'SamplePurinArea.png',
      'SamplePurin.png',
      'L7.png',
      "L8.jpg",
      'test_bg.png',
      "purinAreaHome_floor.png",
      "purinAreaHome_stairs.png",
      "purinEntity.png",
      "purinAreaHome_whole.png",
      "purinAreaHome_kotatsu.png",
      "purinAreaHome_kotatsu_blue.png",
      "Kotatsu_default.png",
      "Kotatsu_blue.png",
      "pomPoints_icon.png",

      "consumable_sprites/pudding/1.png",
      "consumable_sprites/pudding/2.png",
      "consumable_sprites/pizza/1.png",
      "consumable_sprites/pizza/2.png",
      "consumable_sprites/pizza/3.png",
      "consumable_sprites/pizza/4.png",
      "consumable_sprites/pancakes/1.png",
      "consumable_sprites/pancakes/2.png",
      "consumable_sprites/pancakes/3.png",
      'consumable_sprites/hamburg_steak/1.png',
      'consumable_sprites/hamburg_steak/2.png',
      'consumable_sprites/hamburg_steak/3.png',
      'consumable_sprites/hamburg_steak/4.png',
      'consumable_sprites/hamburg_steak/5.png',

      "purin_sprites/boku_spritesheet.png",
      "purin_sprites/pumpkin_spritesheet.png",
      "purin_sprites/summer_spritesheet.png",
      "purin_sprites/bee_spritesheet.png",
      "purin_sprites/pika_spritesheet.png",
      "purin_sprites/yana_spritesheet.png",

      "kotatsu_sprites/pudding.png",
      "kotatsu_sprites/aqua.png",
      "floor_sprites/smooth.png",
      "interior_wall_sprites/smooth.png",
      "exterior_sprites/plain.png",
      "blanket_sprites/cyan.png",
      "futon_sprites/cyan.png",
      "refrigerator_sprites/default.png",
      "study_table_sprites/wooden.png",
      "study_chair_sprites/default.png",
      "kitchen_sprites/default.png",
      "kitchen_processors_sprites/stove.png",
      "kitchen_processors_sprites/sink.png",
      "kitchen_processors_sprites/choppingBoard.png",
      "kitchen_processors_sprites/mixer.png",
      "kitchen_processors_sprites/oven.png",
      "shop_sprites/shop.png",
    ];

    await Flame.images.loadAll(allFlameImages);
  }

  /// Lazy-load a shop image only when needed
  Future<void> lazyLoadShopImage(String assetPath, BuildContext context) async {
    if (_images.containsKey(assetPath) || _lazyLoaded[assetPath] == true) {
      return;
    }

    _lazyLoaded[assetPath] = true;
    await preloadImage(assetPath, context);
  }

  Future<void> loadFonts() async {
    Text(' ', style: TextStyle(fontFamily: 'Nunito'));
    Text(
      ' ',
      style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w500),
    );
    Text(' ', style: TextStyle(fontFamily: 'Fredoka'));
    Text(
      ' ',
      style: TextStyle(fontFamily: 'Fredoka', fontWeight: FontWeight.w500),
    );
  }

  /// Retrieve a preloaded image
  ImageProvider? getImage(String assetPath) => _images[assetPath];

  /// Check if preloaded
  bool isPreloaded(String assetPath) => _images.containsKey(assetPath);
  /*
  final Map<String, AudioPlayer> _audioPlayers = {};

  Future<void> preloadAudio(String assetPath) async {
    if (_audioPlayers.containsKey(assetPath)) return;

    final player = AudioPlayer();
    try {
      await player.setSourceAsset(assetPath);
      _audioPlayers[assetPath] = player;
    } catch (e) {
      debugPrint('Failed to preload audio $assetPath: $e');
    }
  }
  
  /// Play an audio clip
  Future<void> playAudio(String assetPath) async {
    final player = _audioPlayers[assetPath];
    if (player != null) {
      await player.resume(); // Already preloaded
    } else {
      // fallback: load and play once
      final tempPlayer = AudioPlayer();
      await tempPlayer.setSourceAsset(assetPath);
      await tempPlayer.resume();
    }
  }

  /// Stop an audio clip
  Future<void> stopAudio(String assetPath) async {
    final player = _audioPlayers[assetPath];
    if (player != null) await player.stop();
  }
*/

  void clearImageCache() {
    _images.clear();
    _lazyLoaded.clear();
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  /*
  void clearAudioCache() {
    _audioPlayers.clear();
  }
*/
}
