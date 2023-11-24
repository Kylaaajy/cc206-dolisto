import 'package:flutter/material.dart';
import '../features/delete_task.dart';
import '../main.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.lightBlue,
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'Deleted Task',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18.0,
                  fontFamily: 'CustomFont',
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeletedTask()),
                );
              },
              tileColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding: EdgeInsets.all(16.0), 
            ),
          ],
        ),
      ),
    );
  }
}

DeletedTask() {
}
