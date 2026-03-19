import 'package:just_audio/just_audio.dart';

class BackgroundMusic {
  // Singleton
  static final BackgroundMusic _instance = BackgroundMusic._internal();
  factory BackgroundMusic() => _instance;

  BackgroundMusic._internal();

  final AudioPlayer _player = AudioPlayer();

  bool _isInitialized = false;
  String? _currentAsset;

  Future<void> init() async {
    if (_isInitialized) return;

    await _player.setLoopMode(LoopMode.one);
    await _player.setVolume(1.0);

    _isInitialized = true;
  }

  Future<void> play(String assetPath) async {
    await init();

    try {
      if (_currentAsset != assetPath) {
        await _player.setAsset(assetPath);
        _currentAsset = assetPath;
      }

      await _player.play();
    } catch (e) {
      print('BGM ERROR: $e');
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
    _currentAsset = null; // reset so next play reloads
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
