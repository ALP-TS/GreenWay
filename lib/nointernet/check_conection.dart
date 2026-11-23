import 'package:flutter/material.dart';
import 'package:greenway/splashscreen/splahscreen.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:lottie/lottie.dart';

class NetworkIssuePage extends StatelessWidget {
  const NetworkIssuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LottieBuilder.asset(
                  'assets/31490-no-connection.json',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No internet connection',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Brand.text,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please check your Wi-Fi or mobile data and try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15, color: Brand.textMuted, height: 1.4),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const splashscreen()),
                      );
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Try again'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
