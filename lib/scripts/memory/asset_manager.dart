import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

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

  /// Lazy-load a shop image only when needed
  Future<void> lazyLoadShopImage(String assetPath, BuildContext context) async {
    if (_images.containsKey(assetPath) || _lazyLoaded[assetPath] == true) {
      return;
    }

    _lazyLoaded[assetPath] = true;
    await preloadImage(assetPath, context);
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

  // ------------------------
  // OPTIONAL: Clear caches
  // ------------------------
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
