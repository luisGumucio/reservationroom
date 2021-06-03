import 'package:flutter/material.dart';
import 'package:reservationroom/models/room_item.dart';
import 'package:reservationroom/screens/room/room_detail.dart';

class RoomItemPage extends StatelessWidget {
  final RoomItem roomItem;
  RoomItemPage({this.roomItem});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: deviceSize.height * 0.09,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: roomItem.iconColor,
                    ),
                    child: Icon(
                      roomItem.icon,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          roomItem.title,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          roomItem.subTitle,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFFC4C5C9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Icon(
                Icons.chevron_right,
                color: Color(0xFFC4C5C9),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        print(roomItem.id);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoomDetail()),
        );
      },
    );
  }
}
