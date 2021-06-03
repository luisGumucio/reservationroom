import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_picture_uploader/firebase_picture_uploader.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:reservationroom/models/room.dart';
import 'package:reservationroom/screens/room/room_list.dart';
import 'package:reservationroom/services/room_service.dart';
import 'package:reservationroom/utils/app_theme.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:reservationroom/utils/custom_alert_dialog.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:reservationroom/utils/loader.dart';
import 'package:reservationroom/utils/single_image_upload.dart';

// import 'package:path/path.dart';
class RoomFormPage extends StatefulWidget {
  @override
  _RoomFormPageState createState() => _RoomFormPageState();
}

class _RoomFormPageState extends State<RoomFormPage> {
  final _formKeyState = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final ubicationController = TextEditingController();
  Room _room;
  RoomService roomService;
  Position _currentPosition;
  List _myActivities;
  File _image;
  bool _isLoading = false;

  var dialog = CustomAlertDialog(
      title: "Error",
      message: "Fallo al crear la habitacion, por favor intenten de nuevo.",
      onPostivePressed: (BuildContext context) {
        Navigator.pop(context);
      },
      positiveBtnText: 'Aceptar');

  @override
  void initState() {
    super.initState();
    roomService = RoomService();
    _room = Room();
    _myActivities = [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: AppTheme.buildLightTheme(),
        child: Scaffold(
            appBar: AppBar(
              title: Text("Cuartos"),
            ),
            body: SingleChildScrollView(
              child: getFormCard(),
            )));
  }

  Card getFormCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 10.0,
      child: Column(children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            'Crear Habitacion',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: _getRoomFormColumn(),
        ),
      ]),
    );
  }

  Form _getRoomFormColumn() {
    return Form(
      key: _formKeyState,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Nombre', icon: Icon(Icons.domain_rounded)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el nombre.';
                }
                return null;
              },
              onSaved: (val) => setState(() => _room.name = val),
            ),
            TextFormField(
                decoration: InputDecoration(
                    labelText: 'Precio', icon: Icon(Icons.attach_money)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el precio.';
                  }
                  return null;
                },
                onSaved: (val) => setState(() => _room.price = int.parse(val)),
                keyboardType: TextInputType.number),
            TextField(
              readOnly: true,
              controller: dateController,
              decoration: InputDecoration(
                  labelText: 'Fecha disponible',
                  icon: Icon(Icons.calendar_today)),
              onTap: () async {
                var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
                dateController.text = date.toString().substring(0, 10);
                setState(() => _room.date = Timestamp.fromDate(date));
              },
            ),
            TextField(
              readOnly: true,
              controller: ubicationController,
              decoration: InputDecoration(
                  labelText: 'Ubicacion', icon: Icon(Icons.location_on)),
              onTap: () async {
                var scafo = ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Obteniendo la ubicacion..'),
                  duration: Duration(seconds: 40),
                ));
                await _getCurrentLocation()
                    .then((value) {
                      ubicationController.text = value;
                      setState(() => _room.ubication = value);
                      scafo.close();
                    })
                    .catchError((onError) {
                      scafo.close();
                    })
                    .timeout(Duration(seconds: 10))
                    .onError((error, stackTrace) {
                      scafo.close();
                    });
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Descripcion', icon: Icon(Icons.text_fields)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la descripcion.';
                }
                return null;
              },
              onSaved: (val) => setState(() => _room.description = val),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              minLines: 1, //Normal textInputField will be displayed
              maxLines: 5,
              maxLength: 100,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(
                  Icons.photo,
                  color: Theme.of(context).accentColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                ),
                Text(
                  'Images',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            getUIImage(),
            SizedBox(height: 10.0),
            getMulti(),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Guardar",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      var scafo = ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Proccesando datos..')));

                      final form = _formKeyState.currentState;
                      if (form.validate()) {
                        form.save();
                        roomService
                            .saveRoom(_room, _currentPosition)
                            .then((value) {
                          // var photo = _formKey.currentState.value['photos'];
                          uploadImageToFirebase(_image, value.id);
                          scafo.close();
                          form.reset();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RoomList()),
                          );
                        }).onError((error, stackTrace) => showDialog(
                                context: context,
                                builder: (BuildContext context) => dialog));
                      }
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: MaterialButton(
                    color: Colors.redAccent,
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _formKeyState.currentState.reset();
                    },
                  ),
                ),
              ],
            )
          ]),
    );
  }

  void httpJob(AnimationController controller) {
    controller.forward();
    // Future.delayed(Duration(seconds: 10), () {});
  }

  Future _getCurrentLocation() {
    return Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      return _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];
      return "Pais: ${place.country}, Ciudad: ${place.locality}, ${place.subAdministrativeArea}, ${place.subLocality},  Direccion:${place.street}";
    } catch (e) {
      print(e);
    }
  }

  Future uploadImageToFirebase(File _imageFile, String id) async {
    String fileName = _imageFile.path;
    var firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$id$fileName');
    firebaseStorageRef.putFile(_imageFile);
    // var taskSnapshot = await uploadTask.whenComplete(() => );
    // taskSnapshot.ref.getDownloadURL().then(
    //       (value) => print("Done: $value"),
    //     );
  }

  MultiSelectFormField getMulti() {
    return MultiSelectFormField(
      autovalidate: false,
      chipBackGroundColor: Colors.blue,
      chipLabelStyle:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
      checkBoxActiveColor: Colors.blue,
      checkBoxCheckColor: Colors.white,
      dialogShapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Row(children: <Widget>[
        Icon(Icons.room_service),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
        ),
        Text("Servicios")
      ]),
      validator: (value) {
        if (value == null || value.length == 0) {
          return 'Please select one or more options';
        }
        return null;
      },
      dataSource: [
        {
          "display": "Baño compartido",
          "value": "Baño compartido",
        },
        {
          "display": "Baño privado",
          "value": "Baño privado",
        },
        {
          "display": "Acepta mascota",
          "value": "Acepta mascota",
        },
        {
          "display": "No Acepta mascota",
          "value": "No Acepta mascota",
        },
        {
          "display": "Garaje",
          "value": "Garaje",
        },
      ],
      textField: 'display',
      valueField: 'value',
      okButtonLabel: 'OK',
      cancelButtonLabel: 'CANCEL',
      hintWidget: Text('Por favor selecciones del servicios'),
      initialValue: _myActivities,
      onSaved: (value) {
        if (value == null) return;
        setState(() {
          _myActivities = value;
          _room.services = value;
        });
      },
    );
  }

  GestureDetector getUIImage() {
    return GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: CircleAvatar(
        radius: 30,
        child: _image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  _image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[800],
                ),
              ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  _imgFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
