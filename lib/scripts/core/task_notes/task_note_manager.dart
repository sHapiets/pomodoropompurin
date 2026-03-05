import 'package:flutter/foundation.dart';
import 'package:pomodoropompurin/scripts/core/task_notes/task_note.dart';

/// This singleton class simply acts as a listenable state
/// manager, that allows reactive building within associated widgets.
/// It contains an ordered list of TaskNote objects currently active
/// within the session, and can be modified via the functions I've
/// added below.
///
/// Please note that methods relating to storing notes into memory
/// in any shape or form has NOT been added, since PRIVACY, as pertaining
/// to the initial scope of this project, is very minimal. If the future
/// insists of this addition, this note serves as a reminder that if such
/// plans are to be executed, reviewing the privacy capabilities of
/// the database (access and viewablity) is extremely necessary.
class TaskNoteManager extends ChangeNotifier {
  TaskNoteManager._();
  static final singleton = TaskNoteManager._();
  bool get noTasks => taskNotes.isEmpty;

  List<TaskNote> taskNotes = <TaskNote>[];

  void addTaskNote(TaskNote newTaskNote) {
    taskNotes.add(newTaskNote);
    notifyListeners();
  }

  void editTaskNote(int noteIndex, String header, String content) {
    taskNotes[noteIndex].header = header;
    taskNotes[noteIndex].content = content;
    notifyListeners();
  }

  void toggleDone(int index) {
    taskNotes[index].isDone = !taskNotes[index].isDone;
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
