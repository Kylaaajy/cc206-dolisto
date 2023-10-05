import 'package:flutter/material.dart';

class add_task extends StatelessWidget {
  const add_task({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Add task"),
          Text("Title"),
          Text("Add details"),
          Icon(Icons.alarm),
          Text("Setup reminder"),
          Switch(value: false, onChanged: (value) {}),
          Icon(Icons.alarm),
          Text("15 minutes before"),
          Icon(Icons.add),
          Text("Add reminder"),
        ],
      ),
    );
  }
}