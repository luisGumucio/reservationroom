import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservationroom/screens/authenticate/create_account_page.dart';
import 'package:reservationroom/services/auth.dart';
import 'package:reservationroom/utils/app_theme.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: AppTheme.buildLightTheme().accentColor),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 32.0),
              child: Column(children: [getWidgetAuthentication(context)])),
        ));
  }

  Widget getWidgetAuthentication(BuildContext context) {
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
                  'Login',
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
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
              Container(
                  child: Row(
                children: <Widget>[
                  Text('No tiene cuenta?'),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text(
                      'Click aqui!',
                      style: TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAccountPage()));
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<AuthService>()
                      .signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      )
                      .then((value) => print(value));
                },
                child: Text("Ingresar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// [
//                   TextField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       labelText: "Email",
//                     ),
//                   ),
//                   TextField(
//                     controller: passwordController,
//                     decoration: InputDecoration(
//                       labelText: "Password",
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       context.read<AuthService>().signIn(
//                             email: emailController.text.trim(),
//                             password: passwordController.text.trim(),
//                           );
//                     },
//                     child: Text("Sign in"),
//                   )
//                 ],
