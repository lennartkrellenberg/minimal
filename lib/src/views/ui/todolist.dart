import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal/src/business_logic/services/database_service.dart';
import 'package:flutter/foundation.dart';

import 'package:minimal/src/views/utils/toDoItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ToDoList extends StatelessWidget {
  final String uid = FirebaseAuth.instance.currentUser.uid.toString();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("toDos")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text("Loading Data");
          if (snapshot.data.size == 0) {
            return Text("Füge neue To-Dos hinzu!");
          } else {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data.size,
              itemBuilder: (BuildContext context, int index) {
                final toDoItem = snapshot.data.docs.toString();
                return Dismissible(
                  key: Key(toDoItem),
                  onDismissed: (direction) {
                    snapshot.data.docs.removeAt(index);

                    String id = snapshot.data.docs[index]["id"];
                    print(uid);
                    RemoveToDo(uid, id);
                    ScaffoldMessenger.of(context);
                  },
                  child: ToDoItem(
                    snapshot.data.docs[index]["toDoText"].toString(),
                    snapshot.data.docs[index]["category"].toString(),
                    snapshot.data.docs[index]["priority"].toString(),
                    snapshot.data.docs[index]["categoryColor"],
                    snapshot.data.docs[index]["priorityColor"],
                  ),
                  background: Container(color: Colors.red),
                );
              },
            );
          }
        });
  }
}
