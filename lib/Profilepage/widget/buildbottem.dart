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
        // color: Colors.lightBlue,
        decoration:
            // BoxDecoration(image: DecorationImage(image: AssetImage(''))),
            ShapeDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/dash background.jpg')),
                // color: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)))));
  }
}
