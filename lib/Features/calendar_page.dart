import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cc206_dolisto/Features/task_list_screen.dart';

class CalendarPage extends StatefulWidget {
  final List<Task> tasks;

  CalendarPage({required this.tasks});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Task> getTasksForSelectedDay() {
    if (_selectedDay == null) return [];
    return widget.tasks.where((task) {
      // Compare tasks' due dates with the selected day
      return task.dueDate.year == _selectedDay!.year &&
          task.dueDate.month == _selectedDay!.month &&
          task.dueDate.day == _selectedDay!.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendar',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            focusedDay: _focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
          ),
          Text(
            'Tasks for ${_selectedDay != null ? _selectedDay!.toLocal().toString().split(' ')[0] : 'Select a date'}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: getTasksForSelectedDay().length,
                itemBuilder: (context, index) {
                  final task = getTasksForSelectedDay()[index];
                  return ListTile(
                    title: Text(task.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Details: ${task.details}'),
                        Text('Due Date: ${task.dueDate.toLocal()}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
