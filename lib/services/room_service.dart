import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:reservationroom/models/room.dart';

class RoomService {
  final CollectionReference rooms =
      FirebaseFirestore.instance.collection('rooms');

  Future<DocumentReference> saveRoom(
      Room room, Position currentPosition) async {
    try {
      final Map<String, dynamic> data = Map<String, dynamic>();
      data['name'] = room.name;
      data['price'] = room.price;
      data['date'] = room.date;
      data['services'] = room.services;
      data['longitude'] = currentPosition.longitude;
      data['latitude'] = currentPosition.latitude;
      data['description'] = room.description;
      data['ubication'] = room.ubication;
      return await rooms.add(data).then((value) {
        print(value.id);
        return value;
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<QuerySnapshot> getAllRooms() {
    return rooms.get();
  }
}
