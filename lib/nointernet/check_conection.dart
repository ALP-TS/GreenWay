import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

///Dart 2.17
/// Dart
/// Dart 2.17
class NetworkIssuePage extends StatelessWidget {
  const NetworkIssuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Check Connection',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              LottieBuilder.asset(
                'assets/31490-no-connection.json',
                width: 200,
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
