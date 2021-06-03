import 'package:flutter/material.dart';
import 'package:reservationroom/screens/hotel_booking/hotel_app_theme.dart';
import 'package:reservationroom/utils/app_theme.dart';

class RoomDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Scaffold oldBody() {
    return Scaffold(
      body: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.deepOrange, Colors.pinkAccent])),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://www.trendrr.net/wp-content/uploads/2017/06/Deepika-Padukone-1.jpg",
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Natasha",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 22.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "1200",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "21.2K",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Follow",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "1200",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Info:",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontStyle: FontStyle.normal,
                        fontSize: 28.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'My name is Natasha and I am  a freelance mobile app developper.\n'
                    'Having Experiece in Flutter and Android',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 300.00,
            child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                elevation: 0.0,
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Colors.pink, Colors.pinkAccent]),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Contact me",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Theme getBody() {
    return Theme(
        data: AppTheme.buildLightTheme(),
        child: Scaffold(
            appBar: AppBar(
              title: Text("Cuartos"),
            ),
            body: _getColumnBody()));
  }

  Column _getColumnBody() {
    return Column(children: [_getContainer(), _getContainerDetail()]);
  }

  Container _getContainer() {
    var image = new Image.network("http://www.gstatic.com/webp/gallery/1.jpg");
    var container = new Container(
      child: image,
      padding: EdgeInsets.only(top: 5.0),
      width: 200.0,
      height: 200.0,
    );
    return Container(
      color: HotelAppTheme.buildLightTheme().backgroundColor,
      padding: EdgeInsets.only(top: 30.0),
      child: Container(
        width: double.infinity,
        height: 150.0,
        child: Center(child: ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0) {
              var singleChildScrollView = SingleChildScrollView(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/hotel/hotel_1.png'),
                        radius: 50.0,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/hotel/hotel_2.png'),
                        radius: 50.0,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/hotel/hotel_3.png'),
                        radius: 50.0,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/hotel/hotel_4.png'),
                        radius: 50.0,
                      ),
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/userImage.png'),
                        radius: 50.0,
                      ),
                    ],
                  ),
                  scrollDirection: Axis.horizontal);
              return singleChildScrollView;
            }
          },
        )),
      ),
    );
  }

  Container _getContainerDetail() {
    return Container(
      color: HotelAppTheme.buildLightTheme().appBarTheme.backgroundColor,
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nombre:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text("Simplesa"),
            SizedBox(
              height: 4,
            ),
            Text(
              "Precio:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text("13bs"),
            SizedBox(
              height: 4,
            ),
            Text(
              "Ubicacion:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text("Pais: Bolivia, Ciudad: Quillacollo,  Direccion:RN 4"),
            SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Fecha Disponible:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text("26/5/2021"),
            SizedBox(
              height: 4,
            ),
            Text(
              "Servicios:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 2.0,
              ),
            ),
            Row(
              children: <Widget>[
                chip('Banio compartido', Color(0xFF4fc3f7)),
                chip('Sin Mascotas', Color(0xFF4fc3f7)),
              ],
            )
          ],
        ),
      ),
    );
  }

//  Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 backgroundImage: NetworkImage(
//                   "https://www.trendrr.net/wp-content/uploads/2017/06/Deepika-Padukone-1.jpg",
//                 ),
//                 radius: 50.0,
//               ),
//             ],
//           ),

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

  Text _titleLarge() {
    return Text(
      "simple",
      style: TextStyle(
        color: Colors.black,
        fontSize: 40.0,
        letterSpacing: 2.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container buildLampsWithSlider() {
    return Container(
      //color: Colors.yellow,
      height: 350,
      child: Stack(
        children: <Widget>[
          // buildLamps,
        ],
      ),
    );
  }

  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  // final buildLamps = ListView.builder(
  //   scrollDirection: Axis.horizontal,
  //   physics: BouncingScrollPhysics(),
  //   shrinkWrap: true,
  //   itemCount: lampList.length,
  //   itemBuilder: (context, int index) => Lamp(
  //     item: lampList[index],
  //     index: index,
  //   ),
  // );

  //   Text(
  //   "Email",
  //   style: _style(),
  // ),
  // SizedBox(
  //   height: 4,
  // ),
  // Text("milan@gmail.com"),
  // SizedBox(
  //   height: 16,
  // ),
}
