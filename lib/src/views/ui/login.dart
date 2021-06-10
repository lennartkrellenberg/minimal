import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal/src/business_logic/services/authentication_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _validateName = false;
  bool _validateEmail = false;
  bool _validatePassword = false;

  final nameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Center(child: Text("minimal"))),
          backgroundColor: Color(0x00000000),
          elevation: 0,
        ),
        body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 150),
                  SizedBox(
                    height: 50,
                  ),
                  TextField(
                      obscureText: false,
                      autofocus: false,
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.perm_identity),
                        labelText: 'Name',
                        errorText: _validateName
                            ? 'Feld wurde nicht ausgefüllt!'
                            : null,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: false,
                    autofocus: false,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: 'Email',
                      errorText: _validateEmail
                          ? 'Feld wurde nicht ausgefüllt!'
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        labelText: 'Password',
                        errorText: _validatePassword
                            ? 'Feld wurde nicht ausgefüllt!'
                            : null,
                      ),
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
                            if (nameController.text.isEmpty ||
                                emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              print("is empty");
                            } else {
                              context.read<AuthenticationService>().signUp(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }

                            setState(() {
                              nameController.text.isEmpty
                                  ? _validateName = true
                                  : _validateName = false;

                              emailController.text.isEmpty
                                  ? _validateEmail = true
                                  : _validateEmail = false;

                              passwordController.text.isEmpty
                                  ? _validatePassword = true
                                  : _validatePassword = false;
                            });
                          },
                          child: Text("Sign Up")))
                ],
              ),
            ))));
  }
}

void test() {
  print('print me');
}
