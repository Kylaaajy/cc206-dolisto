import 'package:flutter/material.dart';
import '../features/add_task.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.lightBlue, // Set the background color of the drawer
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: ListTile(
                title: Text(
                  'Add Task',
                  style: TextStyle(
                    color:
                        Colors.white, // Set the text color of the drawer item
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
                tileColor:
                    Colors.blue, // Set the background color of the ListTile
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Apply border radius
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
