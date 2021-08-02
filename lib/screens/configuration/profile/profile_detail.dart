import 'package:flutter/material.dart';
import 'package:reservationroom/models/profile.dart';
import 'package:reservationroom/screens/configuration/profile/profile_image.dart';
import 'package:reservationroom/utils/app_theme.dart';
import 'package:reservationroom/utils/constant.dart';

class ProfileDetail extends StatelessWidget {
  final Profile profile;
  ProfileDetail(this.profile);
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Material(
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
      elevation: 10.0,
      child: Container(
        height: deviceSize.height * 0.2,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: AppTheme.buildLightTheme().accentColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                ProfileImage(
                  height: 60.0,
                  width: 60.0,
                  profile: profile,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          profile.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                for (var item in profile.socialInformation.keys)
                  Column(
                    children: <Widget>[
                      Text(
                        profile.socialInformation[item].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        item,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
