import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

class Room {
  String name;
  int price;
  Timestamp date;
  double latitude;
  double longitude;
  dynamic services;
  String ubication;
  Placemark placemark;
  String description;
  String userId;
}
