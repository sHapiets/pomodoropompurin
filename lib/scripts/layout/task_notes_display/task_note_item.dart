import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/task_notes/task_note.dart';

class TaskNoteItem extends StatefulWidget {
  const TaskNoteItem({super.key, required this.taskNote});
  final TaskNote taskNote;

  @override
  State<TaskNoteItem> createState() => _TaskNoteItemState();
}

class _TaskNoteItemState extends State<TaskNoteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 400,
      decoration: BoxDecoration(color: const Color.fromARGB(255, 210, 77, 77)),
      child: Stack(
        children: [Positioned(left: 40, child: Text(widget.taskNote.content))],
      ),
    );
  }
}
