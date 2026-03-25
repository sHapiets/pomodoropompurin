import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/audio/background_music.dart';
import 'package:pomodoropompurin/scripts/memory/database_manager.dart';

class VolumeControlWidget extends StatefulWidget {
  const VolumeControlWidget({super.key});

  @override
  State<VolumeControlWidget> createState() => _VolumeControlWidgetState();
}

class _VolumeControlWidgetState extends State<VolumeControlWidget> {
  final BackgroundMusic _bgm = BackgroundMusic();
  double _volume = 1.0;
  double _initialVolume = 1.0; // store initial value
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _volume = _bgm.volume;
    _initialVolume = _volume; // save initial volume
    _isMuted = _volume == 0.0;
  }

  void _onVolumeChanged(double newVolume) {
    setState(() {
      _volume = newVolume;
      _isMuted = _volume == 0.0;
    });
    _bgm.setVolume(_volume);
  }

  Widget _buildSaveCancelButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: _onCancel,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            foregroundColor: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 75, 75, 75),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Save',
            style: TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ],
    );
  }

  void _toggleMute() {
    setState(() {
      if (_isMuted) {
        _volume = 0.5; // restore to 50% when unmuting
      } else {
        _volume = 0.0;
      }
      _isMuted = !_isMuted;
    });
    _bgm.setVolume(_volume);
  }

  void _onSave() {
    _initialVolume = _volume;
    DatabaseManager.singleton.configVolumeSave(_volume);
    Navigator.pop(context);
  }

  void _onCancel() {
    setState(() {
      _volume = _initialVolume;
      _isMuted = _volume == 0.0;
      _bgm.setVolume(_volume);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Container(
            width: 300,
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(10, 10),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Stack(
              children: [
                /// Volume slider + text + buttons
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isMuted
                            ? 'Muted'
                            : 'Volume: ${(_volume * 100).round()}%',
                        style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.amber,
                            inactiveTrackColor: Colors.grey[300],
                            thumbColor: Colors.amber,
                            overlayColor: Colors.amber.withOpacity(0.2),
                            valueIndicatorColor: Colors.amber,
                            trackHeight: 8,
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 12,
                            ),
                          ),
                          child: Slider(
                            value: _volume,
                            onChanged: _onVolumeChanged,
                            min: 0.0,
                            max: 1.0,
                            divisions: 100,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        onPressed: _toggleMute,
                        icon: Icon(
                          _isMuted ? Icons.volume_off : Icons.volume_up,
                          size: 36,
                          color: Colors.amber,
                        ),
                      ),
                      SizedBox(height: 15),
                      _buildSaveCancelButtons(), // buttons row
                    ],
                  ),
                ),

                /// Close button
                Positioned(
                  top: 15,
                  right: 20,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: Colors.grey[800]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
