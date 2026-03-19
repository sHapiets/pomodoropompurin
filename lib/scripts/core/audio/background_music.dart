import 'package:audioplayers/audioplayers.dart';

class BackgroundMusic {
  // Singleton instance
  static final BackgroundMusic _instance = BackgroundMusic._internal();
  factory BackgroundMusic() => _instance;

  BackgroundMusic._internal();

  final AudioPlayer _player = AudioPlayer();

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    await _player.setReleaseMode(ReleaseMode.loop);
    _isInitialized = true;
  }

  Future<void> play(String assetPath) async {
    await init();
    _player.play(AssetSource(assetPath));
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> resume() async {
    await _player.resume();
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  Future<void> load(String assetPath) async {
    await play(assetPath);
    await stop();
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
