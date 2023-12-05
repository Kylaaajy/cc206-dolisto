import 'package:flutter/material.dart';
import 'package:cc206_dolisto/Features/add_task.dart';
import 'package:cc206_dolisto/Features/delete_task.dart';
import 'package:cc206_dolisto/Components/home_drawer.dart';
import 'package:cc206_dolisto/Features/database_helper.dart';
import 'package:cc206_dolisto/Features/calendar_page.dart';

class Task {
  int? id; // Add an id field for database operations
  String name;
  String details;
  DateTime dueDate;
  bool isDone;

  Task(
      {this.id,
      required this.name,
      required this.details,
      required this.dueDate,
      required this.isDone});

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'name': name,
      'details': details,
      'dueDate': dueDate.toIso8601String(),
      'isDone': isDone ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      details: map['details'],
      dueDate: DateTime.parse(map['dueDate']),
      isDone: map['isDone'] == 1,
    );
  }
}

class TaskListScreen extends StatefulWidget {
  final VoidCallback onDeletedTaskListTap;

  TaskListScreen({
    required this.onDeletedTaskListTap,
  });

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<Task> tasks = [];
  List<Task> deletedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final List<Map<String, dynamic>> taskMaps =
        await databaseHelper.queryTasks('tasks');
    final List<Map<String, dynamic>> deletedTaskMaps =
        await databaseHelper.queryTasks('deleted_tasks');

    setState(() {
      tasks = List.generate(taskMaps.length, (i) {
        return Task.fromMap(taskMaps[i]);
      });

      deletedTasks = List.generate(deletedTaskMaps.length, (i) {
        return Task.fromMap(deletedTaskMaps[i]);
      });
    });
  }

  void _navigateToTaskListScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TaskListScreen(onDeletedTaskListTap: () {}),
      ),
    );
  }

  void _navigateToDeletedTaskScreen(BuildContext context) async {
    final deletedTasks = await _loadDeletedTasks();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeletedTaskScreen(
          deletedTasks: deletedTasks,
          onDeletedTaskListTap: widget.onDeletedTaskListTap,
        ),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    // Sort tasks by due date before displaying
    tasks.sort((a, b) {
      if (a.isDone && !b.isDone) {
        return 1; // Move completed task to the end
      } else if (!a.isDone && b.isDone) {
        return -1; // Keep incomplete task first
      } else {
        return a.dueDate.compareTo(b.dueDate);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dolisto',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: HomeDrawer(
        onTaskAdded: (task) {
          setState(() {
            tasks.add(task);
          });
        },
        onTasksDeleted: (tasksToDelete) {
          setState(() {
            deletedTasks.addAll(tasksToDelete);
            tasks.removeWhere((task) => tasksToDelete.contains(task));
          });
        },
        onTaskListTap: () {
          Navigator.pop(context); // Close the drawer
          _navigateToTaskListScreen(context); // Navigate to TaskListScreen
        },
        onDeletedTaskListTap: () {
          Navigator.pop(context); // Close the drawer
          _navigateToDeletedTaskScreen(
              context); // Navigate to DeletedTaskScreen
        },
        onAddTaskTap: () {
          // Handle the 'Add Task' action
          _navigateToAddTask(context);
        },
        onCalendarTap: () {
          Navigator.pop(context); // Close the drawer
          _navigateToCalendarScreen(context); // Navigate to CalendarPage
        },
      ),
      body: Column(
        children: [
          Text(
            'Task', // Added "Task" text as a title
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(
                    task.name,
                    style: TextStyle(
                      decoration:
                          task.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Details: ${task.details}'),
                      Text('Due Date: ${task.dueDate.toLocal()}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: task.isDone,
                        onChanged: (value) {
                          _toggleTask(context, index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteTask(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _navigateToAddTask(context);
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _navigateToCalendarScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CalendarPage(tasks: tasks), // Navigate to CalendarPage
      ),
    );
  }

  void _toggleTask(BuildContext context, int index) async {
    Task toggledTask = tasks[index];
    toggledTask.isDone = !toggledTask.isDone;

    await (await databaseHelper.database).update('tasks', toggledTask.toMap(),
        where: 'id = ?', whereArgs: [toggledTask.id]);
    _loadTasks();
  }

  void _deleteTask(int index) async {
    Task deletedTask = tasks[index];

    // Remove the task from the tasks list
    setState(() {
      tasks.removeAt(index);
    });

    // Delete the task from the database
    await databaseHelper.deleteTask(deletedTask.id!);
    await databaseHelper.insertTask('deleted_tasks', deletedTask.toMap());
    // The database will automatically generate a unique ID for deleted_tasks table

    // Pass the deleted task to DeletedTaskScreen
    widget.onDeletedTaskListTap();
  }

  void _navigateToAddTask(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTask(),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      final task = Task(
        name: result['name'],
        details: result['details'],
        dueDate: result['dueDate'],
        isDone: result['isDone'],
      );

      await (await databaseHelper.database).insert('tasks', task.toMap());
      _loadTasks();
    }
  }

  void _restoreTask(BuildContext context, int index) async {
    Task restoredTask = deletedTasks[index];

    try {
      // Add the task back to the tasks table in the database
      await databaseHelper.insertTask('tasks', restoredTask.toMap());

      // Remove the task from the deletedTasks list
      setState(() {
        deletedTasks.removeAt(index);
      });

      // Inform the parent screen about the restoration
      widget.onDeletedTaskListTap();
    } catch (e) {
      // Handle any potential exceptions during restoration
      print('Failed to restore task: $e');
    }
  }
}
