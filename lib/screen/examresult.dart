import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:greenway_lms/dashboard/dashboard.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/others/constants.dart';

// class viewresult extends StatelessWidget {
//   const viewresult({super.key, required this.examid});
//   final examid;

//   @override
//   Widget build(BuildContext context) {
//     final _width = MediaQuery.of(context).size.width;
//     final _height = MediaQuery.of(context).size.height -
//         MediaQuery.of(context).padding.top -
//         kToolbarHeight;
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Result'),
//         ),
//         body: FutureBuilder<List<dynamic>>(
//           future: examresult(userId!, examid),
//           // viewresult(userId!,userId),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else if (snapshot.hasData) {
//               List<Map<String, dynamic>> datatopic = snapshot.data?[0]!;
//               print('object');
//               Map<String, dynamic> result = snapshot.data?[1]!;
//               print(result);
//               print('object1');
//               print(result['correct_ans']);
//               String fraction = result['correct_ans'];
//               print('object2');
//               List<String> parts = fraction.split('/');
//               // String numerator = parts[0];
//               // String denominator = parts[1];
//               print('object3');
//               print(parts[0]);

//               int mark = int.parse(parts[0]);
//               print('object4');
//               double marks = mark.toDouble();
//               print('objectobjectobject');
//               return SingleChildScrollView(
//                 child: Column(
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.all(20),
//                       child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 5,
//                                 blurRadius: 7,
//                                 offset:
//                                     Offset(0, 3), // changes position of shadow
//                               ),
//                             ],
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           height: _width * 0.6,
//                           width: double.infinity, // Example fixed height
//                           // color: Colors.orange,
//                           child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   // color: Colors.amber,
//                                   width: _width * 0.4,
//                                   child: markindicater(
//                                     label: 'Total Markscored',
//                                     total: int.parse(parts[1]).toDouble(),
//                                     completed: mark.toDouble(),
//                                   ),
//                                 ),
//                                 Container(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text('Total Questions:${parts[1]}'),
//                                       Text('Total Correct Answer:${parts[0]}'),
//                                       Text(
//                                           'Total Wrong Ans:${int.parse(parts[1]) - int.parse(parts[0])}'),
//                                       Text(
//                                           'Total Mark Scored:${result['total_mark']}')
//                                     ],
//                                   ),
//                                 ) 
//                               ],),
//                               ),
//                     ),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: PageScrollPhysics(),
//                       itemCount: datatopic.length,
//                       itemBuilder: ((context, index) {
//                         Map<String, dynamic> datumtopic = datatopic[index];
//                         Color color = Colors.red;
//                         if (datumtopic['currect_anwser'] ==
//                             datumtopic['your_ans']) {
//                           color = Colors.green;
//                         }
//                         bool isvariable = true;
//                         if (datumtopic['explanation'] == '') {
//                           isvariable = false;
//                         }
//                         return Padding(
//                           padding: EdgeInsets.all(10),
//                           child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10)),
//                               width: double.infinity,
//                               // height: 80,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('${index + 1}.${datumtopic['qns']}'),
//                                   Text(
//                                     'correct answer:${datumtopic['currect_anwser']}',
//                                     style: TextStyle(color: Colors.green),
//                                   ),
//                                   Text(
//                                     'Your answer:${datumtopic['your_ans']}',
//                                     style: TextStyle(color: color),
//                                   ),
//                                   isvariable
//                                       ? Text(
//                                           'Explanation:${datumtopic['explanation']}',
//                                         )
//                                       : Text('')
//                                 ],
//                               )),
//                         );
//                       }),
//                     ),

//                     // Add more items as needed
//                   ],
//                 ),
//               );
//             } else {
//               return Text('No data available');
//             }
//           },
//         ));
//   }
// }

// class markindicater extends StatelessWidget {
//   markindicater(
//       {super.key,
//       required this.label,
//       required this.total,
//       required this.completed});
//   final GlobalKey<AnimatedCircularChartState> _chartKey =
//       new GlobalKey<AnimatedCircularChartState>();
//   final label;
//   Color color = Colors.green;
//   String text = 'Your performance is so good You scored ';
//   double total;
//   double completed;

