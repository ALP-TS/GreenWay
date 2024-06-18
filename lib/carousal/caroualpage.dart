import 'dart:ui';

import 'package:flutter/material.dart';

class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

Color kgrey = Color.fromARGB(255, 220, 251, 255);
Color kblue = Color.fromRGBO(14, 49, 121, 1); //logo color
Color kwhite = const Color(0xFFFFFFFF);
Color kblack = const Color(0xFF000000);
Color korange = Colors.orange; //logo color
List<UnbordingContent> contents = [
  UnbordingContent(
      title: ''
      // 'Announcements'
      ,
      image: 'assets/slider1.jpeg',
      discription: ''
      // " Include a feature for broadcasting important announcements and alerts to the entire school community, ensuring that critical information reaches everyone."
      ),
  UnbordingContent(
      title: ''
      // 'Instant Messaging:'
      ,
      image: 'assets/slider2.jpeg',
      discription: ''
      // " Provide a real-time messaging feature that allows users to send and receive messages instantly, fostering quick and efficient communication."
      ),
  UnbordingContent(
      title: '',
      // 'Group Chats',
      image: 'assets/slider3.jpeg',
      discription: ''
      // "Enable users to create and participate in group chats, making it easier for teachers to communicate with their classes or for students to collaborate on group projects."
      ),
];
