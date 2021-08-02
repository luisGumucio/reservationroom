import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reservationroom/models/room.dart';

class RoomService {
  final CollectionReference rooms =
      FirebaseFirestore.instance.collection('rooms');

  Future<DocumentReference> saveRoom(Room room, Position currentPosition,
      String userId, Placemark place) async {
    try {
      final Map<String, dynamic> data = Map<String, dynamic>();
      final Map<String, dynamic> placeData = Map<String, dynamic>();
      placeData['country'] = place.country;
      placeData['area'] = place.administrativeArea;
      placeData['street'] = place.street;
      placeData['locality'] = place.locality;
      placeData['name'] = place.name;
      placeData['subarea'] = place.subAdministrativeArea;
      data['name'] = room.name;
      data['price'] = room.price;
      data['date'] = room.date;
      data['services'] = room.services;
      data['longitude'] = currentPosition.longitude;
      data['latitude'] = currentPosition.latitude;
      data['description'] = room.description;
      data['ubication'] = room.ubication;
      data['userId'] = userId;
      data['place'] = placeData;
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

  Future<QuerySnapshot> getAllByUserRooms(String uid) async {
    return await rooms.where("userId", isEqualTo: uid).get();
  }
}
