import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal/src/business_logic/services/authentication_service.dart';
import 'package:minimal/src/views/ui/home.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignIn> {
  final emailcontroller = new TextEditingController();
  final passwordcontroller = new TextEditingController();
  bool _validateEmail = false;
  bool _validatePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "minimal",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0x00000000),
          elevation: 0,
        ),
        body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    TextField(
                      obscureText: false,
                      autofocus: false,
                      controller: emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: "Email",
                        errorText: _validateEmail
                            ? "Feld wurde nicht ausgefüllt!"
                            : null,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      obscureText: true,
                      autofocus: false,
                      controller: passwordcontroller,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_outline),
                        labelText: "Passwort",
                        errorText: _validateEmail
                            ? "Feld wurde nicht ausgefüllt!"
                            : null,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 500,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (emailcontroller.text.isEmpty ||
                              passwordcontroller.text.isEmpty) {
                            print("is empty");
                          } else {
                            context
                                .read<AuthenticationService>()
                                .firebaseSignIn(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text)
                                .then((value) {
                              String uid =
                                  FirebaseAuth.instance.currentUser.uid;

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(uid)));

                              if (uid.isNotEmpty) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()));
                              }
                            });
                          }

                          setState(() {
                            emailcontroller.text.isEmpty
                                ? _validateEmail = true
                                : _validateEmail = false;

                            emailcontroller.text.isEmpty
                                ? _validatePassword = true
                                : _validatePassword = false;
                          });
                        },
                        child: Text("Einloggen"),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
