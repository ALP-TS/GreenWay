///Dart 2.17
/// Dart
/// Dart 2.17
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:greenway/carousal/widget/carousalslider.dart';
import 'package:greenway/dashboard/widget/bottomnavigationbar.dart';
import 'package:greenway/data.dart/apicalls.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:greenway/nointernet/check_conection.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/screen/newcorsedetailpage.dart';
import 'package:greenway/splashscreen/widgets/loader.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => splashscreenState();
}

class splashscreenState extends State<splashscreen> {
  secureScreen() async {
    await NoScreenshot.instance.screenshotOff();
    await WakelockPlus.enable();
  }

  String? appPackageName;
  @override
  void initState() {
    super.initState();

    checkConnectivity().then((isConnected) {
      if (isConnected) {
        Future.delayed(Duration(seconds: 5), () {
          wheretogo();
          // Navigate to the home screen after the delay

        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NetworkIssuePage()),
        );
      }
    });
  }

  Future<bool> checkConnectivity() async {
    final results = await Connectivity().checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 180, maxHeight: 180),
                  child: Image.asset(logo, fit: BoxFit.contain),
                ),
                const SizedBox(height: 20),
                Text(
                  Instittename,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Brand.text,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Learn anytime, anywhere',
                  style: TextStyle(fontSize: 14, color: Brand.textMuted),
                ),
                const SizedBox(height: 40),
                const loader(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<String>> _safeCategories() async {
    try {
      return await coursecategory();
    } catch (e) {
      debugPrint('coursecategory failed: $e');
      return [];
    }
  }

  void wheretogo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    setState(() {
      appPackageName = packageName;
    });
    if (kDebugMode) {
      print('AppName: $appName');

      print('PackageName: $packageName');
      print('Version: $version');
      print('BuildNumber: $buildNumber');
    }
    String? status = await checkupdate(version);
    print('status is $status');
    if (status == 'hide') {
      var sharedpref = await SharedPreferences.getInstance();
      rememberUser = sharedpref.getBool(KEYLOGIN);

      studentId = sharedpref.getString(id);
      userId = sharedpref.getString(usrid);

      if (rememberUser != null) {
        List<String> pic = await getsliderimage();
        setState(() {
          if (kDebugMode) {
            print('pic is $pic');
          }

          img = pic;
        });
        if (rememberUser == true) {
          String? status = await userisblock(userId!);
          if (status == '0') {
            print('block status is $status');
            print('exit');
            _showDialog(context);
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => navigationbar(),
              ),
            );
          }
        } else {
          final categorydata = await _safeCategories();
          if (!mounted) return;

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => newcourse(
                categorydata: categorydata,
              ),
            ),
          );
        }
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Onboarding(),
          ),
        );
      }
    } else {
      _showDialogversion(context);
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('You were blocked by admin'),
          actions: <Widget>[
            Row(children: [
              ElevatedButton(
                onPressed: () {
                  exit(0); // Close the dialog
                },
                child: Text('Close'),
              ),
            ]),
          ],
        );
      },
    );
  }

  void _showDialogversion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Available'),
          content: Text('Please update your app'),
          actions: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ElevatedButton(
                onPressed: () {
                  print('object');
                  _openStoreAppPage(context);
                  // Close the dialog
                },
                child: Text('Update'),
              ),
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop(); // Close the dialog
                },
                child: Text('Close'),
              ),
            ]),
          ],
        );
      },
    );
  }

  _openStoreAppPage(BuildContext context) async {
    var playstoreUrl = Uri.parse(
        "https://play.google.com/store/apps/details?id=$appPackageName");
    print('url is $playstoreUrl');
    try {
      await launchUrl(
        playstoreUrl,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
    }
  }

  checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    if (kDebugMode) {
      print('AppName: $appName');
      print('PackageName: $packageName');
      print('Version: $version');
      print('BuildNumber: $buildNumber');
    }

  }
}

