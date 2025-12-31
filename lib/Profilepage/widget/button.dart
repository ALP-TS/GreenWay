import 'package:flutter/material.dart';
import 'package:greenway_lms/others/constants.dart';

///Dart 2.17
/// Dart
/// Dart 2.17
class button_profile extends StatelessWidget {
  const button_profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          color: Colors.amber,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)))),
      height: 52,
      width: 247,
      child: TextButton.icon(
        onPressed: () {},
        label: Text('Standard $classId'),
        icon: Icon(Icons.school),
      ),
    );
  }
}
