import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:objectid/objectid.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> addUser(name, email, uid) {
  firestore.collection("users").doc(uid).collection("toDos").doc().set({
    "toDoText": "first To-Do",
    "category": "Work",
    "priority": "Low",
    "categoryColor": "0xFFF6CE06",
    "priorityColor": "0xFF18CC36"
  });

  return users
      .doc(uid)
      .set({"name": name, "email": email, "uid": uid})
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

// ignore: non_constant_identifier_names
Future<void> CreateToDo(
  uid,
  toDoText,
  category,
  priority,
) async {
  final dateId = ObjectId.fromTimestamp(DateTime.now()).toString();
  final objectId = ObjectId().hexString;
  final id = dateId + objectId;
  var categoryColor = "";
  var priorityColor = "";

  if (category == "Work") {
    categoryColor = "0xFFF6CE06";
  } else if (category == "Family") {
    categoryColor = "0xFF2380F9";
  } else {
    categoryColor = "0xFF9D23F9";
  }

  if (priority == "Low") {
    priorityColor = "0xFF18CC36";
  } else {
    priorityColor = "0xFFFF5656";
  }
  firestore.collection("users").doc(uid).collection("toDos").doc(id).set({
    "toDoText": toDoText,
    "category": category,
    "priority": priority,
    "categoryColor": categoryColor,
    "priorityColor": priorityColor,
    "id": id.toString()
  });

  print(id.toString());
}

// ignore: non_constant_identifier_names
Future<void> RemoveToDo(uid, id) async =>
    firestore.collection("users").doc(uid).collection("toDos").doc(id).delete();
