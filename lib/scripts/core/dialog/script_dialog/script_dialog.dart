import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/tutorial/tutorial_state.dart';

class ScriptDialog extends StatefulWidget {
  final String title;
  final List<String> imagePaths;
  final List<Map<String, String>> dialogues;
  final int mode;
  final bool isStatic;
  final Duration charDelay;
  final Duration transitionDuration;
  final bool hideUIonBegin;
  final VoidCallback? onFinished;
  final VoidCallback? onBegin;

  ScriptDialog({
    Key? key,
    this.title = "",
    required this.imagePaths,
    required this.dialogues,
    this.mode = 0,
    this.isStatic = false,
    this.charDelay = const Duration(milliseconds: 40),
    this.transitionDuration = const Duration(milliseconds: 300),
    this.onBegin,
    this.onFinished,
    this.hideUIonBegin = true,
  }) : super(key: key);

  @override
  _ScriptDialogState createState() => _ScriptDialogState();
}

class _ScriptDialogState extends State<ScriptDialog>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  String _displayedText = '';
  Timer? _typingTimer;
  int _charIndex = 0;
  late AnimationController _fadeController;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: widget.transitionDuration,
    );

    if (widget.onBegin != null) {
      widget.onBegin!();
    }

    _startTyping();
  }

  void _startTyping() {
    _typingTimer?.cancel();
    _charIndex = 0;
    _displayedText = '';
    _fadeController.forward(from: 0);

    if (_currentIndex >= widget.dialogues.length) return;

    final currentText = widget.dialogues[_currentIndex].values.first;
    _typingTimer = Timer.periodic(widget.charDelay, (timer) {
      if (_charIndex < currentText.length) {
        setState(() {
          _charIndex++;
          _displayedText = currentText.substring(0, _charIndex);
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _nextDialogue() {
    if (widget.isStatic) {
      return;
    }

    final fullText = widget.dialogues[_currentIndex].values.first;
    if (_displayedText != fullText) {
      setState(() {
        _displayedText = fullText;
        _charIndex = fullText.length;
      });
    } else if (_currentIndex < widget.dialogues.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _startTyping();
    } else {
      _typingTimer?.cancel();
      setState(() {
        _visible = false;
      });
      if (widget.onFinished != null) {
        widget.onFinished!();
      }
    }
  }

  void _skipAll() {
    _typingTimer?.cancel();

    setState(() {
      _visible = false;
    });

    if (widget.onFinished != null) {
      widget.onFinished!();
    }
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) {
      return const SizedBox.shrink();
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double dialogWidth = screenWidth * 0.9;

    final currentDialogue = widget.dialogues[_currentIndex];
    final currentCharacter = currentDialogue.keys.first;
    final currentImage = widget.imagePaths[_currentIndex];

    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: _nextDialogue,
            child: SizedBox(
              width: dialogWidth,
              child: FadeTransition(
                opacity: _fadeController,
                child: Card(
                  color: const Color.fromARGB(217, 255, 255, 255),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(radius: 30),
                            SizedBox(
                              width: 60,
                              child: Image.asset(currentImage),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                currentCharacter,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Fredoka',
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _displayedText,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Fredoka',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        if (!widget.isStatic)
          Positioned(
            top: 40,
            right: 20,
            child: ElevatedButton.icon(
              onPressed: _skipAll,
              icon: const Icon(Icons.skip_next, size: 18),
              label: const Text(
                "skip",
                style: TextStyle(fontSize: 11, fontFamily: 'Fredoka'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black54,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
