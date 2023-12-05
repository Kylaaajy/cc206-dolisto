import 'package:flutter/material.dart';
import 'package:cc206_dolisto/Features/task_list_screen.dart';
import 'package:cc206_dolisto/Features/delete_task.dart';
import 'package:cc206_dolisto/Features/database_helper.dart';

class HomeDrawer extends StatelessWidget {
  final Function(Task) onTaskAdded;
  final Function(List<Task>) onTasksDeleted;
  final VoidCallback onAddTaskTap;
  final VoidCallback onTaskListTap;
  final Function() onDeletedTaskListTap;
  final VoidCallback onCalendarTap;


  HomeDrawer({
    required this.onTaskAdded,
    required this.onTasksDeleted,
    required this.onAddTaskTap,
    required this.onTaskListTap,
    required this.onDeletedTaskListTap,
    required this.onCalendarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Task List',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: onTaskListTap,
          ),
          ListTile(
            title: Text(
              'Deleted Tasks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: onTaskListTap,
          ),
          ListTile(
            title: Text(
              'Deleted Tasks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () async {
              Navigator.pop(context); // Close the drawer
              final deletedTasks = await _loadDeletedTasks();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeletedTaskScreen(
                    deletedTasks: deletedTasks,
                    onDeletedTaskListTap: onDeletedTaskListTap,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Calendar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: onCalendarTap, 
          ),
        ],
      ),
    );
  }
}

Future<List<Task>> _loadDeletedTasks() async {
  try {
    final DatabaseHelper databaseHelper = DatabaseHelper.instance;
    final List<Map<String, dynamic>> maps =
        await (await databaseHelper.database).query('deleted_tasks');

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  } catch (e) {
    print('Failed to load deleted tasks: $e');
    return [];
  }
}