import 'package:flutter/material.dart';
//deleted_task_Sermonia_Ordinario
import '../features/delete_task.dart';
import '../main.dart';
=======
import '../features/add_task.dart';


class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
// deleted_task_Sermonia_Ordinario
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
=======
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

