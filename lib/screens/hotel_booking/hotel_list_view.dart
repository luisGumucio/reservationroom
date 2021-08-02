
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'hotel_app_theme.dart';
import 'model/hotel_list_data.dart';
import 'dart:math' show cos, sqrt, asin;

class HotelListView extends StatefulWidget {
  HotelListView(
      {Key key,
      this.hotelData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);
  final VoidCallback callback;
  final HotelListData hotelData;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  _HotelListViewState createState() => _HotelListViewState();
}

class _HotelListViewState extends State<HotelListView> {
  String _pictureUrL;
  String _currentDistance = "0 Km";
  @override
  void initState() {
    super.initState();
    getImage();
    _getCurrentLocation(
        widget.hotelData.dist.latitude, widget.hotelData.dist.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  widget.callback();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                                aspectRatio: 2,
                                child: _pictureUrL == null
                                    ? Image.asset('assets/hotel/hotel_2.png')
                                    : Image.network(
                                        _pictureUrL,
                                        fit: BoxFit.cover,
                                      )),
                            Container(
                              color: HotelAppTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              widget.hotelData.titleTxt,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  widget.hotelData.subTxt,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8)),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.mapMarkerAlt,
                                                  size: 12,
                                                  color: HotelAppTheme
                                                          .buildLightTheme()
                                                      .primaryColor,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    _currentDistance,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey
                                                            .withOpacity(0.8)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '\Bs${widget.hotelData.perNight}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                        ),
                                        Text(
                                          '/por mes',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.grey.withOpacity(0.8)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: HotelAppTheme.buildLightTheme()
                                      .primaryColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> getImage() async {
    var uri = widget.hotelData.imagePath;
    var firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/rooms/$uri');
        var url = await firebaseStorageRef.getDownloadURL();
        setState(() {
          _pictureUrL = url;
        });
  }

  void _getCurrentLocation(lat2, lon2) {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        var p = 0.017453292519943295;
        var c = cos;
        var a = 0.5 -
            c((lat2 - position.latitude) * p) / 2 +
            c(position.latitude * p) *
                c(lat2 * p) *
                (1 - c((lon2 - position.longitude) * p)) /
                2;
        var result1 = Geolocator.distanceBetween(
            position.latitude, position.longitude, lat2, lon2);
        if (result1 > 1000) {
          double km = result1 / 1000;
          _currentDistance = "${km.toStringAsFixed(1)} km";
        } else {
          _currentDistance = "${result1.toStringAsFixed(1)} metros";
        }
      });
    }).catchError((e) {
      print(e);
    });
  }
}
