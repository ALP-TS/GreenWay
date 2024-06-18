///Dart 2.17
/// Dart
/// Dart 2.17
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:greenway_lms/carousal/widget/carousalslider.dart';
import 'package:greenway_lms/dashboard/widget/bottomnavigationbar.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:greenway_lms/nointernet/check_conection.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/screen/newcorsedetailpage.dart';
import 'package:greenway_lms/splashscreen/widgets/loader.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => splashscreenState();
}

class splashscreenState extends State<splashscreen> {
  secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    await FlutterWindowManager.addFlags(
        FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
  }

  String? appPackageName;
  @override
  void initState() {
    super.initState();
    // secureScreen();

    checkConnectivity().then((isConnected) {
      if (isConnected) {
        Future.delayed(Duration(seconds: 5), () {
          wheretogo();
          // Navigate to the home screen after the delay

          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (context) => Onboarding(),
          //   ),
          // );
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
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(height: 200, width: 200, child: Image.asset(logo)),
        Container(height: 100, child: loader())
      ])),
    );
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
    print('AppName: $appName');
    print('PackageName: $packageName');
    // print('appPackageName:$appPackageName');
    print('Version: $version');
    print('BuildNumber: $buildNumber');
    String? status = await checkupdate(version);
    if (status == 'hide') {
      var sharedpref = await SharedPreferences.getInstance();
      rememberUser = sharedpref.getBool(KEYLOGIN);

      studentId = sharedpref.getString(id);
      // print(studentId);
      userId = sharedpref.getString(usrid);

      if (rememberUser != null) {
        List<String> pic = await getsliderimage();
        setState(() {
          img = pic;
        });
        if (rememberUser == true) {
          String? status = await userisblock(userId!);
          if (status == '0') {
            print('block status is $status');
            // void exitApp() {
            print('exit');
            _showDialog(context);
            // SystemNavigator.pop();
            // }
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => navigationbar(),
              ),
            );
          }
        } else {
          final categorydata = await coursecategory();
          print(categorydata);

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
                  // exit(0);
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
    // var playstoreUrl =
    // Uri.parse("market://details?id=");
    var playstoreUrl = Uri.parse("market://details?id=$appPackageName");
    try {
      await launchUrl(
        playstoreUrl,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      // CustomSnackBar(
      //   context: context,
      //   content: CustomSnackBar.whiteCenterText(
      //     e.toString(),
      //   ),
      // ).showError();
    }
  }

  checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    // setState(() {
    //   appPackageName = packageName;
    // });

    if (kDebugMode) {
      print('AppName: $appName');
      print('PackageName: $packageName');
      // print('appPackageName:$appPackageName');
      print('Version: $version');
      print('BuildNumber: $buildNumber');
    }

    //   ApiRequest request = ApiRequest(
    //       type: ApiType.get,
    //       uri: Constants.checkVersion,
    //       params: <String, dynamic>{
    //         'version': version,
    //       });

    //   ApiResponse response = await request.send();

    //   if (response.is200ok) {
    //     dynamic body = response.jsonBody;
    //     if (body['status'] == 'success' && body['message'] == 'Successfully') {
    //       setState(() {
    //         showUpdatePopup = body['data'] == 'show';
    //       });
    //     }
    //     if (showUpdatePopup) {
    //       updatePopup.show();
    //     } else {
    //       delayedLogin();
    //     }
    //   }
  }
}

// @override
// Widget build(BuildContext context) {
//   // TODO: implement build
//   throw UnimplementedError();
// }
