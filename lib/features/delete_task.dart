import 'package:flutter/material.dart';
import 'package:cc206_dolisto/Features/database_helper.dart';
import 'package:cc206_dolisto/Features/task_list_screen.dart';
import 'package:cc206_dolisto/Components/home_drawer.dart';

class DeletedTaskScreen extends StatefulWidget {
  final List<Task> deletedTasks;
  final VoidCallback onDeletedTaskListTap;

  DeletedTaskScreen({
    required this.deletedTasks,
    required this.onDeletedTaskListTap,
  });

  @override
  _DeletedTaskScreenState createState() => _DeletedTaskScreenState();
}

class _DeletedTaskScreenState extends State<DeletedTaskScreen> {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<Task> deletedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadDeletedTasks();
  }

  Future<void> _loadDeletedTasks() async {
    final List<Map<String, dynamic>> maps =
        await databaseHelper.queryTasks('deleted_tasks');

    setState(() {
      deletedTasks = List.generate(maps.length, (i) {
        return Task.fromMap(maps[i]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Deleted Tasks',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: HomeDrawer(
        onTaskAdded: (_) {},
        onTasksDeleted: (_) {},
        onAddTaskTap: () {
          Navigator.pushNamed(context, '/add');
        },
        onTaskListTap: () {
          Navigator.pushReplacementNamed(context, '/tasklistscreen');
        },
        onDeletedTaskListTap: widget.onDeletedTaskListTap,
        onCalendarTap: () {
          Navigator.pushNamed(context, '/calendar');
        },
      ),
      body: ListView.builder(
        itemCount: deletedTasks.length,
        itemBuilder: (context, index) {
          final task = deletedTasks[index];
          return ListTile(
            title: Text(task.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Details: ${task.details}'),
                Text('Due Date: ${task.dueDate.toLocal()}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.restore),
              onPressed: () {
                _restoreTask(task);
              },
            ),
          );
        },
      ),
    );
  }

  void _restoreTask(Task task) async {
    try {
      // Add the task back to the tasks table in the database
      await (await databaseHelper.database).insert('tasks', task.toMap());

      // Remove the task from the deletedTasks list
      setState(() {
        widget.deletedTasks.remove(task);
      });

      // Inform the parent screen about the restoration
      widget.onDeletedTaskListTap();
    } catch (e) {
      // Handle any potential exceptions during restoration
      print('Failed to restore task: $e');
    }
  }
}