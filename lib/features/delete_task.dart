import 'package:flutter/material.dart';

class DeleteTask extends StatelessWidget {
  const DeleteTask({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: Text("Deleted Task"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start of the column
        children: [
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (value) {},
              ),
              Text('Clean'),
            ],
          ),
          Row(
            children: [
              Text('Yesterday, 8:00 am'),
              Spacer(), // Add space to push the delete icon to the end
              Icon(Icons.delete),
              Text('Delete'),
            ],
          ),
        ],
      ),
    );
  }
}