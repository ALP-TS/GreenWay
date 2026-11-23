import 'dart:convert';
import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:greenway/data.dart/coursedetailsindivitual/coursedetailsindivitual.dart';
import 'package:greenway/data.dart/feestatusmodel/feestatusmodel.dart';
import 'package:greenway/data.dart/getsubjectmodel/datum.dart';

import 'package:greenway/data.dart/loginmodel/loginmodel.dart';
import 'package:greenway/data.dart/studentdetailsmodel/studentdetailsmodel.dart';
import 'package:greenway/data.dart/topiclistingmodel/datum.dart';

import 'package:greenway/data.dart/urls.dart';
import 'package:greenway/others/constants.dart';

Map<String, String> headers = {
  'API-Key': apiKey, // Assuming your API key is passed as a Bearer token
};

/// Debug-only log of an API call: endpoint, fields sent, status and full body.
/// Prints nothing in release builds.
void logApi(String name, Map<String, Object?> sent, Response response) {
  if (!kDebugMode) return;
  debugPrint('┌── API $name  [HTTP ${response.statusCode}]');
  debugPrint('│ sent: $sent');
  String body = response.body;
  try {
    body = const JsonEncoder.withIndent('  ').convert(jsonDecode(body));
  } catch (_) {}
  for (final line in body.split('\n')) {
    debugPrint('│ $line', wrapWidth: 900);
  }
  debugPrint('└── end $name');
}

