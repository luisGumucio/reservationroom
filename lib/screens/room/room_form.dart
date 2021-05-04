import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reservationroom/services/room_service.dart';

class RoomFormPage extends StatefulWidget {
  @override
  _RoomFormPageState createState() => _RoomFormPageState();
}

class _RoomFormPageState extends State<RoomFormPage> {
  final _formKey = GlobalKey<FormBuilderState>();
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
          backgroundColor: Colors.grey.shade200,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 32.0),
              child: Column(
                children: <Widget>[getWidgetRoom()],
              )),
        ));
  }

  Widget getWidgetRoom() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  'Crear Habitacion',
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ),
              _getRoomForm()
            ],
          ),
        ),
      ),
    );
  }

  FormBuilder _getRoomForm() {
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'name',
            decoration:
                InputDecoration(labelText: 'Nombre', icon: Icon(Icons.input)),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: 'El nombre es requerido'),
            ]),
          ),
          FormBuilderTextField(
            name: 'price',
            decoration:
                InputDecoration(labelText: 'Precio', icon: Icon(Icons.money)),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: 'El precio es requerido'),
              FormBuilderValidators.numeric(context,
                  errorText: 'Debe ser solo numeros.')
            ]),
          ),
          // FormBuilderImagePicker(
          //   name: 'photos',
          //   decoration: const InputDecoration(
          //       labelText: 'Imagen de la habitacion', icon: Icon(Icons.home)),
          //   maxImages: 3,
          // ),
          const SizedBox(height: 15),
          Container(
            margin: EdgeInsets.only(top: 32.0),
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.saveAndValidate()) {
                    roomService
                        .saveRoom(_formKey.currentState.value)
                        .then((value) => print(value))
                        .onError((error, stackTrace) => print(error));
                  }
                },
                style: ElevatedButton.styleFrom(
                    elevation: 10, primary: Colors.redAccent),
                child: Text('Registrar')),
          )
        ],
      ),
    );
  }
}
