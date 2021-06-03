import 'package:flutter/material.dart';

class RoomItem {
  final IconData icon = Icons.business_outlined;
  final Color iconColor = Color(0xFF8D7AEE);
  String title;
  String subTitle;
  Map<String, dynamic> room;
  String id;

  RoomItem({this.id, this.title, this.subTitle, this.room});
}
