import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenway_lms/carousal/caroualpage.dart';
import 'package:greenway_lms/dashboard/widget/bottomnavigationbar.dart';
// import 'package:greenway_lms/dashboard/dashboard.dart';
// import 'package:greenway_lms/dashboard/widget/bottomnavigationbar.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:greenway_lms/data.dart/urls.dart';
import 'package:greenway_lms/others/constants.dart';
// import 'package:rn_plus/screen/chatorlmscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:lms/data/data.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // String login;
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: const AssetImage("assets/images/bg.png"),
      //     fit: BoxFit.cover,
      //     colorFilter:
      //         ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
      //   ),
      // ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Image(
              image: AssetImage('assets/Rnlogo-removebg-preview (3).png'),
              height: 150,
            ),
          ),
          Text(
            'Success Point Accademy',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Stack(
      children: [
        SizedBox(
          width: mediaSize.width,
          height: 440,
          child: Card(
            color: kblue,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: _buildForm(),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            child: Opacity(
              opacity:
                  0.2, // Set the opacity value between 0.0 and 1.0 (0.0 means fully transparent, 1.0 means fully opaque)
              child: Image.asset(
                'assets/img4.png',
                height: 400,
              ),
            ),
          ),
        ),
        SizedBox(
          width: mediaSize.width,
          height: 440,
          child: Card(
            color: kblue.withOpacity(0.5),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: _buildForm(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome",
          style: TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 60),
        Center(
          child: Column(
            children: [
              _buildGreyText("Username"),
              _buildInputField(usernameController),
              const SizedBox(height: 40),
              _buildGreyText("Password"),
              _buildInputFieldpass(passwordController),
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Center(child: _buildProced()),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {bool isnumber = false}) {
    TextInputType keyboardType =
        isnumber ? TextInputType.number : TextInputType.text;
    List<TextInputFormatter>? inputFormatters =
        isnumber ? [FilteringTextInputFormatter.digitsOnly] : null;

    return Container(
      width: 279,
      height: 37,
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.33),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            // Remove the underline
          ),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
        ),
      ),
    );
  }

  Widget _buildInputFieldpass(TextEditingController controller,
      {bool isnumber = false}) {
    TextInputType keyboardType =
        isnumber ? TextInputType.number : TextInputType.text;
    List<TextInputFormatter>? inputFormatters =
        isnumber ? [FilteringTextInputFormatter.digitsOnly] : null;

    return Container(
      width: 279,
      height: 37,
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.33),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          obscureText: true,
          textAlign: TextAlign.center,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            // Remove the underline
          ),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
        ),
      ),
    );
  }

  Widget _buildProced() {
    return SizedBox(
      width: 247,
      height: 52,
      child: ElevatedButton(
        onPressed: () async {
          final _result = await login(usernameController.text.toString(),
              passwordController.text.toString());
          print(_result);

          if (_result?.status == "success") {
            setState(() {
              password_status = _result?.status;
              loginmessage = _result?.message;
              studentId = _result?.data?.studentId;
              userId = _result?.data?.userId;
              classId = _result?.data?.classId;
              stuname = _result?.data?.name;
              phone = _result?.data?.phone;
              expireDate = _result?.data?.expireDate;
              seenVideo = _result?.data?.seenVideo;
              ip = _result?.data?.ip;
              deviceId = _result?.data?.deviceId;
              status = _result?.data?.status;
              utype = _result?.data?.utype;
            });
            securemode = await getsecuremod();
            final _status = await fee_status(userId!);
            newdeviceid = await getDeviceId();
            print(newdeviceid);
            // print('Device ID: $newdeviceid');

            // print(_status?.status);
            // print(_status?.message);
            // print(_status!.data?.status);
            setState(() {
              feestatus = _status?.data?.status;

              // login = usernameController.text;
            });
            print('$deviceId nn');
            print('$newdeviceid yy');
            // print(securemode);
            if (securemode == 'privent_m_l' || securemode == 'a_2d_s_n') {
            // if (securemode == 'none') {
              print('$deviceId nn');
              print('$newdeviceid yy');
              print(userId);
              print('pk');
              if (deviceId == '' || deviceId == null) {
                String? update = await deviceidupdate(userId!, newdeviceid);
                print('uooooppdatttd$update');
                print(newdeviceid);
              } else {
                print('$deviceId nn');
                print('$newdeviceid yy');
                if (deviceId == newdeviceid) {
                  var sharedPref = await SharedPreferences.getInstance();

                  sharedPref.setBool(KEYLOGIN, true);

                  sharedPref.setString(id, studentId!);
                  sharedPref.setString(usrid, userId!);
                  sharedPref.setString(Dceid, newdeviceid!);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            navigationbar()), // MaterialPageRoute(builder: (context) => navigationbar()),
                  );
                } else {
                  showMessage(
                      context, 'please login with your previous device');
                }
              }
            } else {
              var sharedPref = await SharedPreferences.getInstance();
              sharedPref.setBool(KEYLOGIN, true);
              sharedPref.setString(id, studentId!);
              sharedPref.setString(usrid, userId!);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        navigationbar()), // MaterialPageRoute(builder: (context) => navigationbar()),
              );
            }

            // final SharedPreferences sharedPreferences =
            //     (await SharedPreferences.getInstance) as SharedPreferences;
            // sharedPreferences.setString('email', usernameController.text);
          } else {
            showMessage(context, 'Invalid credentials');
            debugPrint("Invalid credentials");
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          backgroundColor: korange,
          shadowColor: myColor,
        ),
        child: const Text("PROCEED"),
      ),
    );
  }
}

void showMessage(BuildContext context, String msg) {
  // Create an AlertDialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Warning'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
