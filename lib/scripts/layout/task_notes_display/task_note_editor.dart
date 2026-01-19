import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/task_notes/task_note.dart';
import 'package:pomodoropompurin/scripts/core/task_notes/task_note_manager.dart';

class TaskNoteEditor extends StatefulWidget {
  const TaskNoteEditor({super.key, required this.noteIndex});

  final int noteIndex;

  @override
  State<TaskNoteEditor> createState() => _TaskNoteEditorState();
}

class _TaskNoteEditorState extends State<TaskNoteEditor> {
  final taskNoteManager = TaskNoteManager.singleton;
  late TaskNote taskNote;
  late TextEditingController headerController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();

    taskNote = taskNoteManager.taskNotes[widget.noteIndex];
    headerController = TextEditingController(text: taskNote.header);
    contentController = TextEditingController(text: taskNote.content);
  }

  @override
  void dispose() {
    headerController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: AlignmentGeometry.center,
        child: Transform.translate(
          offset: Offset(0, -100),
          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(0, 255, 255, 255),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 290,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(124, 137, 137, 137),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 40,
                  child: Container(
                    width: 290,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),

                /// HEADERCONTROLLER
                Positioned(
                  left: 30,
                  top: 60,
                  child: SizedBox(
                    height: 40,
                    width: 200,
                    child: TextField(
                      controller: headerController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Color.fromARGB(183, 0, 0, 0),
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(125, 0, 0, 0),
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.text_fields_rounded),
                        isDense: true,
                        contentPadding: EdgeInsets.only(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                        ),
                        border: InputBorder.none,
                        hintText: '-note header-',
                        hintStyle: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Color.fromARGB(126, 137, 137, 137),
                          shadows: [],
                        ),
                      ),
                    ),
                  ),
                ),

                /// CONTENTHEADER
                Positioned(
                  left: 30,
                  top: 100,
                  child: SizedBox(
                    height: 50,
                    width: 240,
                    child: TextField(
                      controller: contentController,
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: Color.fromARGB(183, 0, 0, 0),
                      ),
                      maxLines: 3,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.notes_rounded),
                        isDense: true,
                        contentPadding: EdgeInsets.only(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                        ),
                        border: InputBorder.none,
                        hintText:
                            '- subnotes or details -\n- multiline via enter...',
                        hintStyle: TextStyle(
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: Color.fromARGB(126, 137, 137, 137),
                          shadows: [],
                        ),
                      ),
                    ),
                  ),
                ),

                /// SAVE BUTTON
                Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: Transform.translate(
                    offset: Offset(-80, -15),
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () {
                        taskNoteManager.editTaskNote(
                          widget.noteIndex,
                          headerController.text,
                          contentController.text,
                        );
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.save_as_outlined, color: Colors.black),
                    ),
                  ),
                ),

                /// CANCEL BUTTON
                Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: Transform.translate(
                    offset: Offset(-30, -15),
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.cancel_outlined, color: Colors.black),
                    ),
                  ),
                ),

                /// DELETE BUTTON
                Align(
                  alignment: AlignmentGeometry.bottomLeft,
                  child: Transform.translate(
                    offset: Offset(30, -15),
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () {
                        taskNoteManager.deleteTaskNote(taskNote);
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                      ),
                    ),
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
