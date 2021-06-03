// import 'package:flutter/material.dart';

// class SecondRoute extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Second Route"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Navigate back to first route when tapped.
//           },
//           child: Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reservationroom/models/room_item.dart';

import 'package:reservationroom/screens/configuration/profile/profile_menu.dart';
import 'package:reservationroom/screens/room/room_item_page.dart';
import 'package:reservationroom/services/room_service.dart';

class RoomList extends StatefulWidget {
  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  RoomService roomService;

  @override
  void initState() {
    super.initState();
    roomService = RoomService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cuartos"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Flexible(child: _getAllRoomsWidget())],
          ),
        ));
  }

  FutureBuilder _getAllRoomsWidget() {
    return FutureBuilder<QuerySnapshot>(
      future: roomService.getAllRooms(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData) {
          var documents = snapshot.data.docs;
          return ListView(
            children: documents
                .map((doc) => RoomItemPage(
                      roomItem: new RoomItem(
                          id: doc.id,
                          title: doc['name'],
                          subTitle: "Precio:" + doc['price'].toString() + "",
                          room: doc.data()),
                    ))
                .toList(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
