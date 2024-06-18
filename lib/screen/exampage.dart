import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greenway_lms/Profilepage/temp.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/screen/examresult.dart';
import 'package:greenway_lms/screen/startexam.dart';

class exampage extends StatefulWidget {
  const exampage({super.key});

  @override
  State<exampage> createState() => _exampageState();
}

class _exampageState extends State<exampage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Online Exam'),
      ),
      body: SafeArea(
          child: FutureBuilder<List<Map<String, dynamic>>>(
        future: getexam(userId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> datatopic = snapshot.data!;
            return ListView.builder(
                shrinkWrap: true,
                physics: PageScrollPhysics(),
                itemCount: datatopic.length,
                itemBuilder: ((context, index) {
                  Map<String, dynamic> datumtopic = datatopic[index];
                  bool startnow = false;
                  bool isvariable = true;
                  if (datumtopic['button'] == 'Start Now') {
                    startnow = true;
                  }
                  if (datumtopic['button'] == 'Missed') {
                    isvariable = false;
                  }
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      height: 125,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Image.asset(
                                'assets/examlist.jpg',
                                fit: BoxFit.cover,
                              ),
                              decoration: const BoxDecoration(
                                // color: Colors.black,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${datumtopic['name']}'),
                                    Text('${datumtopic['topics']}'),
                                    Text('${datumtopic['date']}'),
                                    Row(
                                      children: [
                                        startnow
                                            ? TextButton.icon(
                                                onPressed: () async {
                                                  // List<Map<String, dynamic>>
                                                  //     questions =
                                                  //     await startexam(
                                                  //   userId!,
                                                  //   datumtopic['exam_id'],
                                                  // );
                                                  List<dynamic> data =
                                                      await startexam(
                                                    userId!,
                                                    datumtopic['exam_id'],
                                                  );
                                                  List<Map<String, dynamic>>
                                                      questions = data[0];
                                                  print(questions);
                                                  print('questions');
                                                  Map<String, dynamic> exam =
                                                      data[1];
                                                  // int time = int.parse(
                                                  //     exam['totaltime']);
                                                  int time = secondconvert(
                                                      '${exam['totaltime']}');

                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          temp(
                                                        exam: questions,
                                                        l: questions.length,
                                                        examid: datumtopic[
                                                            'exam_id'],
                                                        time: time,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.table_view,
                                                  color: Colors.yellow,
                                                ),
                                                label: Text(
                                                  '${datumtopic['button']}',
                                                  style: TextStyle(
                                                      color: Colors.yellow),
                                                ))
                                            : isvariable
                                                ? Row(
                                                    children: [
                                                      TextButton.icon(
                                                          onPressed: () {
                                                            print(
                                                                'exam id  =${datumtopic['exam_id']}');
                                                            print(userId);
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        viewresult(
                                                                  examid: datumtopic[
                                                                      'exam_id'],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          icon: const Icon(
                                                            Icons.table_view,
                                                            color: Colors.green,
                                                          ),
                                                          label: Text(
                                                            '${datumtopic['button']}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                          )),
                                                      TextButton.icon(
                                                          onPressed: () async {
                                                            String Status =
                                                                await resetexamdata(
                                                              datumtopic[
                                                                  'exam_id'],
                                                            );
                                                            if (Status ==
                                                                'success') {
                                                              final snackBar =
                                                                  SnackBar(
                                                                content: Center(
                                                                  child: Text(
                                                                      'Exam Data Reset Succesfully'),
                                                                ),
                                                                duration: Duration(
                                                                    seconds:
                                                                        3), // Optional: Set the duration
                                                                action:
                                                                    SnackBarAction(
                                                                  label:
                                                                      'Close',
                                                                  onPressed:
                                                                      () {
                                                                    // Perform an action when the SnackBar's action button is pressed
                                                                    print(
                                                                        'SnackBar action button pressed');
                                                                  },
                                                                ),
                                                              );

                                                              // Find the Scaffold in the widget tree and show the SnackBar
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      snackBar);
                                                              setState(() {});
                                                            } else {
                                                              final snackBar =
                                                                  SnackBar(
                                                                content: Text(
                                                                    "You Can't reset Exam Data Now"),
                                                                duration: Duration(
                                                                    seconds:
                                                                        3), // Optional: Set the duration
                                                                action:
                                                                    SnackBarAction(
                                                                  label:
                                                                      'Close',
                                                                  onPressed:
                                                                      () {
                                                                    // Perform an action when the SnackBar's action button is pressed
                                                                    print(
                                                                        'SnackBar action button pressed');
                                                                  },
                                                                ),
                                                              );

                                                              // Find the Scaffold in the widget tree and show the SnackBar
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      snackBar);
                                                            }
                                                          },
                                                          icon: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          ),
                                                          label: Text(
                                                            'Clear Data',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ))
                                                    ],
                                                  )
                                                : TextButton.icon(
                                                    onPressed: () {
                                                      final snackBar = SnackBar(
                                                        content: const Text(
                                                            'You didnt Attend the Exam'),
                                                        duration: const Duration(
                                                            seconds:
                                                                3), // Optional: Set the duration
                                                        action: SnackBarAction(
                                                          label: 'Close',
                                                          onPressed: () {
                                                            // Perform an action when the SnackBar's action button is pressed
                                                            print(
                                                                'SnackBar action button pressed');
                                                          },
                                                        ),
                                                      );

                                                      // Find the Scaffold in the widget tree and show the SnackBar
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    },
                                                    icon: const Icon(
                                                      Icons.call_missed,
                                                      color: Colors.red,
                                                    ),
                                                    label: Text(
                                                      '${datumtopic['button']}',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }));
          } else {
            return Text('No data available');
          }
        },
      )
          // Padding(
          //   padding: EdgeInsets.all(10),
          //   child: Container(
          //     decoration: BoxDecoration(
          //         color: Colors.amber, borderRadius: BorderRadius.circular(10)),
          //     width: double.infinity,
          //     height: 100,
          //     child: Row(
          //       children: [
          //         Expanded(
          //           flex: 1,
          //           child: Container(
          //             decoration: const BoxDecoration(
          //               color: Colors.black,
          //               borderRadius: BorderRadius.only(
          //                 bottomLeft: Radius.circular(10),
          //                 topLeft: Radius.circular(10),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Expanded(
          //           flex: 4,
          //           child: Container(
          //             decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.only(
          //                     topRight: Radius.circular(10),
          //                     bottomRight: Radius.circular(10))),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          ),
    );
  }
}

int secondconvert(String time) {
  String totalTimeString = time;
  // "01:30"; // Your input string representing the time duration
  List<String> parts =
      totalTimeString.split(':'); // Split the string into hours and minutes

  int hours = int.parse(parts[0]); // Parse hours
  int minutes = int.parse(parts[1]); // Parse minutes

  int totalSeconds = hours * 60 + minutes; // Calculate total seconds
  return totalSeconds;
  print('Total Seconds: $totalSeconds');
}
