import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:reservationroom/models/profile.dart';

class ProfileImage extends StatelessWidget {
  final double height, width;
  final Color color;
  final Profile profile;
  ProfileImage(
      {this.height = 100.0,
      this.width = 100.0,
      this.color = Colors.white,
      this.profile});
  @override
  Widget build(BuildContext context) {
    print(profile.imageUrl);
    return Container(
          width: width,
    height: height,
      child: ClipOval(
        child: Image.network(
          profile.imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  // return Container(
  //   width: width,
  //   height: height,
  //   decoration: BoxDecoration(
  //     shape: BoxShape.circle,
  //     color: Colors.red,
  //     image: DecorationImage(
  //       image: NetworkImage,
  //       fit: BoxFit.contain,
  //     ),
  //     border: Border.all(
  //       color: color,
  //       width: 3.0,
  //     ),
  //   ),
  // );
  // }
}
