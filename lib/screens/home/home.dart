import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservationroom/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: UploadingImageToFirebaseStorage()
        // body: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       // LocationPage(),
        //       // Text("HOME"),
        //       // ElevatedButton(
        //       //   onPressed: () {
        //       //     context.read<AuthService>().signOut();
        //       //   },
        //       //   child: Text("Sign out"),
        //       // ),
        //       UploadingImageToFirebaseStorage()
        //     ],
        //   ),
        // ),
        );
  }
}

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Position _currentPosition;
  String _currentAddress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          if (_currentPosition != null)
            Text(
                "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
          Text("simple: " + _currentAddress.toString()),
          ElevatedButton(
            child: Text("Get location"),
            onPressed: () {
              _getCurrentLocation();
            },
          )
        ],
      ),
    );
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks1 =
          await placemarkFromCoordinates(52.2165157, 6.9437819);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.street}, ${place.subLocality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}

final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);

class UploadingImageToFirebaseStorage extends StatefulWidget {
  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

class _UploadingImageToFirebaseStorageState
    extends State<UploadingImageToFirebaseStorage> {
  File _imageFile;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    var firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');
    var uploadTask = firebaseStorageRef.putFile(_imageFile);
    // var taskSnapshot = await uploadTask.whenComplete(() => );
    // taskSnapshot.ref.getDownloadURL().then(
    //       (value) => print("Done: $value"),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 360,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)),
              gradient: LinearGradient(
                  colors: [orange, yellow],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 80),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Uploading Image to Firebase Storage",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: _imageFile != null
                            ? Image.file(_imageFile)
                            : ElevatedButton(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                ),
                                onPressed: pickImage,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              uploadImageButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [yellow, orange],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: ElevatedButton(
              onPressed: () => uploadImageToFirebase(context),
              child: Text(
                "Upload Image",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
