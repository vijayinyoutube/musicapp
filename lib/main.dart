import 'package:flutter/material.dart';
import 'package:musicapp/Player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlayerPage(),
    );
  }
}
