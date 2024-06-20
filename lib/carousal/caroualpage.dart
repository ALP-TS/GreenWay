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
Color kblue = Colors.blue; //logo color
Color kwhite = const Color(0xFFFFFFFF);
Color kblack = const Color(0xFF000000);
Color korange = Colors.green; //logo color
List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Empower your knowledge. Transform healthcare. Start learning today'
      // 'Announcements'
      ,
      image: 'assets/welsli1.png',
      discription: ''
      // " Include a feature for broadcasting important announcements and alerts to the entire school community, ensuring that critical information reaches everyone."
      ),
  UnbordingContent(
      title: 'Every step in your learning path brings us closer to a healthier world.'
      // 'Instant Messaging:'
      ,
      image: 'assets/welsli2.png',
      discription: ''
      // " Provide a real-time messaging feature that allows users to send and receive messages instantly, fostering quick and efficient communication."
      ),
  UnbordingContent(
      title: 'Knowledge is the best medicine. Start your educational journey with us today.',
      // 'Group Chats',
      image: 'assets/slider3.jpeg',
      discription: ''
      // "Enable users to create and participate in group chats, making it easier for teachers to communicate with their classes or for students to collaborate on group projects."
      ),
];
