///Dart 2.17
/// Dart
/// Dart 2.17
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:greenway_lms/colors.dart';

class loader extends StatelessWidget {
  const loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SpinKitRotatingCircle(
        color: AppColors.lmsorange,
        size: 15.0,
      ),
      SizedBox(
        width: 15,
      ),
      SpinKitRotatingCircle(
        color: AppColors.lmsblue,
        size: 15.0,
      ),
      SizedBox(
        width: 15,
      ),
      SpinKitRotatingCircle(
        color: AppColors.lmsorange,
        size: 15.0,
      ),
    ]);
  }
}
