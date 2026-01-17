import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/task_notes/task_note.dart';
import 'package:pomodoropompurin/scripts/core/task_notes/task_note_manager.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 400,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: Stack(
        children: [
          Positioned(left: 40, child: Text(widget.taskNote.header)),
          Align(
            alignment: AlignmentGeometry.centerRight,
            child: Padding(
              padding: EdgeInsetsGeometry.only(right: 60),
              child: SizedBox(
                height: 35,
                width: 35,
                child: IconButton(
                  iconSize: 30,
                  onPressed: () {
                    taskNoteManager.moveUp(widget.positionIndex);
                  },
                  icon: Icon(
                    Icons.arrow_drop_up_rounded,
                    color: const Color.fromARGB(152, 253, 193, 64),
                    shadows: [
                      const Shadow(
                        color: Color.fromARGB(66, 245, 28, 28),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentGeometry.centerRight,
            child: Padding(
              padding: EdgeInsetsGeometry.only(right: 35),
              child: SizedBox(
                height: 30,
                width: 30,
                child: IconButton(
                  iconSize: 15,
                  onPressed: () {
                    taskNoteManager.moveDown(widget.positionIndex);
                  },
                  icon: Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.white,
                    shadows: [
                      const Shadow(color: Colors.black26, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentGeometry.centerRight,
            child: Padding(
              padding: EdgeInsetsGeometry.only(right: 5),
              child: SizedBox(
                height: 35,
                width: 35,
                child: IconButton(
                  iconSize: 18,
                  onPressed: () {
                    taskNoteManager.deleteTaskNote(widget.taskNote);
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: const Color.fromARGB(255, 255, 141, 141),
                    shadows: [
                      const Shadow(color: Colors.black26, offset: Offset(1, 1)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
