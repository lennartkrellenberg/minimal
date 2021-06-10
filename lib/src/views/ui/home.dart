import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal/src/business_logic/services/authentication_service.dart';
import 'package:minimal/src/views/ui/createToDoView.dart';
import 'package:minimal/src/views/ui/todolist.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ToDoList(),
    CreateToDoView(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
            child: Center(
                child: Text(
          "minimal",
          style: TextStyle(color: Colors.black),
        ))),
        backgroundColor: Color(0x00000000),
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(68, 68, 68, 1),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 36.0,
          ),
          onPressed: () {
            setState(() {
              _selectedIndex = 1;
            });
          }),
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.home),
                    iconSize: 36.0,
                    color: Color.fromRGBO(68, 68, 68, 1),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    }),
                SizedBox(width: 40), // The dummy child
                IconButton(
                    icon: Icon(Icons.person),
                    iconSize: 36.0,
                    color: Color.fromRGBO(68, 68, 68, 1),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    }),
              ],
            ),
          )),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
    return scaffold;
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () => context.read<AuthenticationService>().logOut(),
      child: Text("Ausloggen"),
    ));
  }
}
