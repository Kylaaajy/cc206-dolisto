import 'package:flutter/material.dart';
import 'package:cc206_dolisto/Features/task_list_screen.dart';
import 'features/add_task.dart';
import 'package:cc206_dolisto/Features/delete_task.dart';


void main() {
  runApp(MyApp());
}

class Task {
  String name;
  String details;
  DateTime dueDate;
  bool isDone;

  Task(this.name, this.details, this.dueDate, this.isDone);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/tasklistscreen': (context) =>
            TaskListScreen(onDeletedTaskListTap: () {}),
        '/add': (context) => AddTask(),
        'deleted': (context) =>
            DeletedTaskScreen(deletedTasks: [], onDeletedTaskListTap: () {}),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TaskListScreen(onDeletedTaskListTap: () {}),
    );
  }
}