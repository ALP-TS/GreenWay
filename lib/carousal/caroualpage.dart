import 'dart:ui';

import 'package:flutter/material.dart';

class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {this.image = '', required this.title, required this.discription});
}

Color kgrey = Color.fromARGB(255, 220, 251, 255);
Color kblue = const Color(0xFF0004CA); //logo color
Color kwhite = const Color(0xFFFFFFFF);
Color kblack = const Color(0xFF000000);
Color korange = Colors.green; //logo color
List<UnbordingContent> contents = [
  UnbordingContent(
      title:
          'Welcome to the future of medical education. Your journey to excellence starts here'
      ,
      discription: ''
      ),
  UnbordingContent(
      title:
          'Welcome to a community of learners and healers. Together, we achieve greatness.'
      ,
      discription: ''
      ),
  UnbordingContent(
      title:
          'Where learning meets compassion. Welcome to our medical education platform.',
      discription: ''
      ),
];
