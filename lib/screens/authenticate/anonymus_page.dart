import 'package:flutter/material.dart';
import 'package:reservationroom/screens/authenticate/sign_in_page.dart';

class AnonymusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 30.0)),
          Center(
            child: Text(
              "Los miembros podran acceder a poder ofrecer sus cuartos. No te quedes afuera!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 30.0)),
          Center(
              child: RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInPage()));
            },
            color: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 50),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text(
              "Hacerme miembro",
              style: TextStyle(
                  fontSize: 14, letterSpacing: 2.2, color: Colors.white),
            ),
          )),
          Padding(padding: EdgeInsets.only(top: 30.0)),
          Padding(
              padding: EdgeInsets.only(
                left: 15.0,
              ),
              child: Text(
                "Idioma",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(
                left: 15.0,
              ),
              child: Text(
                "Espanol",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(
                left: 15.0,
              ),
              child: Text(
                "Informacion legal",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(
                left: 15.0,
              ),
              child: Text(
                "ver informacion",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              )),
        ],
      ),
    );
  }
}
