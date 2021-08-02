import 'package:flutter/material.dart';
import 'package:reservationroom/screens/configuration/home_configuration.dart';
import 'package:reservationroom/screens/hotel_booking/hotel_home_screen.dart';
import 'package:reservationroom/screens/room/room_form.dart';
import 'package:reservationroom/utils/app_theme.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HotelHomeScreen(),
    Text(
      'cerca de mi',
      style: optionStyle,
    ),
    RoomFormPage(),
    HomeConfiguration()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.buildLightTheme(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('RoomMe'),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Cuartos',
                backgroundColor: Colors.grey,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Cerca de mi',
                backgroundColor: Colors.grey,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favoritos',
                backgroundColor: Colors.grey,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Configuration',
                backgroundColor: Colors.grey,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            onTap: _onItemTapped,
          )),
    );
  }
}
