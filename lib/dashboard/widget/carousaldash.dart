///Dart 2.17
/// Dart
/// Dart 2.17
import 'package:flutter/material.dart';
import 'package:greenway/others/constants.dart';

class carousaldash extends StatelessWidget {
  carousaldash({super.key});
  final List<String> imageUrls = [
    'assets/imageslider.jpg',
    'assets/imageslider.jpg',
    'assets/imageslider.jpg',
    // Add more image URLs as needed
  ];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Container(
      child :null

    );
  }
}
