import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_konsolto_task/to_do_list_database.dart';
import 'package:to_do_list_konsolto_task/to_do_list_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ToDoListDatabase())
    ],
    child: ToDoListApplication(),
  ));
}

class ToDoListApplication extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return _errorWidget(snapshot.error);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return _mainApplication();
          }
          return _waitingWidget();
        });
  }

  Widget _mainApplication() {
    return MaterialApp(
      title: 'To-do list',
      theme: ThemeData(
          checkboxTheme: CheckboxThemeData(
              checkColor: MaterialStateProperty.all(Colors.white),
              fillColor: MaterialStateProperty.all(Colors.orange)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange))),
          //primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
              backwardsCompatibility: false,
              color: Colors.white,
              elevation: 0,
              centerTitle: true,
              actionsIconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 20))),
      home: ToDoListView(),
    );
  }

  Widget _waitingWidget() {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _errorWidget(Object? message) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Text(message.toString()),
        ),
      ),
    );
  }
}
