import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reservationroom/screens/hotel_booking/model/reservation.dart';
import 'package:reservationroom/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:reservationroom/services/reservation_service.dart';
import 'package:reservationroom/utils/app_theme.dart';
import 'package:provider/provider.dart';

final List<String> imagesList = [
  // 'https://cdn.pixabay.com/photo/2020/11/01/23/22/breakfast-5705180_1280.jpg',
  'https://cdn.pixabay.com/photo/2020/11/01/23/22/breakfast-5705180_1280.jpg',
  'https://cdn.pixabay.com/photo/2019/01/14/17/25/gelato-3932596_1280.jpg',
  'https://cdn.pixabay.com/photo/2017/04/04/18/07/ice-cream-2202561_1280.jpg',
];

class OrderHome extends StatefulWidget {
  final QueryDocumentSnapshot doc;
  const OrderHome(this.doc, {Key key}) : super(key: key);

  @override
  _OrderHomeState createState() => _OrderHomeState();
}

class _OrderHomeState extends State<OrderHome> {
  ReservationService reservationService;

  @override
  void initState() {
    reservationService = ReservationService();
    super.initState();
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List services = widget.doc['services'];
    return Theme(
        data: AppTheme.buildLightTheme(),
        child: Scaffold(
            appBar: AppBar(
              title: Text('Reserva'),
            ),
            body: Column(children: [
              CarouselSlider(
                options: CarouselOptions(
                    autoPlay: false,
                    onPageChanged: (index, reason) {
                      setState(
                        () {
                          _currentIndex = index;
                        },
                      );
                    }),
                items: imagesList
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          margin: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          elevation: 6.0,
                          shadowColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Image.network(
                                  item,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imagesList.map((urlOfItem) {
                  int index = imagesList.indexOf(urlOfItem);
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Color.fromRGBO(0, 0, 0, 0.8)
                          : Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 10.0,
              ),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(15),
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _getTitleRoom(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Ubicacion:",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.doc['ubication'],
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Fecha Disponible:",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.doc['date'].toString(),
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Servicios:",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: <Widget>[
                            for(var item in services) 
                            chip(item.toString(), Color(0xFF4fc3f7)),
                          ],
                        )
                      ],
                    ),
                  )),
              ElevatedButton(
                onPressed: () async {
                  final firebaseUser =
                      context.read<AuthService>().currentUser();

                  Reservation reservation = Reservation();
                  reservation.from = firebaseUser.uid;
                  reservation.to = widget.doc['userId'];
                  reservation.roomId = widget.doc.id;
                  DateTime now = DateTime.now();
                  String date = DateFormat('dd/MM/yyyy').format(now);
                  reservation.date = date;
                  reservationService
                      .saveReservation(reservation)
                      .then((value) async {
                    SnackBar snackBar = SnackBar(
                        content: Text("Se realizo la reserva correctamente"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    try {
                      //arreglar esta parte
                      var body = constructFCMPayload(
                          "fhUkClk8RduxkQsQARPZJr:APA91bFbsvpvW4XcjPh9-qRW4n_4St6SWDwgsc5GSdAz4MTltxemJ54ovDJxQ_rrHeJGaE2-EQR5LUALmQYQ6jUlK-PLTRIaHYKE7upYsRvvR44XKw9s_q6j0Vj-Fo-SG8pIDKQlYA3f",
                          firebaseUser.email);
                      var response = await http.post(
                        Uri.parse('https://fcm.googleapis.com/fcm/send'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Authorization':
                              'key=AAAAxJVRtSo:APA91bGlM5nwrETE2pVfqX35aKHhakHaDIHGo8OuXyDI1Z380sVMjrJe7jk2DRqovKGRswz8-hAohQjU_Z_zoRrUKNJl04TgC1crvSWa0FOIpSzYhmCF4fheLsW770RiySdOJ-KIx7BJ'
                        },
                        body: body,
                      );
                      print(response);
                    } catch (e) {
                      print(e);
                    }
                  }).onError((error, stackTrace) {
                    SnackBar snackBar =
                        SnackBar(content: Text("Fallo al reservar el cuarto"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // background foreground
                ),
                child: Container(
                  width: 250,
                  height: 40,
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.chalet),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Reservar Cuarto')
                    ],
                  ),
                ),
              )
            ])));
  }

  Widget _getTitleRoom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${widget.doc['name']}',
          style: TextStyle(
              fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Column(
          children: [
            Text(
              "Precio por mes",
              style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              "Bs. ${widget.doc['price']}",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  Widget chip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(5.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.grey.shade600,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(6.0),
    );
  }

  String constructFCMPayload(String token, String name) {
    return jsonEncode({
      'to': token,
      'data': {},
      'notification': {
        'title': 'Reservation Cuarto',
        'body': name + ' reservo un cuarto tuyo',
      },
    });
  }
}
