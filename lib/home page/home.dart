import 'package:flutter/material.dart';
import 'package:greenway/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        toolbarHeight: 80,
        backgroundColor: AppColors.lmsblue,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SizedBox(),
              Text(
                "NOTIFICATION",
                style: TextStyle(
                  color: AppColors.lmswhite,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.jpeg'),
              )
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
          ),
    );
  }
}
