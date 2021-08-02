import 'package:cloud_firestore/cloud_firestore.dart';

class BookingService {
  final CollectionReference reservations =
      FirebaseFirestore.instance.collection('reservations');

  Future<QuerySnapshot> getAllReservations() {
    return reservations.get();
  }

  getAllReservationByUser(String uid) {
    return reservations.where("to", isEqualTo: uid).get();
  }
}
