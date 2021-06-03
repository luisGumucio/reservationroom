import 'package:flutter/material.dart';
import 'package:reservationroom/screens/room/room_form.dart';
import 'package:reservationroom/screens/room/room_list.dart';
import 'package:reservationroom/utils/app_theme.dart';

class RoomHome extends StatefulWidget {
  @override
  _RoomHomeState createState() => _RoomHomeState();
}

class _RoomHomeState extends State<RoomHome> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: AppTheme.buildLightTheme(),
        child: Scaffold(
          body: RoomList(),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RoomFormPage()),
                );
              },
              child: const Icon(Icons.add),
              backgroundColor: AppTheme.buildLightTheme().accentColor),
        ));
  }
}
