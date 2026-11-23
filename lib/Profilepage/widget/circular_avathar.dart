import 'package:flutter/material.dart';
import 'package:greenway/others/constants.dart';

///Dart 2.17
/// Dart
/// Dart 2.17
class circular_avathar extends StatelessWidget {
  const circular_avathar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isvariable = false;
    if (feestatus == 'active') {
      isvariable = true;
    }
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return isvariable
        ? CircleAvatar(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/AVATHAR.png'),
              radius: _width * 0.15,
            ),
            radius: _width * 0.175,
            backgroundColor: Colors.green,
          )
        : CircleAvatar(
            child: CircleAvatar(
              radius: _width * 0.18,
            ),
            radius: _width * 0.2,
            backgroundColor: Colors.red,
          );
  }
}
