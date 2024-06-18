///Dart 2.17
/// Dart
/// Dart 2.17
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:greenway_lms/others/constants.dart';

class carousaldash extends StatelessWidget {
  carousaldash({super.key});
  final List<String> imageUrls = [
    'assets/dashpage1 (1).jpg',
    'assets/dashpage1 (1).jpg',
    'assets/dashpage1 (1).jpg',
    // Add more image URLs as needed
  ];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Container(
      // color: Colors.amber,
      child: CarouselSlider(
        options: CarouselOptions(
          height: _height * 0.2,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
        ),
        items: img!.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
