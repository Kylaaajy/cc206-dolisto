import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  DateTime? _selectedDate; // Make _selectedDate nullable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _detailsController,
              decoration:
                  InputDecoration(labelText: 'Details'), // Add details field
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Due Date:'),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text(
                    _selectedDate != null
                        ? '${_selectedDate!.toLocal()}'.split(' ')[0]
                        : 'Select Date',
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addTask();
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addTask() {
    if (_taskController.text.isNotEmpty && _selectedDate != null) {
      //Use a callback function to pass the task to the previous screen.
      Navigator.pop(
        context,
        {
          'name': _taskController.text,
          'details': _detailsController.text,
          'dueDate': _selectedDate!,
          'isDone': false,
        },
      );
    }
  }
}
