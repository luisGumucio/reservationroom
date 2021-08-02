import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservationroom/screens/hotel_booking/model/reservation.dart';

class ReservationService {
  final CollectionReference reservations =
      FirebaseFirestore.instance.collection('reservations');

  Future<void> saveReservation(Reservation reservation) async {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['from'] = reservation.from;
    data['to'] = reservation.to;
    data['roomId'] = reservation.roomId;
    data['date'] = reservation.date;
    await reservations.add(data);
  }

  // Future<Profile> getProfile(String uid) async {
  //   Profile data = Profile();
  //   return await profiles
  //       .where("idUser", isEqualTo: uid)
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       data.name = doc['name'];
  //     });
  //     return data;
  //   });
  // }
}
