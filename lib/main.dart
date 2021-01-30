import 'package:pendlerinfo/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(PendlerinfoApp());
}

class PendlerinfoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Home(),
    );
  }
}