import 'package:flutter/material.dart';
import 'package:greenway_lms/Profilepage/widget/avathar_container.dart';
import 'package:greenway_lms/Profilepage/widget/buildbottem.dart';
import 'package:greenway_lms/Profilepage/widget/buildtop.dart';
import 'package:greenway_lms/Profilepage/widget/button.dart';
import 'package:greenway_lms/Profilepage/widget/circular_avathar.dart';

// import 'flutter/src/widgets/container.dart';
///Dart 2.17
/// Dart
/// Dart 2.17
class profile_page extends StatelessWidget {
  const profile_page({super.key});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
      body: Stack(children: <Widget>[
        buildtopprofile(),
        // Positioned(
        // bottom: 0, left: 0, right: 0, height: 608, child: buildbottem()),
        Positioned(
            top: _height * 0.2,
            left: _width * 0.02,
            right: _width * 0.02,
            bottom: _height * 0.2,
            child: const avathar_container()),
        Positioned(
            top: _height * 0.1,
            left: _width * 0.32,
            child: const circular_avathar()),
        // Positioned(bottom: 380, left: 100, right: 100, child: button_profile())
      ]),
    );
  }
}
