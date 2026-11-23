///Dart 2.17
/// Dart
/// Dart 2.17
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:greenway/theme/app_theme.dart';

class loader extends StatelessWidget {
  const loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitThreeBounce(
      color: Brand.primary,
      size: 22.0,
    );
  }
}
