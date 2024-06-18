import 'package:flutter/material.dart';
// import 'package:lms/carousal/caroualpage.dart';

//login model variable
String? student_Id;
bool? rememberUser;
String? password_status;
String? studentId;
String? userId;
String? classId;
String? stuname;
String? phone;
String? expireDate;
String? seenVideo;
String? seenNote;
String? seenAudio;
String? ip;
String? deviceId;
String? status;
String? student;
String? specification;
String? utype;
DateTime? today;
String? baseurl = 'https://4lms.alp-ts.in/greenway/api';
LinearGradient myGradient = LinearGradient(
  colors: [
    Color.fromRGBO(25, 137, 223, 0.887),
    Color.fromRGBO(2, 60, 220, 0.895)
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
LinearGradient containergradient = LinearGradient(
  colors: [Color.fromRGBO(25, 137, 223, 0.887), Color.fromRGBO(2, 60, 220, .5)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

//feestatus model variable
String? feestatus;
String? loginmessage;
int? course_count;

List? courseid;
List<String>? img;
//indivitual course values
String? coursename;
String? subcoursename;
String? orgamount;
String? offeramount;
String? profile;
String? overview;
String? duration;
String? previewvideo;
String? lectures;
String? language;
String? requirements;

String? star;

class AppColors {
  static const Color kblack1 = const Color.fromARGB(255, 54, 51, 51);
  static const Color anotherColor = Colors.red;
}

///shared preference
// ignore: constant_identifier_names
const String KEYLOGIN = 'login';
const String id = 'stu_id';
const String usrid = 'userid';
const String Dceid = 'deviceid';

bool isOnline = true;

String? newdeviceid;
String? securemode;
bool logout = false;
String timeconvert(dynamic time) {
  String? timestampString = time; // Example nullable string
  if (timestampString != null) {
    int timestamp = int.parse(timestampString);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    int year = date.year;
    int month = date.month;
    int day = date.day;
    String Date = '$day-$month-$year';
    // print('$day-$month-$year');
    // print(Date);
    return Date; // Output: 2024-03-02 01:50:00.000
  } else {
    return "Timestamp string is null.";
  }
}

Widget buildText(String text, Color textColor, double fontSize) {
  return Text(
    text, textAlign: TextAlign.center, // Pass the text parameter here

    maxLines: 12,
    // softWrap: true,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w700,
    ),
  );
}

String logo = 'assets/rn--high-resolution-logo-transparent.png';
