import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/task_notes/task_note.dart';
import 'package:pomodoropompurin/scripts/core/task_notes/task_note_manager.dart';
import 'package:pomodoropompurin/scripts/layout/task_notes_display/task_note_editor.dart';
import 'package:pomodoropompurin/scripts/layout/task_notes_display/task_note_item.dart';

class TaskNotesMenu extends StatefulWidget {
  const TaskNotesMenu({super.key});

  @override
  State<TaskNotesMenu> createState() => _TaskNotesMenuState();
}

class _TaskNotesMenuState extends State<TaskNotesMenu> {
  final taskNotesManager = TaskNoteManager.singleton;

  late Widget addTaskNoteButton;

  @override
  void initState() {
    super.initState();

    /* taskNotesManager.taskNotes.map((taskNote) {
      taskNoteItems.add(TaskNoteItem(taskNote: taskNote));
    }); */

    addTaskNoteButton = IconButton(
      iconSize: 28,
      onPressed: () {
        taskNotesManager.addTaskNote(TaskNote(header: '', content: ''));
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
                  CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
                );
            return SlideTransition(position: offsetAnim, child: child);
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            return TaskNoteEditor(
              noteIndex: taskNotesManager.taskNotes.length - 1,
            );
          },
        );
      },
      icon: Icon(
        Icons.add_box_sharp,
        color: const Color.fromARGB(255, 255, 183, 95),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        width: 330,
        height: 300,
        decoration: BoxDecoration(
          color: const Color.fromARGB(0, 151, 148, 120),
          borderRadius: BorderRadius.circular(10),
        ),

        child: Stack(
          children: [
            Positioned(
              bottom: -5,
              right: 15,
              child: Container(
                width: 310,
                height: 250,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 196, 120, 49),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Positioned(
              bottom: -10,
              left: 0,
              child: Container(
                width: 320,
                height: 260,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(167, 236, 180, 84),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                'task notes',
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.black38, offset: Offset(3, 3)),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 12,
              right: 10,
              child: IconButton(
                iconSize: 28,
                onPressed: () {
                  Navigator.pop((context));
                },
                icon: Icon(
                  Icons.arrow_drop_down_circle_sharp,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  shadows: [
                    Shadow(color: Colors.black26, offset: Offset(3, 3)),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 75,
              left: 20,
              child: Container(
                width: 280,
                height: 230,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListenableBuilder(
                  listenable: taskNotesManager,
                  builder: (context, child) {
                    return (taskNotesManager.noTasks)
                        ? Column(
                            children: [
                              Center(child: addTaskNoteButton),
                              Center(
                                child: Text(
                                  'add your task notes here',
                                  style: TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: const Color.fromARGB(
                                      183,
                                      255,
                                      161,
                                      53,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : ListView.separated(
                            padding: EdgeInsets.all(10),
                            itemCount: taskNotesManager.taskNotes.length + 1,
                            itemBuilder: (context, index) {
                              if (index == taskNotesManager.taskNotes.length) {
                                return addTaskNoteButton;
                              }

                              return TaskNoteItem(
                                taskNote: taskNotesManager.taskNotes[index],
                                positionIndex: index,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(height: 5, thickness: 3);
                            },
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
