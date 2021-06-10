import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal/src/business_logic/services/database_service.dart';

class CreateToDoView extends StatefulWidget {
  CreateToDoView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CreateToDoViewState createState() => _CreateToDoViewState();
}

class _CreateToDoViewState extends State<CreateToDoView> {
  final toDoController = new TextEditingController();
  bool _validateToDo = false;

  String categoryDropdownValue = 'Family';
  String priorityDropdownValue = 'Low';
  String currentCategory = "Family";
  String currentPriority = "Low";

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Create a Task",
              style: new TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                child: TextField(
                    obscureText: false,
                    autofocus: false,
                    controller: toDoController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ToDo',
                      errorText:
                          _validateToDo ? 'Feld wurde nicht ausgefüllt!' : null,
                    ))),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Category",
                  style:
                      new TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                DropdownButton<String>(
                  value: categoryDropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Color.fromRGBO(35, 128, 249, 1),
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      categoryDropdownValue = newValue;
                      currentCategory = newValue;
                    });
                  },
                  items: <String>['Family', "Work", 'School']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Priority",
                    style: new TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  DropdownButton<String>(
                    value: priorityDropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Color(0xFF18CC36),
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        priorityDropdownValue = newValue;
                        currentPriority = newValue;
                      });
                    },
                    items: <String>['Low', 'High']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ]),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  if (toDoController.text.isEmpty) {
                    setState(() {
                      toDoController.text.isEmpty
                          ? _validateToDo = true
                          : _validateToDo = false;
                    });
                  } else {
                    CreateToDo(FirebaseAuth.instance.currentUser.uid,
                        toDoController.text, currentCategory, currentPriority);
                    print(toDoController.text);
                    print(currentCategory);
                  }
                },
                child: Text("Submit"))
          ],
        ));
  }
}
