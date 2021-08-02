import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reservationroom/models/profile.dart';
import 'package:reservationroom/services/auth.dart';
import 'package:reservationroom/services/profile_service.dart';
import 'package:reservationroom/utils/app_theme.dart';
import 'package:provider/provider.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<CreateAccountPage> {
  bool showPassword = false;
  final _formKeyState = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  String imageUrl =
      'https://drive.google.com/file/d/13DnBQTamzzUIe1-6Tr8sgpD_29O_IDiC/view?usp=sharing';
  File _image;
  Profile profile;
  ProfileService profileService;
  final AuthService authService = AuthService(FirebaseAuth.instance);
  @override
  void initState() {
    super.initState();
    profile = Profile();
    profileService = ProfileService();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: AppTheme.buildLightTheme(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.buildLightTheme().accentColor,
            elevation: 1,
          ),
          body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: Container(
              child: ListView(
                children: [
                  _getPictureProfile(),
                  SizedBox(
                    height: 35,
                  ),
                  _getProfileForm(),
                ],
              ),
            ),
          ),
        ));
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

  Form _getProfileForm() {
    return Form(
      key: _formKeyState,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Nombre completo', icon: Icon(Icons.account_box)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el nombre.';
              }
              return null;
            },
            onSaved: (val) => setState(() => profile.name = val),
          ),
          TextFormField(
            decoration:
                InputDecoration(labelText: 'E-mail', icon: Icon(Icons.email)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese el correo.';
              }
              return null;
            },
            onSaved: (val) => setState(() => profile.email = val),
          ),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'Telefono', icon: Icon(Icons.phone)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el telefono.';
                }
                return null;
              },
              onSaved: (val) => setState(() => profile.phone = val),
              keyboardType: TextInputType.number),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Password', icon: Icon(Icons.password)),
            validator: (val) => val.length < 6 ? 'Password muy corto.' : null,
            onSaved: (val) {
              profile.password = val;
            },
            obscureText: true,
            controller: passwordController,
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  // getImage();
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text("Cancelar",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.black)),
              ),
              RaisedButton(
                onPressed: () {
                  final form = _formKeyState.currentState;
                  if (form.validate()) {
                    form.save();
                    authService.createUser(profile).then((value) {
                      uploadImageToFirebase(value.user.uid);
                      profile.idUser = value.user.uid;
                      profileService.saveProfile(profile);
                      context
                          .read<AuthService>()
                          .signIn(
                            email: value.user.email,
                            password: profile.password,
                          )
                          .then((value) {
                        Navigator.of(context).pushReplacementNamed('/');
                      });
                    });
                  }
                },
                color: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Guardar",
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Center _getPictureProfile() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 4, color: Theme.of(context).scaffoldBackgroundColor),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 10))
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: _image == null
                        ? AssetImage('assets/images/userImage.png')
                        : FileImage(_image))),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 4,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    color: Colors.green,
                  ),
                  child: Icon(Icons.edit, color: Colors.white)),
              onTap: () {
                _showPicker(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> uploadImageToFirebase(String id) async {
    var firebaseStorageRef =
        FirebaseStorage.instance.ref().child('profile/$id');
    firebaseStorageRef.putFile(_image).then((value) {
      print(value);
    });
  }

  getImage() async {
    var firebaseStorageRef = FirebaseStorage.instance.ref().child(
        'profile/yzPazuoxDsXeELjujOP06cmlp203/storage/emulated/0/Android/data/com.example.reservationroom/files/Pictures/scaled_fc06b0c1-80a6-4f6c-b595-993ed21d3e018236158631621723032.jpg');
    await firebaseStorageRef.getDownloadURL().then((value) => setState(() {
          imageUrl = value;
        }));
    // return new NetworkImage(downloadUrl);
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
