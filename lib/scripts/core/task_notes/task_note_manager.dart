import 'package:flutter/foundation.dart';
import 'package:pomodoropompurin/scripts/core/task_notes/task_note.dart';

class TaskNoteManager extends ChangeNotifier {
  TaskNoteManager._();
  static final singleton = TaskNoteManager._();
  bool get noTasks => taskNotes.isEmpty;

  List<TaskNote> taskNotes = <TaskNote>[];

  void addTaskNote(TaskNote newTaskNote) {
    taskNotes.add(newTaskNote);
    notifyListeners();
  }

  void moveUp(int noteIndex) {
    if (noteIndex >= 1) {
      TaskNote taskNotePlaceholder = taskNotes[noteIndex];
      taskNotes.removeAt(noteIndex);
      taskNotes.insert(noteIndex - 1, taskNotePlaceholder);
      notifyListeners();
    }
  }

  void moveDown(int noteIndex) {
    if (noteIndex < taskNotes.length - 1) {
      TaskNote taskNotePlaceholder = taskNotes[noteIndex];
      taskNotes.removeAt(noteIndex);
      taskNotes.insert(noteIndex + 1, taskNotePlaceholder);
      notifyListeners();
    }
  }

  void deleteTaskNote(TaskNote deleteTaskNote) {
    taskNotes.remove(deleteTaskNote);
    notifyListeners();
  }
}
