import 'package:flutter/material.dart';
import 'package:greenway_lms/Profilepage/widget/button.dart';
import 'package:greenway_lms/others/constants.dart';

///Dart 2.17
/// Dart
/// Dart 2.17
class avathar_container extends StatelessWidget {
  const avathar_container({super.key});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Container(
      height: _height * 0.6,
      width: _width * 0.6,
      decoration: ShapeDecoration(
          color: Color.fromRGBO(248, 250, 250, 1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$stuname', style: TextStyle(fontSize: 30)),
          TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.call, color: Colors.black),
              label: Text(
                '$phone',
                style: TextStyle(color: Colors.black),
              )),
          TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.email_outlined, color: Colors.black),
              label: Text('email', style: TextStyle(color: Colors.black))),
          // button_profile()
        ],
      ),
    );
  }
}
