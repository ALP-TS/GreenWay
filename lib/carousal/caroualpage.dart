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
      title:
          'Welcome to the future of medical education. Your journey to excellence starts here'
      // 'Announcements'
      ,
      image: 'assets/welsli1.png',
      discription: ''
      // " Include a feature for broadcasting important announcements and alerts to the entire school community, ensuring that critical information reaches everyone."
      ),
  UnbordingContent(
      title:
          'Welcome to a community of learners and healers. Together, we achieve greatness.'
      // 'Instant Messaging:'
      ,
      image: 'assets/welsli2.png',
      discription: ''
      // " Provide a real-time messaging feature that allows users to send and receive messages instantly, fostering quick and efficient communication."
      ),
  UnbordingContent(
      title:
          'Where learning meets compassion. Welcome to our medical education platform.',
      // 'Group Chats',
      image: 'assets/sli3.png',
      discription: ''
      // "Enable users to create and participate in group chats, making it easier for teachers to communicate with their classes or for students to collaborate on group projects."
      ),
];
