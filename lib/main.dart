import 'package:flutter/material.dart';
import 'package:mausam/home.dart';
import 'package:mausam/loading.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: loading(),
    routes: {
      'main': (context) => Home(),
      'location': (context) => loading(),
      'loading': (context) => loading()
    },
  ));
}
