import 'package:flutter/material.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/dashboard/widget/bottomnavigationbar.dart';
import 'package:greenway_lms/screen/chatscreen.dart';
import 'package:lottie/lottie.dart';

class chatorlms extends StatelessWidget {
  const chatorlms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_chatapp(context), _lms(context)],
        )),
      ),
    );
  }
}

Widget _chatapp(BuildContext context) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => chatscreen()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: myGradient, borderRadius: BorderRadius.circular(30)),
          width: 200,
          height: 200,
          child: LottieBuilder.asset(
            'assets/chatlogo.json',
          ),
        ),
      ),
      SizedBox(
        child: Text('GO TO CHAT',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
      )
    ],
  );
}

Widget _lms(BuildContext context) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navigationbar()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: myGradient, borderRadius: BorderRadius.circular(30)),
          width: 200,
          height: 200,
          child: LottieBuilder.asset(
            'assets/lmslogo.json',
          ),
        ),
      ),
      SizedBox(
        child: Text('GO TO LMS',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
      )
    ],
  );
}
