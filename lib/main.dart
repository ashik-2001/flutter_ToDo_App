import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app1/screen_home.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('testBox');
  runApp(const Todo());
}

class Todo extends StatelessWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(primaryColor: Colors.blue),
      home: ScreenHome(),
    );
  }
}