import 'package:flutter/material.dart';
import 'package:crud_unifacef/ui/listview_student.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Miguel e Pedro Crud',
      theme: ThemeData(primarySwatch: Colors.red),
      home: ListViewStudent(),
    );
  }
}
