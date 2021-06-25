import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_konsolto_task/add_to_do_element.dart';
import 'package:to_do_list_konsolto_task/to_do_list_database.dart';
import 'package:to_do_list_konsolto_task/to_do_list_tile.dart';

class ToDoListView extends StatefulWidget {
  @override
  _ToDoListViewState createState() => _ToDoListViewState();
}

class _ToDoListViewState extends State<ToDoListView> {
  final scaffoldStateKey = GlobalKey<ScaffoldState>();
  Widget _addButton() {
    return IconButton(
        tooltip: 'Increment',
        onPressed: () {
          scaffoldStateKey.currentState!
              .showBottomSheet((context) => AddToDoElement());
        },
        icon: Icon(Icons.add));
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ToDoListDatabase>(context).fetchData();
    return Scaffold(
      key: scaffoldStateKey,
      appBar: AppBar(
        actions: [_addButton()],
        title: Text('Your to-do list'),
      ),
      body: ListView.builder(
          itemCount:
              Provider.of<ToDoListDatabase>(context).toDoMap.values.length,
          itemBuilder: (context, index) {
            return ToDoListTile(
                elementId: Provider.of<ToDoListDatabase>(context)
                    .toDoMap
                    .keys
                    .elementAt(index),
                element: Provider.of<ToDoListDatabase>(context)
                    .toDoMap
                    .values
                    .elementAt(index));
          }),
    );
  }
}
