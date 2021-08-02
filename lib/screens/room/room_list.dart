import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reservationroom/models/room_item.dart';
import 'package:reservationroom/screens/room/room_home.dart';

import 'package:reservationroom/screens/room/room_item_page.dart';
import 'package:reservationroom/services/room_service.dart';
import 'package:provider/provider.dart';

class RoomList extends StatefulWidget {
  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  RoomService roomService;
  User firebaseUser;
  @override
  void initState() {
    super.initState();
    roomService = RoomService();
  }

  @override
  Widget build(BuildContext context) {
    firebaseUser = context.watch<User>();
    return Scaffold(
        appBar: AppBar(
          title: Text("Cuartos"),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context, RoomHome());
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
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
      future: roomService.getAllByUserRooms(firebaseUser.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData) {
          var documents = snapshot.data.docs;
          if (documents.isEmpty) {
            return Center(child: Text("No tienes cuartos registrados."));
          }
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
