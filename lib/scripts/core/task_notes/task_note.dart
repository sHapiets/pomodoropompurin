/// The TaskNote class is an object that represents a temporary note
/// for personal usage throughout the current session. All instances
/// are stored in the TaskNoteManager singleton as an ordered list, with
/// several methods and functions to modify the TaskNotes themselves and
/// the list as well.
///
/// Handling its display is quite different though. More information about
/// TaskNoteItems and other related widgets are written within their
/// respective classes as header comments, as such seen here. But I recommend
/// checking the TaskNoteManager first, since associated widgets mostly
/// communicate with it to function.
class TaskNote {
  TaskNote({required this.header, required this.content});

  String header;
  String content;

  bool isDone = false;
}
