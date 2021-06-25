import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_konsolto_task/to_do_element.dart';
import 'package:to_do_list_konsolto_task/to_do_list_database.dart';

class AddToDoElement extends StatefulWidget {
  @override
  _AddToDoElementState createState() => _AddToDoElementState();
}

class _AddToDoElementState extends State<AddToDoElement> {
  // Controllers to get the values of the textFields
  final _contentController = TextEditingController();
  final _yearController =
      TextEditingController(text: DateTime.now().year.toString());
  final _monthController =
      TextEditingController(text: DateTime.now().month.toString());
  final _dayController =
      TextEditingController(text: DateTime.now().day.toString());
  final _hourController =
      TextEditingController(text: DateTime.now().hour.toString());
  final _minuteController =
      TextEditingController(text: DateTime.now().minute.toString());

  // Decorate the input
  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));
  }

  Widget _contentTextField() {
    return Container(
        child: TextField(
      decoration: _inputDecoration('Content'),
      controller: _contentController,
    ));
  }

  Widget _yearField() {
    return Container(
        width: MediaQuery.of(context).size.width / 6,
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: _inputDecoration('Year'),
          controller: _yearController,
        ));
  }

  Widget _monthField() {
    return Container(
        width: MediaQuery.of(context).size.width / 6,
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: _inputDecoration('Month'),
          controller: _monthController,
        ));
  }

  Widget _dayField() {
    return Container(
        width: MediaQuery.of(context).size.width / 6,
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: _inputDecoration('Day'),
          controller: _dayController,
        ));
  }

  Widget _hourField() {
    return Container(
        width: MediaQuery.of(context).size.width / 6,
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: _inputDecoration('Hour'),
          controller: _hourController,
        ));
  }

  Widget _minuteField() {
    return Container(
        width: MediaQuery.of(context).size.width / 6,
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: _inputDecoration('Minute'),
          controller: _minuteController,
        ));
  }

  Widget _timePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _yearField(),
        Text('/'),
        _monthField(),
        Text('/'),
        _dayField(),
        _hourField(),
        Text(':'),
        _minuteField()
      ],
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () async {
        var _toDo = ToDoElement(
            done: false,
            content: _contentController.text,
            due: DateTime(
              int.parse(_yearController.text),
              int.parse(_monthController.text),
              int.parse(_dayController.text),
              int.parse(_hourController.text),
              int.parse(_minuteController.text),
            ));
        // Adds the element to the list then back from the bottom sheet
        await context.read<ToDoListDatabase>().addToDoElement(_toDo).whenComplete(() => Navigator.pop(context));
      },
      child: Text('Submit'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [_contentTextField(), _timePicker(), _submitButton()],
    ));
  }
}
