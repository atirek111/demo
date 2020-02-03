import 'package:flutter/material.dart';
import 'login/welcomePage.dart';
void main() =>
    runApp(Fiwi());
class Fiwi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fiwi',

      home: WelcomePage(),

    );
  }
}
