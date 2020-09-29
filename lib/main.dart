import 'package:flutter/material.dart';
import 'package:my_first_project/home.dart';

main(List<String> args) {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}