//   @override
//   Widget build(BuildContext context) {
//     final _width = MediaQuery.of(context).size.width;
//     final _height = MediaQuery.of(context).size.height -
//         MediaQuery.of(context).padding.top -
//         kToolbarHeight;
//     // print(total);
//     // print(total);
//     double balance = total - completed;
//     // print('$total total');
//     // print('$completed com');
//     double percent = ((completed / total) * 100);
//     String percentage = percent.toStringAsFixed(2);
//     // print('helooooo');
//     // print(balance);
//     if (percent < 1) {
//       color = Colors.red;
//       text = 'Your performance is so poor You scored ';
//     }
//     return Column(children: [
//       Text(
//         label,
//         style: TextStyle(fontSize: 20),
//       ),
//       AnimatedCircularChart(
//         duration: Duration(seconds: 1),
//         key: _chartKey,
//         size: Size(_width * 0.4, _width * 0.4),
//         initialChartData: <CircularStackEntry>[
//           CircularStackEntry(
//             <CircularSegmentEntry>[
//               CircularSegmentEntry(
//                 completed,
//                 color,
//                 rankKey: 'completed',
//               ),
//               CircularSegmentEntry(
//                 balance,
//                 Colors.blueGrey[600],
//                 rankKey: 'remaining',
//               ),
//             ],
//             rankKey: 'progress',
//           ),
//         ],
//         chartType: CircularChartType.Radial,
//         edgeStyle: SegmentEdgeStyle.round, holeLabel: '$percentage%',
//         percentageValues: false,
//         // startAngle: 0,
//       ),
//       // Padding(
//       //   padding: EdgeInsets.all(10),
//       //   child: Text(
//       //     '$text $percentage%',
//       //     style: TextStyle(color: color),
//       //   ),
//       // )
//     ]);
//   }
// }
import 'package:circular_chart_flutter/circular_chart_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:jomons_accademy/dashboard/dashboard.dart';
// import 'package:jomons_accademy/data.dart/apicalls.dart';
// import 'package:jomons_accademy/others/constants.dart';

class viewresult extends StatelessWidget {
  const viewresult({super.key, required this.examid});
  final examid;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
        appBar: AppBar(
          title: Text('Result'),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: examresult(userId!, examid),
          // viewresult(userId!,userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<Map<String, dynamic>> datatopic = snapshot.data?[0]!;
              Map<String, dynamic> result = snapshot.data?[1]!;
              int mark = result['total_mark'];
              double marks = mark.toDouble();
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: _width * 0.6,
                          width: double.infinity, // Example fixed height
                          // color: Colors.orange,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  // color: Colors.amber,
                                  width: _width * 0.4,
                                  child: markindicater(
                                    label: 'Total Markscored',
                                    total: datatopic.length.toDouble(),
                                    completed: mark.toDouble(),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          'Correct Ans:${result['total_ans']}'),
                                      Text(
                                          'Wrong Ans:${result['total_worng']}'),
                                      Text(
                                          'Mark Scored:${result['total_mark']}')
                                    ],
                                  ),
                                )
                              ])),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: PageScrollPhysics(),
                      itemCount: datatopic.length,
                      itemBuilder: ((context, index) {
                        Map<String, dynamic> datumtopic = datatopic[index];
                        Color color = Colors.red;
                        if (datumtopic['currect_anwser'] ==
                            datumtopic['your_ans']) {
                          color = Colors.green;
                        }
                        bool isvariable = true;
                        if (datumtopic['explanation'] == '') {
                          isvariable = false;
                        }
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.infinity,
                              // height: 80,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${index + 1}.${datumtopic['qns']}'),
                                  Text(
                                    'correct answer:${datumtopic['currect_anwser']}',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  Text(
                                    'Your answer:${datumtopic['your_ans']}',
                                    style: TextStyle(color: color),
                                  ),
                                  isvariable
                                      ? Text(
                                          'Explanation:${datumtopic['explanation']}',
                                        )
                                      : Text('')
                                ],
                              )),
                        );
                      }),
                    ),

                    // Add more items as needed
                  ],
                ),
              );
            } else {
              return Text('No data available');
            }
          },
        ));
  }
}

class markindicater extends StatelessWidget {
  markindicater(
      {super.key,
      required this.label,
      required this.total,
      required this.completed});
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  final label;
  Color color = Colors.green;
  String text = 'Your performance is so good You scored ';
  double total;
  double completed;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    // print(total);
    // print(total);
    double balance = total - completed;
    // print('$total total');
    // print('$completed com');
    double percent = ((completed / total) * 100);
    String percentage = percent.toStringAsFixed(2);
    // print('helooooo');
    // print(balance);
    if (percent < 1) {
      color = Colors.red;
      text = 'Your performance is so poor You scored ';
    }
    return Column(children: [
      Text(
        label,
        style: TextStyle(fontSize: 20),
      ),
      AnimatedCircularChart(
        duration: Duration(seconds: 1),
        key: _chartKey,
        size: Size(_width * 0.4, _width * 0.4),
        initialChartData: <CircularStackEntry>[
          CircularStackEntry(
            <CircularSegmentEntry>[
              CircularSegmentEntry(
                completed,
                color,
                rankKey: 'completed',
              ),
              CircularSegmentEntry(
                balance,
                Colors.blueGrey[600],
                rankKey: 'remaining',
              ),
            ],
            rankKey: 'progress',
          ),
        ],
        chartType: CircularChartType.Radial,
        edgeStyle: SegmentEdgeStyle.round, holeLabel: '$percentage%',
        percentageValues: false,
        // startAngle: 0,
      ),
      Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          '$text $percentage%',
          style: TextStyle(color: color),
        ),
      )
    ]);
  }
}
