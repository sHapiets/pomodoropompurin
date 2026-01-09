import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';

/// Singleton class to manage all game assets
class AssetManager {
  AssetManager._internal();
  static final AssetManager singleton = AssetManager._internal();

  final Map<String, ImageProvider> _images = {}; // Preloaded images
  final Map<String, bool> _lazyLoaded = {}; // Tracks lazy-loaded shop assets

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

  Future<void> preloadImages(
    List<String> assetPaths,
    BuildContext context,
  ) async {
    await Future.wait(
      assetPaths.map((assetPath) {
        return preloadImage(assetPath, context);
      }),
    );
  }

  Future<void> preloadFlameImages() async {
    List<String> allFlameImages = [
      'SamplePurinArea.png',
      'L7.png',
      "SamplePurin.png",
      "L8.jpg",
      'test_bg.png',
      "purinAreaHome_floor.png",
      "purinAreaHome_stairs.png",
    ];

    for (String imagePath in allFlameImages) {
      await Flame.images.load(imagePath);
    }
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

  /// Preload a short audio clip
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
