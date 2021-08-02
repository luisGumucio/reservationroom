import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reservationroom/services/booking_service.dart';
import 'package:provider/provider.dart';

class BookingList extends StatefulWidget {
  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  BookingService bookingService;
  User firebaseUser;
  @override
  void initState() {
    bookingService = BookingService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    firebaseUser = context.watch<User>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos"),
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: const Icon(Icons.arrow_back),
        //       onPressed: () {
        //         // Navigator.pop(context, RoomHome());
        //       },
        //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //     );
        //   },
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[Flexible(child: _getAllReservationWidget())],
        ),
      ),
    );
  }

  FutureBuilder _getAllReservationWidget() {
    return FutureBuilder<QuerySnapshot>(
      future: bookingService.getAllReservationByUser(firebaseUser.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData) {
          var documents = snapshot.data.docs;
          if (documents.isEmpty) {
            return Center(child: Text("No tienes cuartos pedidos."));
          }
          return ListView(
            children: documents.map((doc) => _reservationItem(doc)).toList(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _reservationItem(QueryDocumentSnapshot doc) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Stack(
        children: [_container(), _iconHome()],
      ),
    );
  }

  Widget _container() {
    return Container(
      width: 250,
      margin: EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
          color: new Color(0xFF333366),
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0),
            )
          ]),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Juan perez',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '60256894',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Fecha: 20/02/2021',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Cuarto: Simplesa',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0),
            ),
            SizedBox(
              height: 5,
            ),
            // Row(
            //   children: [
            //     ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         primary: Colors.green,
            //         textStyle: TextStyle(
            //           color: Colors.black,
            //           fontSize: 15,
            //         ),
            //       ),
            //       onPressed: () {},
            //       child: const Text('Aprobar'),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         primary: Colors.red,
            //         textStyle: TextStyle(
            //           color: Colors.black,
            //           fontSize: 15,
            //         ),
            //       ),
            //       onPressed: () {},
            //       child: const Text('Declinar'),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  Widget _iconHome() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: Icon(
        Icons.home,
        size: 100,
        color: Colors.redAccent,
      ),
    );
  }
}
