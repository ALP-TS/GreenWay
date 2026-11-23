import 'package:flutter/material.dart';

///Dart 2.17
/// Dart
/// Dart 2.17
class buildtopprofile extends StatelessWidget {
  const buildtopprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Align(
          alignment: Alignment.topLeft,
          child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios),
              label: Text('')),
        ),
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backgroundlms.jpg'),
              fit: BoxFit.cover)),
      height: double.infinity,
      width: double.infinity,
    );
  }
}
