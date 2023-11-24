import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add task",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              "Title",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter task title",
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              "Add details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter task details",
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.alarm),
                Text("Setup reminder"),
                Spacer(),
                Switch(value: false, onChanged: (value) {}),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.alarm),
                Text("15 minutes before"),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Implement add reminder logic
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}