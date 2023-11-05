import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'erd_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ERD Designer')),
        body: ERDPage(),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.add_event,
          children: [
            SpeedDialChild(
              child: Icon(Icons.add),
              label: 'Add',
              onTap: () {
                // Handle the "Add" button action
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.swap_horiz),
              label: 'Exchange',
              onTap: () {
                // Handle the "Exchange" button action
              },
            ),
          ],
        ),
      ),
    );
  }
}
