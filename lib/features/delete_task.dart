import 'package:flutter/material.dart';

class DeleteTask extends StatelessWidget {
  const DeleteTask({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Icon(Icons.check_box),
          Checkbox(
            value: false,
            onChanged: (value) {},
          ),
          Text('Clean'),
          Text('Yesterday, 8:00 am'),
          Icon(Icons.delete),
          Text('Delete'),
        ],
      ),
    );
  }
}