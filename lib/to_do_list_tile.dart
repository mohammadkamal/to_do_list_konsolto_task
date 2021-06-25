import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_konsolto_task/to_do_element.dart';
import 'package:to_do_list_konsolto_task/to_do_list_database.dart';

class ToDoListTile extends StatefulWidget {
  final String elementId;
  final ToDoElement element;

  const ToDoListTile({Key? key, required this.element, required this.elementId})
      : super(key: key);
  @override
  _ToDoListTileState createState() => _ToDoListTileState();
}

class _ToDoListTileState extends State<ToDoListTile> {

  int _getDateDiff()
  {
    var _date = DateTime.now();
    var _diff = _date.difference(widget.element.due).inDays;
    return _diff;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.element.done,
        onChanged: (bool? value) async {
          context
              .read<ToDoListDatabase>()
              .completeToDoElement(widget.elementId, value!);
        },
      ),
      title: Text(
        widget.element.content,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text('Due to ${_getDateDiff()}d'),
    );
  }
}
