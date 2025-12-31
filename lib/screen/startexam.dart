// import 'package:flutter/material.dart';

// import 'package:lms/others/constants.dart';
// import 'package:lms/screen/countdowntimer.dart';

// import '../data.dart/apicalls.dart';

// class StartExam extends StatefulWidget {
//   const StartExam({Key? key, required this.examid}) : super(key: key);
//   final examid;

//   @override
//   State<StartExam> createState() => _StartExamState();
// }

// class _StartExamState extends State<StartExam> {
//   String? _selectedAnswer;
//   int index = 0;

//   void _handleNextButtonPressed() {
//     if (_selectedAnswer != null) {
//       String option = _selectedAnswer!.substring(0, 1);
//       // Increase index
//       setState(() {
//         index++;
//       }); // Removing the prefix
//       print('Selected option: $option');
//     } else {
//       print('No option selected');
//     }
//   }

//   void _handleClearButtonPressed() {
//     setState(() {
//       _selectedAnswer = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _width = MediaQuery.of(context).size.width;
//     final _height = MediaQuery.of(context).size.height -
//         MediaQuery.of(context).padding.top -
//         kToolbarHeight;
//     return Scaffold(
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//           future: startexam(userId!, widget.examid),
//           // viewresult(userId!,userId),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else if (snapshot.hasData) {
//               List<Map<String, dynamic>>? datatopic = snapshot.data;
//               // Map<String, dynamic>? datatopic = datatopics?[index];
//               Map<String, dynamic> datatopics = datatopic![index];
//               print(index);
//               print(datatopic![index]);
//               print(datatopic);

//               return Stack(children: [
//                 Container(
//                   width: double.infinity,
//                   height: double.infinity,
//                   decoration: BoxDecoration(gradient: myGradient),
//                 ),
//                 Positioned(
//                   left: _height * 0.025,
//                   top: _height * 0.1,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15)),
//                     child: Center(
//                       child: Text(
//                         'Question number: ${index + 1}/${datatopics.length}',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     ),
//                     width: _width * 0.5,
//                     height: _height * 0.05,
//                   ),
//                 ),
//                 Positioned(
//                     left: _width * 0.50,
//                     top: _height * 0.1,
//                     child: CountdownTimer(
//                       time: '30',
//                     )), // Use the CountdownTimer widget here
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(30),
//                             topRight: Radius.circular(30))),
//                     height: _height * 0.9,
//                     child: Padding(
//                       padding: EdgeInsets.all(10),
//                       child: Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     spreadRadius: 5,
//                                     blurRadius: 7,
//                                     offset: Offset(
//                                         0, 3), // changes position of shadow
//                                   ),
//                                 ],
//                               ),
//                               width: double.infinity,
//                               height: 100,
//                               child: Center(
//                                 child: Text(
//                                   datatopics['qns'],
//                                   style: TextStyle(
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             // Row(children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     spreadRadius: 5,
//                                     blurRadius: 7,
//                                     offset: Offset(
//                                         0, 3), // changes position of shadow
//                                   ),
//                                 ],
//                               ),
//                               height: 50,
//                               width: double.infinity,
//                               child: RadioListTile(
//                                 // selectedTileColor: Colors.amber,
//                                 // activeColor: Colors.yellow,
//                                 title: Text(datatopics?['optiona']),
//                                 value: 'a',
//                                 groupValue: _selectedAnswer,
//                                 onChanged: (value) {
//                                   // setState(() {
//                                   //   _selectedAnswer = value as String?;
//                                   // });
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     spreadRadius: 5,
//                                     blurRadius: 7,
//                                     offset: Offset(
//                                         0, 3), // changes position of shadow
//                                   ),
//                                 ],
//                               ),
//                               height: 50,
//                               width: double.infinity,
//                               child: RadioListTile(
//                                 title: Text(datatopics?['optionb']),
//                                 value: 'b',
//                                 groupValue: _selectedAnswer,
//                                 onChanged: (value) {
//                                   // setState(() {
//                                   //   _selectedAnswer = value as String?;
//                                   // });
//                                 },
//                               ),
//                             ),
//                             // ]),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     spreadRadius: 5,
//                                     blurRadius: 7,
//                                     offset: Offset(
//                                         0, 3), // changes position of shadow
//                                   ),
//                                 ],
//                               ),
//                               height: 50,
//                               width: double.infinity,
//                               child: RadioListTile(
//                                 title: Text(datatopics?['optionc']),
//                                 value: 'c',
//                                 groupValue: _selectedAnswer,
//                                 onChanged: (value) {
//                                   // setState(() {
//                                   //   _selectedAnswer = value as String?;
//                                   // });
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     spreadRadius: 5,
//                                     blurRadius: 7,
//                                     offset: Offset(
//                                         0, 3), // changes position of shadow
//                                   ),
//                                 ],
//                               ),
//                               height: 50,
//                               width: double.infinity,
//                               child: RadioListTile(
//                                 title: Text(datatopics?['optiond']),
//                                 value: 'd',
//                                 groupValue: _selectedAnswer,
//                                 onChanged: (value) {
//                                   // setState(() {
//                                   //   _selectedAnswer = value as String?;
//                                   // });
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     spreadRadius: 5,
//                                     blurRadius: 7,
//                                     offset: Offset(
//                                         0, 3), // changes position of shadow
//                                   ),
//                                 ],
//                               ),
//                               height: 50,
//                               width: double.infinity,
//                               child: RadioListTile(
//                                 title: Text(datatopics?['optione']),
//                                 value: 'e',
//                                 groupValue: _selectedAnswer,
//                                 onChanged: (value) {
//                                   // setState(() {
//                                   //   _selectedAnswer = value as String?;
//                                   // });
//                                 },
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.withOpacity(0.5),
//                                           spreadRadius: 5,
//                                           blurRadius: 7,
//                                           offset: Offset(0,
//                                               3), // changes position of shadow
//                                         ),
//                                       ],
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: TextButton(
//                                     onPressed: _handleNextButtonPressed,
//                                     child: Text('Next'),
//                                   ),
//                                 ),
//                                 SizedBox(width: 20),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.withOpacity(0.5),
//                                           spreadRadius: 5,
//                                           blurRadius: 7,
//                                           offset: Offset(0,
//                                               3), // changes position of shadow
//                                         ),
//                                       ],
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: TextButton(
//                                     onPressed: _handleClearButtonPressed,
//                                     child: Text('Clear'),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ]);
//             } else {
//               return Text('No data available');
//             }
//           }),
//     );
//   }
// }
