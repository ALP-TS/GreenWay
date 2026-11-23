import 'package:flutter/material.dart';

///Dart 2.17
/// Dart
/// Dart 2.17
class buildbottem extends StatelessWidget {
  const buildbottem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration:
            ShapeDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/dash background.jpg')),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)))));
  }
}
