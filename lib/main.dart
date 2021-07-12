import 'package:flutter/material.dart';
import 'launch.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Launches App',
        home: LaunchView());
  }
}
