///Dart 2.17
/// Dart
/// Dart 2.17
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loader extends StatelessWidget {
  const loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SpinKitRotatingCircle(
        color: Color.fromRGBO(21, 111, 161, 100),
        size: 15.0,
      ),
      SizedBox(
        width: 15,
      ),
      SpinKitRotatingCircle(
        color: Color.fromRGBO(243, 110, 33, 100),
        size: 15.0,
      ),
      SizedBox(
        width: 15,
      ),
      SpinKitRotatingCircle(
        color: Color.fromRGBO(21, 111, 161, 100),
        size: 15.0,
      ),
    ]);
  }
}
