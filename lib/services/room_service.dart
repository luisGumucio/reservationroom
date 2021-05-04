import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class RoomService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentReference> saveRoom(Map<String, dynamic> value) async {
    try {
      var data = value;
      return await firestore.collection("rooms").add(data).then((value) {
        print(value.id);
        return value;
      });
    } catch (e) {
      print(e);
      return null;
    }
  }
}
