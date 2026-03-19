import 'package:just_audio/just_audio.dart';

class BackgroundMusic {
  // Singleton instance
  static final BackgroundMusic _instance = BackgroundMusic._internal();
  factory BackgroundMusic() => _instance;

  BackgroundMusic._internal();

  final AudioPlayer _player = AudioPlayer();

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    await _player.setLoopMode(LoopMode.one);
    _isInitialized = true;
  }

  Future<void> play(String assetPath) async {
    await init();

    try {
      await _player.setAsset(assetPath);
      await _player.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> resume() async {
    // just_audio resumes with play()
    await _player.play();
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
