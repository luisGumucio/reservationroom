import 'package:flutter/material.dart';
import 'package:reservationroom/utils/app_theme.dart';

import 'booking_list.dart';

class BookingHome extends StatefulWidget {
  @override
  _BookingHomeState createState() => _BookingHomeState();
}

class _BookingHomeState extends State<BookingHome> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.buildLightTheme(),
      child: Scaffold(
        body: BookingList(),
      ),
    );
  }
}
