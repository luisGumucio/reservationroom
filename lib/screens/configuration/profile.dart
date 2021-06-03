// import 'package:dribble_one/src/widgets/profile/profile_categories.dart';
// import 'package:dribble_one/src/widgets/profile/profile_detail.dart';
// import 'package:dribble_one/src/widgets/profile/profile_menu.dart';
// import 'package:dribble_one/src/widgets/title_large.dart';
import 'package:flutter/material.dart';
import 'package:reservationroom/screens/configuration/profile/profile_detail.dart';
import 'package:reservationroom/screens/configuration/profile/profile_menu.dart';
import 'package:reservationroom/screens/configuration/profile/title_large.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 30.0,
        ),
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            ProfileDetail(),
            SizedBox(
              height: 30.0,
            ),
            Flexible(child: ProfileMenu()),
          ],
        ),
      ),
    );
  }
}
