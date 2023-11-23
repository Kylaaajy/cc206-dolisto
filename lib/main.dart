import 'package:flutter/material.dart';
import 'components/home_drawer.dart';
import 'features/add_task.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto-Regular',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TaskManagerHome(),
        '/addTask': (context) => AddTask(),
      },
    );
  }
}

class TaskManagerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Manager",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      drawer: HomeDrawer(), // Add the drawer to the Scaffold
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            "Your Task Manager Home Page",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto-Regular',
            ),
          ),
        ), //
      ),
    );
  }
}
