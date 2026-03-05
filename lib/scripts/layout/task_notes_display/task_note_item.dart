import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/task_notes/task_note.dart';
import 'package:pomodoropompurin/scripts/core/task_notes/task_note_manager.dart';
import 'package:pomodoropompurin/scripts/layout/task_notes_display/task_note_editor.dart';

class TaskNoteItem extends StatefulWidget {
  const TaskNoteItem({
    super.key,
    required this.taskNote,
    required this.positionIndex,
  });

  final TaskNote taskNote;
  final int positionIndex;

  @override
  State<TaskNoteItem> createState() => _TaskNoteItemState();
}

class _TaskNoteItemState extends State<TaskNoteItem> {
  final taskNoteManager = TaskNoteManager.singleton;

  double scale = 0;
  double waveProgress = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(milliseconds: 10), (timer) {
      scale = 1;
      setState(() {});
      timer.cancel();
    });
  }

  void triggerWave() {
    setState(() {
      waveProgress = 1;
    });

    Future.delayed(Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() {
        waveProgress = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      scale: scale,
      child: GestureDetector(
        onLongPress: () {
          showGeneralDialog(
            context: context,
            barrierColor: Colors.black38,
            transitionDuration: Duration(milliseconds: 500),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              Animation<Offset> offsetAnim =
                  Tween<Offset>(
                    begin: Offset(-1.5, 0),
                    end: Offset(0, 0),
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                    ),
                  );
              return SlideTransition(position: offsetAnim, child: child);
            },
            pageBuilder: (context, animation, secondaryAnimation) {
              return TaskNoteEditor(noteIndex: widget.positionIndex);
            },
          );
        },
        child: Container(
          height: 50,
          width: 400,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              /// SLIDING COLOR WAVE
              AnimatedPositioned(
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeOutCubic,
                left: waveProgress == 1 ? 400 : -400,
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(80, 104, 205, 37),
                  ),
                ),
              ),

              /// MARK AS DONE
              Positioned(
                left: 10,
                top: 10,
                child: GestureDetector(
                  onTap: () {
                    taskNoteManager.toggleDone(widget.positionIndex);
                    if (widget.taskNote.isDone) triggerWave();
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.taskNote.isDone
                          ? Color.fromARGB(255, 111, 178, 55)
                          : Colors.transparent,
                      border: Border.all(
                        color: Color.fromARGB(255, 111, 178, 55),
                        width: 2,
                      ),
                    ),
                    child: widget.taskNote.isDone
                        ? Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                ),
              ),

              Positioned(
                left: 50,
                child: SizedBox(
                  width: 120,
                  height: 20,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    widget.taskNote.header,
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color.fromARGB(183, 0, 0, 0),
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 55,
                top: 18,
                child: SizedBox(
                  width: 120,
                  height: 30,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    widget.taskNote.content,
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Color.fromARGB(183, 100, 100, 100),
                    ),
                  ),
                ),
              ),

              /// MOVE UP
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 45),
                  child: SizedBox(
                    height: 35,
                    width: 35,
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () {
                        taskNoteManager.moveUp(widget.positionIndex);
                      },
                      icon: Icon(
                        Icons.arrow_circle_up_rounded,
                        color: Color.fromARGB(151, 253, 162, 64),
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(66, 245, 28, 28),
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// MOVE DOWN
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: SizedBox(
                    height: 35,
                    width: 35,
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () {
                        taskNoteManager.moveDown(widget.positionIndex);
                      },
                      icon: Icon(
                        Icons.arrow_circle_down_rounded,
                        color: Color.fromARGB(149, 0, 0, 0),
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(66, 74, 74, 74),
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
