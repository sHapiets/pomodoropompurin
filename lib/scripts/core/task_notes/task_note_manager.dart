import 'package:flutter/foundation.dart';
import 'package:pomodoropompurin/scripts/core/task_notes/task_note.dart';

class TaskNoteManager {
  TaskNoteManager._();
  static final singleton = TaskNoteManager._();

  List<TaskNote> taskNotes = <TaskNote>[];
  ValueNotifier<int> length = ValueNotifier(0);

  void addTaskNote(TaskNote newTaskNote) {
    taskNotes.add(newTaskNote);
    length.value = taskNotes.length;
  }

  bool get noTasks => taskNotes.isEmpty;
}
