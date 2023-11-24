import 'package:flutter/material.dart';
import 'components/home_drawer.dart';
import 'features/add_task.dart';

void main() {
//<<<<<<< deleted_task_Sermonia_Ordinario
  runApp(const TaskManagerApp());
//=======
  runApp(TaskManagerApp());
//>>>>>>> master
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
// deleted_task_Sermonia_Ordinario
        '/deletedTask': (context) => DeletedTask(),
        '/addTask': (context) => AddTask(),
      },
    );
  }
}

class DeletedTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Deleted Task", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const Text('Clean', style: TextStyle(color: Colors.white)),
              ],
            ),
            Row(
              children: [
                const Text('Yesterday, 8:00 am',
                    style: TextStyle(color: Colors.white)),
                const Spacer(),
                const Icon(Icons.delete, color: Colors.white),
                const Text('Delete', style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*class TaskManagerHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
// deleted_task_Sermonia_Ordinario
        title: const Text("Deleted Task", style: TextStyle(color: Colors.white)), 
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const Text('Clean', style: TextStyle(color: Colors.white)), 
              ],
            ),
            Row(
              children: [
                const Text('Yesterday, 8:00 am', style: TextStyle(color: Colors.white)), 
                const Spacer(),
                const Icon(Icons.delete, color: Colors.white), 
                const Text('Delete', style: TextStyle(color: Colors.white)), 
              ],
=======
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
//<<<<<<< deleted_task_Sermonia_Ordinario
    );
  }
}*/

class TaskManagerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Manager",
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      ),
      drawer: const HomeDrawer(),
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
        ),
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: ListView(
        children: [
          ListTile(
            title: const Text(
              'Deleted Task',
              style: TextStyle(
                color: Colors.white, // Set the text color of the drawer item
                fontSize: 18.0,
                fontFamily: 'CustomFont', // Apply the custom font
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Container(
                    color: Colors.blue,
                    child: DeletedTask(),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Add Task',
              style: TextStyle(
                color: Colors.white, // Set the text color of the drawer item
                fontSize: 18.0,
                fontFamily: 'CustomFont', // Apply the custom font
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTask()),
              );
            },
            tileColor: Colors.blue, // Set the background color of the ListTile
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Apply border radius
            ),
          ),
        ],
      ),
//=======
//>>>>>>> master
    );
  }
}
