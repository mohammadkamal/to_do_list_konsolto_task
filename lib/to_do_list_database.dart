import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_konsolto_task/to_do_element.dart';

class ToDoListDatabase extends ChangeNotifier {
  CollectionReference<Map<String, dynamic>> toDoCollection =
      FirebaseFirestore.instance.collection('ToDoCollection');

  Map<String, ToDoElement> _toDoMap = new Map<String, ToDoElement>();
  UnmodifiableMapView<String, ToDoElement> get toDoMap =>
      UnmodifiableMapView(_toDoMap);

  Future<void> addToDoElement(ToDoElement toDoElement) async {
    // Generates document with id
    var result = toDoCollection.doc();
    var id = result.id;
    // Sets the document data
    result.set(toDoElement.toJson());
    // Sets the data locally
    _toDoMap[id] = toDoElement;
    //Updates the list
    notifyListeners();
  }

  // Changes the task to completed or uncompleted
  Future<void> completeToDoElement(String elementId, bool isDone) async {
    toDoCollection.doc(elementId).update({'done': isDone});
    var _newElement = ToDoElement(
        done: isDone,
        content: _toDoMap[elementId]!.content,
        due: _toDoMap[elementId]!.due);
    _toDoMap[elementId] = _newElement;
    notifyListeners();
  }

  //Fetchs the data from Firestore
  Future<void> fetchData() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await toDoCollection.get();
    var list = querySnapshot.docs;
    list.forEach((element) {
      _toDoMap[element.id] = ToDoElement.fromJson(element.data());
    });
    notifyListeners();
  }
}
