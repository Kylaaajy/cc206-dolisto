import 'package:flutter/material.dart';
import '../features/delete_task.dart';
import '../main.dart';


class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Deleted Task'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeletedTask()),
              );
            },
          ),
        ],
      ),
    );
  }
}