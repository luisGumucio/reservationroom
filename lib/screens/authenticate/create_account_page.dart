import 'package:flutter/material.dart';
import 'package:reservationroom/screens/configuration/information/settings.dart';
import 'package:reservationroom/utils/app_theme.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<CreateAccountPage> {
  bool showPassword = false;
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: AppTheme.buildLightTheme(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.buildLightTheme().accentColor,
            elevation: 1,
            // leading: IconButton(
            //   icon: Icon(
            //     Icons.arrow_back,
            //     color: Colors.green,
            //   ),
            //   onPressed: () {},
            // )
          ),
          body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
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
                                  image: AssetImage(
                                      'assets/images/userImage.png'))),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Colors.green,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  // buildTextField("Nombre completo", null, true),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Nombre completo',
                        icon: Icon(Icons.account_box)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el nombre.';
                      }
                      return null;
                    },
                    onSaved: (val) => setState(() => print(val)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'E-mail', icon: Icon(Icons.email)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el nombre.';
                      }
                      return null;
                    },
                    onSaved: (val) => setState(() => print(val)),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Password', icon: Icon(Icons.password)
                        // icon: const Padding(
                        //   padding: const EdgeInsets.only(top: 15.0),
                        //   child: const Icon(Icons.lock),
                        // )
                        ),
                    // validator: (val) =>
                    //     val.length < 6 ? 'Password too short.' : null,
                    // onSaved: (val) => {
                    //   print(val)
                    //   password = val},
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
                        onPressed: () {},
                        child: Text("Cancelar",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Crear",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