Future<Loginmodel?> login(String email, password) async {
  try {
    final response = await post(Uri.parse(URLS.loginurl),
        headers: headers, body: {'username': email, 'password': password});
    print(response.statusCode);
    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;
      final data = Loginmodel.fromJson(bodyasjson);
      return data;
    } else {
      print('failed');
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<List<String>> getsliderimage() async {
  try {
    final response = await get(
      Uri.parse(URLS.sliderimage),
      headers: headers,
    );
    print('object');
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        Map<String, dynamic> dataList =
            Map<String, dynamic>.from(data['data']['slider_img']);
        List<String> img = [
          dataList['0'],
          dataList['1'],
          dataList['2'],
        ];

        print(img.toString());

        return img;
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return [];
}

Future<Studentdetailsmodel?> loginalready(id) async {
  try {
    final response = await post(
      Uri.parse(URLS.loginalready + id),
      headers: headers,
    );
    print('${response.statusCode}of login');
    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;
      final data = Studentdetailsmodel.fromJson(bodyasjson);
      print('$bodyasjson of login');
      return data;
    } else {
      print('failed');
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<Feestatusmodel?> fee_status(
  String id,
) async {
  try {
    final response = await get(
      Uri.parse(URLS.feestatus + id),
      headers: headers,
    );
    print('${response.statusCode}uuuuuuuuu');
    print(response);
    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;
      final data = Feestatusmodel.fromJson(bodyasjson);
      return data;
    } else {
      print('failed');
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<List<Map<String, dynamic>>> getallcourse() async {
  // Replace with your actual API endpoint

  try {
    final response = await get(
      Uri.parse(URLS.getallcourse),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data['status']);

      if (data['status'] == 'success') {
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data['data']);
        course_count = dataList.length.toInt();

        return dataList;
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (error) {
    throw Exception('Failed to fetch data: $error');
  }
}

Future<Coursedetailsindivitual?> courseindivitual(List id) async {
  try {
    final result = await get(
      Uri.parse(URLS.getonecourse + id[0]),
      headers: headers,
    );
    print(id);
    print(URLS.getonecourse);
    if (result.statusCode == 200) {
      final bodyasjson = jsonDecode(result.body) as Map<String, dynamic>;
      final data = Coursedetailsindivitual.fromJson(bodyasjson);

      return data;
    } else {
      print(result.statusCode);
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<Map<String, dynamic>> corsebyid(String id) async {
  try {
    final result = await get(
      Uri.parse(URLS.getonecourse + id),
      headers: headers,
    );
    print(id);
    print(URLS.getonecourse);
    print(result.statusCode);

    if (result.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(result.body);
      print(data);
      if (data['status'] == 'success') {
        return data['data']; // Return the data directly, as it's already a map
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${result.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to fetch data: $e');
  }
}

///Api for horizondal scrool
Future<List<Map<String, dynamic>>> randomcourse() async {
  final response = await get(
    Uri.parse(URLS.randomCourse),
    headers: headers,
  );
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> data = jsonData['data'];
    return List<Map<String, dynamic>>.from(
        data.map((item) => Map<String, dynamic>.from(item)));
  } else {
    throw Exception('Failed to load courses');
  }
}

Future<List<Datum>> getsubjects(String id) async {
  final response = await get(
    Uri.parse(URLS.getsubjects + '$id' + URLS.getsubject2),
    headers: headers,
  );
  print(id);
  print(URLS.getsubjects + '=' + '$id' + URLS.getsubject2);
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);

    if (jsonData['status'] == 'success') {
      final List<dynamic> dataJson = jsonData['data'];
      return dataJson.map((json) => Datum.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }
  return [];
}

Future<List<Datumtopic>> gettopic(String id) async {
  print(URLS.gettopic + id + URLS.gettopicendpoint2);

  final response = await get(
    Uri.parse(URLS.gettopic + id + URLS.gettopicendpoint2),
    headers: headers,
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);

    if (jsonData['status'] == 'success') {
      final List<dynamic> dataJson = jsonData['data'];
      return dataJson.map((json) => Datumtopic.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }
  return [];
}

Future<List<Map<String, dynamic>>> getallvideos(String topicid) async {
  try {
    final response = await get(
      Uri.parse(URLS.getallvideos + topicid),
      headers: headers,
    );
    print(topicid);
    if (response.statusCode == 200) {
      print('suji ');
      print(topicid);
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data['data']);
        course_count = dataList.length.toInt();
        return dataList;
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (e) {
    print(e.toString());

  }
  return [];
}

Future<List<Map<String, dynamic>>> getallpdf(String topicid) async {
  try {
    final response = await get(
      Uri.parse(URLS.getallpdf + topicid),
      headers: headers,
    );
    print(topicid);
    if (response.statusCode == 200) {
      print('suji ');
      print(topicid);
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data['data']);
        course_count = dataList.length.toInt();
        return dataList;
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (e) {
    print(e.toString());

  }
  return [];
}

Future<List<Map<String, dynamic>>> getallaudio(String topicid) async {
  try {
    final response = await get(
      Uri.parse(URLS.getallaudio + topicid),
      headers: headers,
    );
    print(topicid);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data['data']);
        course_count = dataList.length.toInt();
        return dataList;
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (e) {
    print(e.toString());

  }
  return [];
}

Future<String> getDeviceId() async {
  String deviceId = '';

  try {
    if (Platform.isAndroid) {
      deviceId = await const AndroidId().getId() ?? '';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;
      deviceId = iosInfo.identifierForVendor ?? ''; // iOS ID
    }
  } catch (e) {
    print("Error getting device ID: $e");
  }

  return deviceId;
}

Future<String?> deviceidupdate(String userid, deviceid) async {
  try {
    final response = await post(Uri.parse(URLS.deviceid),
        headers: headers, body: {'user_id': userid, 'device_id': deviceid});
    print('store_device_id user=$userid device=$deviceid '
        'status=${response.statusCode} body=${response.body}');

    if (response.statusCode == 200) {
      final bodyasjson = json.decode(response.body) as Map<String, dynamic>;
      return bodyasjson['message']?.toString();
    } else {
      return 'HTTP ${response.statusCode}';
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<String> getsecuremod() async {
  String securemod = '';
  try {
    final response = await get(
      Uri.parse(URLS.getsecuremod),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        Map<String, dynamic> innerdata =
            Map<String, dynamic>.from(data['data']);
        securemod = innerdata['secure_mod'];
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (e) {
    print("Error getting device ID: $e");
  }

  return securemod;
}

Future<List<Map<String, dynamic>>> searchresult(String search) async {
  // Replace with your actual API endpoint

  try {
    final response = await post(Uri.parse(URLS.getsearchresult),
        headers: headers, body: {'search': search});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data['status']);

      if (data['status'] == 'success') {
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data['data']);
        course_count = dataList.length.toInt();

        return dataList;
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (error) {
    throw Exception('Failed to fetch data: $error');
  }
}

Future<List<Map<String, dynamic>>> courseprogress() async {
  // Replace with your actual API endpoint

  try {
    final response = await post(Uri.parse(URLS.getcoursedetails),
        headers: headers, body: {'class_id': classId, 'student_id': studentId});
    print(response.body);
    print("${response.statusCode}ttt");
    print('${response.headers['location']}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'success') {
        List<Map<String, dynamic>> result =
            List<Map<String, dynamic>>.from(data['data']);

        return result;
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.body}');
    }
  } catch (error) {
    throw Exception('Failed to fetch data: $error');
  }
}

Future<List<String>> coursecategory() async {
  final response = await get(
    Uri.parse(URLS.coursecategory),
    headers: headers,
  );
  print(response.body);
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == 'success') {
      final List<dynamic> data = jsonResponse['data'];
      final List<String> result = List<String>.from(data);

      return result;
    } else {
      // If the status is not 'success', throw an exception or handle accordingly
      throw Exception('API request failed: ${jsonResponse['message']}');
    }
  } else {
    throw Exception('Failed to load courses');
  }
}

Future<List<Map<String, dynamic>>> categorycourse(name) async {
  // Replace with your actual API endpoint

  try {
    final response = await post(Uri.parse(URLS.allcategorycourse),
        headers: headers, body: {'category': name});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data['status']);

      if (data['status'] == 'success') {
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data['data']);
        course_count = dataList.length.toInt();

        return dataList;
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (error) {
    throw Exception('Failed to fetch data: $error');
  }
}

Future<List<Map<String, dynamic>>> getexam(String userid) async {
  try {
    final response = await post(Uri.parse(URLS.getallexam),
        headers: headers, body: {'user_id': userid});
    logApi('view_exam_list', {'user_id': userid}, response);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data['data']);
        course_count = dataList.length.toInt();
        return dataList;
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (e) {
    print(e.toString());

  }
  return [];
}

Future<List<dynamic>> examresult(String userid, String examid) async {
  try {
    final response = await post(Uri.parse(URLS.viewexam),
        headers: headers, body: {'user_id': userid, 'examid': examid});
    logApi('exam_result', {'user_id': userid, 'examid': examid}, response);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data['status']);
      if (data['status'] == 'success') {
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data['data']);
        Map<String, dynamic> result =
            Map<String, dynamic>.from(data['f_result']);
        course_count = dataList.length.toInt();
        print(result.toString());
        List<dynamic> listOfLists = [dataList, result];
        
        return listOfLists;
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (e) {
    print(e.toString());

  }
  return [];
}

Future<List<dynamic>> startexam(String userid, String examid) async {
  try {
    final response = await post(Uri.parse(URLS.startexam),
        headers: headers, body: {'user_id': userid, 'examid': examid});
    logApi('exam_start', {'user_id': userid, 'examid': examid}, response);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data['data']);
        Map<String, dynamic> exam = Map<String, dynamic>.from(data['exam']);
        List<dynamic> list = [dataList, exam];
        print(dataList.toString());
        return list;
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (e) {
    print(e.toString());

  }
  return [];
}

/// Submits one answer and returns the full decoded reply (or null on failure).
/// Used by mock exams, which need the correct answer from the reply.
Future<Map<String, dynamic>?> submitAnswer(
  String quesid,
  String ans,
  String examid,
  String userid,
) async {
  try {
    final body = {
      'qnsid': quesid,
      'ans': ans,
      'examid': examid,
      'user_id': userid,
    };
    final response =
        await post(Uri.parse(URLS.nextquestion), headers: headers, body: body);
    logApi('next_question', body, response);
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
  } catch (e) {
    debugPrint('submitAnswer failed: $e');
  }
  return null;
}

Future<String> nextques(
  String quesid,
  String ans,
  String examid,
  String userid,
) async {
  try {
    final response =
        await post(Uri.parse(URLS.nextquestion), headers: headers, body: {
      'qnsid': quesid,
      'ans': ans,
      'examid': examid,
      'user_id': userid,
    });
    logApi('next_question',
        {'qnsid': quesid, 'ans': ans, 'examid': examid, 'user_id': userid},
        response);
    if (response.statusCode == 200) {
      print('suji ');
      final Map<String, dynamic> data = json.decode(response.body);
      print(data['status']);
      if (data['status'] == 'success') {
        String datas = data['message'];
        return datas;
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (e) {
    print(e.toString());

  }
  return 'failed';
}

Future<String> finalsubmit(
  String examid,
  String userid,
) async {
  try {
    final response =
        await post(Uri.parse(URLS.examcomplete), headers: headers, body: {
      'examid': examid,
      'user_id': userid,
    });
    logApi('exam_complete', {'examid': examid, 'user_id': userid}, response);
    if (response.statusCode == 200) {
      print(examid);
      print(response.statusCode);
      return 'ok';
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (e) {
    print(e.toString());

  }
  return 'failed';
}

Future<String?> videoseen(String userid, videoid) async {
  try {
    final response = await post(Uri.parse(URLS.videoseenupdate),
        headers: headers, body: {'user_id': userid, 'video_id': videoid});
    print(userid);

    if (response.statusCode == 200) {
      final bodyasjson = json.decode(response.body) as Map<String, dynamic>;
      String data = bodyasjson['message'];
      return data;
    } else {
      print('failed');
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<String?> audioseen(String userid, audioid) async {
  try {
    final response = await post(Uri.parse(URLS.audioseenupdate),
        headers: headers, body: {'user_id': userid, 'audio_id': audioid});
    print(userid);

    if (response.statusCode == 200) {
      final bodyasjson = json.decode(response.body) as Map<String, dynamic>;
      String data = bodyasjson['message'];
      return data;
    } else {
      print('failed');
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<String?> noteseen(String userid, noteid) async {
  try {
    final response = await post(Uri.parse(URLS.noteseenupdate),
        headers: headers, body: {'user_id': userid, 'video_id': noteid});
    print(userid);

    if (response.statusCode == 200) {
      final bodyasjson = json.decode(response.body) as Map<String, dynamic>;
      String data = bodyasjson['message'];
      return data;
    } else {
      print('failed');
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<List<Map<String, dynamic>>> search(
  String name,
) async {
  try {
    final response =
        await post(Uri.parse(URLS.coursesearch), headers: headers, body: {
      'name': name,
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data['data']);
        return dataList;
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (e) {
    print(e.toString());

  }
  return [];
}

Future<String?> userisblock(String userid) async {
  try {
    final response = await get(
      Uri.parse(URLS.blockornot + userid), headers: headers,
    );
    print('userid: $userid');

    if (response.statusCode == 200) {
      final bodyasjson = json.decode(response.body) as Map<String, dynamic>;
      print(bodyasjson);
      Map<String, dynamic> data = bodyasjson['data'];
      print(bodyasjson);
      String data1 = data['status'];
      print('data is $data');

      return data1;
    } else {
      print('failed');
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<List<Map<String, dynamic>>> invoicelist(String id) async {
  // Replace with your actual API endpoint

  try {
    final response = await get(
      Uri.parse(URLS.invoicelist + id),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data['status']);

      if (data['status'] == 'success') {
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data['data']);
        course_count = dataList.length.toInt();

        return dataList;
      } else {
        throw Exception('Failed to fetch data: ${data['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (error) {
    throw Exception('Failed to fetch data: $error');
  }
}

Future<String?> checkupdate(String version) async {
  try {
    final response = await get(
      Uri.parse(URLS.checkversion + version), headers: headers,
    );
    print(URLS.checkversion + version);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final bodyasjson = json.decode(response.body) as Map<String, dynamic>;
      print(bodyasjson);
      print('$bodyasjson of updste');
      String data = bodyasjson['data'];
      print(bodyasjson);
      print('data is $data');

      return data;
    } else {
      print('failed');
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
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

Future<String> resetexamdata(
  String examid,
) async {
  try {
    final response = await post(Uri.parse(URLS.clearexamdata),
        headers: headers, body: {'examid': examid, 'user_id': userId});
    logApi('exam_reset', {'examid': examid, 'user_id': userId}, response);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final s = '${data['status']}'.toLowerCase();
      if (s == 'success' || s == 'true' || s == '1') {
        return 'success';
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (e) {
    print("Error getting device ID: $e");
  }

  return 'error';
}
