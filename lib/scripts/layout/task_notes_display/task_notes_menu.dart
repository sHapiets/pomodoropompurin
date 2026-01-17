import 'package:flutter/material.dart';
import 'package:pomodoropompurin/scripts/core/task_notes/task_note.dart';
import 'package:pomodoropompurin/scripts/core/task_notes/task_note_manager.dart';
import 'package:pomodoropompurin/scripts/layout/task_notes_display/task_note_item.dart';

class TaskNotesMenu extends StatefulWidget {
  const TaskNotesMenu({super.key});

  @override
  State<TaskNotesMenu> createState() => _TaskNotesMenuState();
}

class _TaskNotesMenuState extends State<TaskNotesMenu> {
  final taskNotesManager = TaskNoteManager.singleton;

  @override
  void initState() {
    super.initState();

    /* taskNotesManager.taskNotes.map((taskNote) {
      taskNoteItems.add(TaskNoteItem(taskNote: taskNote));
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 300,
      decoration: BoxDecoration(
        color: const Color.fromARGB(0, 151, 148, 120),
        borderRadius: BorderRadius.circular(10),
      ),

      child: Stack(
        children: [
          Positioned(
            bottom: -10,
            right: 0,
            child: Container(
              width: 390,
              height: 250,
              decoration: BoxDecoration(
                color: const Color.fromARGB(237, 193, 131, 15),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 390,
              height: 250,
              decoration: BoxDecoration(
                color: const Color.fromARGB(145, 255, 186, 81),
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
                shadows: [Shadow(color: Colors.black38, offset: Offset(3, 3))],
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 150,
            child: IconButton(
              iconSize: 28,
              onPressed: () {
                taskNotesManager.addTaskNote(
                  TaskNote(header: 'this is', content: 'sparta'),
                );
              },
              icon: Icon(
                Icons.add_box_outlined,
                color: const Color.fromARGB(255, 255, 255, 255),
                shadows: [Shadow(color: Colors.black26, offset: Offset(3, 3))],
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
                shadows: [Shadow(color: Colors.black26, offset: Offset(3, 3))],
              ),
            ),
          ),

          Positioned(
            top: 80,
            left: 25,
            child: Container(
              width: 350,
              height: 230,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(3),
              ),
              child: ValueListenableBuilder(
                valueListenable: taskNotesManager.length,
                builder: (context, value, child) {
                  return (value == 0)
                      ? Center(
                          child: Text(
                            'this list is suspiciously empty...',
                            style: TextStyle(
                              fontFamily: 'Fredoka',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: const Color.fromARGB(183, 179, 179, 179),
                              shadows: [
                                Shadow(
                                  color: const Color.fromARGB(53, 0, 0, 0),
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.all(10),
                          itemCount: value,
                          itemBuilder: (context, index) {
                            return TaskNoteItem(
                              taskNote: taskNotesManager.taskNotes[index],
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
    );
  }
}
