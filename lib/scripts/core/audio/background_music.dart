import 'package:just_audio/just_audio.dart';

class BackgroundMusic {
  // Singleton
  static final BackgroundMusic _instance = BackgroundMusic._internal();
  factory BackgroundMusic() => _instance;

  BackgroundMusic._internal();

  final AudioPlayer _player = AudioPlayer();

  bool _isInitialized = false;
  String? _currentAsset;

  double _volume = 1.0;

  double get volume => _volume;

  Future<void> init() async {
    if (_isInitialized) return;

    await _player.setLoopMode(LoopMode.one);
    await _player.setVolume(_volume);

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
    _currentAsset = null;
  }

  Future<void> setVolume(double volume) async {
    _volume = volume; // update stored value
    await _player.setVolume(_volume);
  }

  Future<void> fadeIn({
    double targetVolume = 1.0,
    double duration = 2.0,
  }) async {
    const int steps = 20;
    double stepVolume = targetVolume / steps;
    double stepDuration = duration / steps;

    await _player.setVolume(0.0); // start from silent
    _volume = 0.0;

    if (!_player.playing) {
      await _player.play();
    }

    for (int i = 1; i <= steps; i++) {
      _volume = stepVolume * i;
      await _player.setVolume(_volume);
      await Future.delayed(
        Duration(milliseconds: (stepDuration * 1000).round()),
      );
    }

    _volume = targetVolume;
    await _player.setVolume(_volume);
  }

  Future<void> fadeOut({double duration = 2.0}) async {
    const int steps = 20;
    double stepVolume = _volume / steps;
    double stepDuration = duration / steps;

    for (int i = 1; i <= steps; i++) {
      _volume -= stepVolume;
      if (_volume < 0) _volume = 0;
      await _player.setVolume(_volume);
      await Future.delayed(
        Duration(milliseconds: (stepDuration * 1000).round()),
      );
    }

    _volume = 0.0;
    await _player.setVolume(0.0);
    await _player.pause();
  }

  Future<void> fadeTo({
    required double targetVolume,
    double duration = 2.0,
  }) async {
    const int steps = 20; // number of increments
    double startVolume = _volume;
    double stepDuration = duration / steps;
    double stepVolume = (targetVolume - startVolume) / steps;

    for (int i = 1; i <= steps; i++) {
      _volume = (startVolume + stepVolume * i).clamp(0.0, 1.0);
      await _player.setVolume(_volume);
      await Future.delayed(
        Duration(milliseconds: (stepDuration * 1000).round()),
      );
    }

    _volume = targetVolume;
    await _player.setVolume(_volume);
  }

  Future<void> load(String assetPath) async {
    await init();

    if (_currentAsset == assetPath) return;

    await _player.setAsset(assetPath);

    await _player.processingStateStream.firstWhere(
      (state) => state == ProcessingState.ready,
    );

    _currentAsset = assetPath;
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
