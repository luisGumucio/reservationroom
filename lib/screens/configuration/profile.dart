// import 'package:dribble_one/src/widgets/profile/profile_categories.dart';
// import 'package:dribble_one/src/widgets/profile/profile_detail.dart';
// import 'package:dribble_one/src/widgets/profile/profile_menu.dart';
// import 'package:dribble_one/src/widgets/title_large.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reservationroom/models/profile.dart';
import 'package:reservationroom/screens/authenticate/anonymus_page.dart';
import 'package:reservationroom/screens/configuration/profile/profile_detail.dart';
import 'package:reservationroom/screens/configuration/profile/profile_menu.dart';
import 'package:reservationroom/services/auth.dart';
import 'package:reservationroom/services/profile_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService;
  ProfileService profileService;
  Future<Profile> profileFuture;
  User user;
  @override
  void initState() {
    super.initState();
    authService = AuthService(FirebaseAuth.instance);
    profileService = ProfileService();
    user = authService.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return Material(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 30.0,
              ),
              child: FutureBuilder<Profile>(
                  future: profileService.getProfile(user.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var profile = snapshot.data;
                      return Column(
                          //mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 5.0,
                            ),
                            ProfileDetail(profile),
                            SizedBox(
                              height: 30.0,
                            ),
                            Flexible(child: ProfileMenu()),
                          ]);
                    }
                    return CircularProgressIndicator();
                  })));
    }
    return AnonymusPage();
    // return ProfileMenu();
  }
}
