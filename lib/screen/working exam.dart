import 'package:flutter/material.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/screen/countdowntimer.dart';

class temp extends StatefulWidget {
  final List<Map<String, dynamic>> exam;
  final int l;
  final String examid;
  final int time;

  const temp(
      {super.key,
      required this.exam,
      required this.l,
      required this.examid,
      required this.time});

  @override
  State<temp> createState() => _tempState();
}

class _tempState extends State<temp> {
  int index = 0;
  String? _selectedAnswer;
  bool timerFinished = false;

  void handleTimerFinish(bool finished) {
    setState(() {
      timerFinished = finished;
    });
    // Do something with the variable `timerFinished` when the timer finishes
  }

  // int l=

  // Future<void> _handleNextButtonPressed(String examid) async {
  //   // ignore: unnecessary_null_comparison
  //   if (_selectedAnswer != null) {
  //     String option = _selectedAnswer!.substring(0, 1);
  //     String status = await nextques(
  //       userId!,
  //     );
  //     // Increase index
  //     setState(() {
  //       index++;
  //       if (index > widget.l) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => examcomplete()),
  //         );
  //       }
  //     }); // Removing the prefix
  //     print('Selected option: $option');
  //   } else {
  //     print('No option selected');
  //   }
  // }

  void _handleClearButtonPressed() {
    setState(() {
      _selectedAnswer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (timerFinished) {
      // If timerFinished is true, navigate to a new page
      return Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Timer Finished!'),
            TextButton(
                onPressed: () {
                  finalsubmit(widget.examid, userId!);
                },
                child: Text('Final Submit'))
          ]), // Replace with your desired widget
        ),
      );
    }
    if (index >= widget.exam.length) {
      // Handle the case when index exceeds the length of the list
      return Scaffold(
        body: Center(
            child: TextButton(
                onPressed: () {
                  finalsubmit(widget.examid, userId!);
                },
                child: SubmitButtonAnimation())),
      );
    }
    Map<String, dynamic> ques = widget.exam[index];
    // String? _selectedAnswer;
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    print(ques['qns']);
    print(widget.l);
    // int Time = int.parse(widget.time);
    // print(Time);
    print(widget.time);
    print('kkok');

    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(gradient: myGradient),
        ),
        Positioned(
          left: _height * 0.01,
          top: _height * 0.1,
          child: Row(children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  'Question number: ${index + 1}/${widget.l}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              width: _width * 0.5,
              height: _height * 0.05,
            ),
            CountdownTimer(
              time: widget.time,
              onTimerFinish: handleTimerFinish,
            )
          ]),
        ),
        // Positioned(
        //     left: _width * 0.6,
        //     top: _height * 0.1,
        //     child: CountdownTimer()), // Use the CountdownTimer widget here
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            height: _height * 0.9,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 5,
                        //     blurRadius: 7,
                        //     offset: Offset(0, 3), // changes position of shadow
                        //   ),
                        // ],
                      ),
                      width: double.infinity,
                      height: 100,
                      child: Center(
                        child: Text(
                          ques['qns'],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Row(children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 5,
                        //     blurRadius: 7,
                        //     offset: Offset(0, 3), // changes position of shadow
                        //   ),
                        // ],
                      ),
                      height: 50,
                      width: double.infinity,
                      child: RadioListTile(
                        // selectedTileColor: Colors.amber,
                        // activeColor: Colors.yellow,
                        title: Text('A.${ques['optiona']}'),
                        value: 'A',
                        groupValue: _selectedAnswer,
                        onChanged: (value) {
                          setState(() {
                            _selectedAnswer = value as String?;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 5,
                        //     blurRadius: 7,
                        //     offset: Offset(0, 3), // changes position of shadow
                        //   ),
                        // ],
                      ),
                      height: 50,
                      width: double.infinity,
                      child: RadioListTile(
                        title: Text('B.${ques['optionb']}'),
                        value: 'B',
                        groupValue: _selectedAnswer,
                        onChanged: (value) {
                          setState(() {
                            _selectedAnswer = value as String?;
                          });
                        },
                      ),
                    ),
                    // ]),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 5,
                        //     blurRadius: 7,
                        //     offset: Offset(0, 3), // changes position of shadow
                        //   ),
                        // ],
                      ),
                      height: 50,
                      width: double.infinity,
                      child: RadioListTile(
                        title: Text('C.${ques['optionc']}'),
                        value: 'C',
                        groupValue: _selectedAnswer,
                        onChanged: (value) {
                          setState(() {
                            _selectedAnswer = value as String?;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 5,
                        //     blurRadius: 7,
                        //     offset: Offset(0, 3), // changes position of shadow
                        //   ),
                        // ],
                      ),
                      height: 50,
                      width: double.infinity,
                      child: RadioListTile(
                        title: Text('D.${ques['optiond']}'),
                        value: 'D',
                        groupValue: _selectedAnswer,
                        onChanged: (value) {
                          setState(() {
                            _selectedAnswer = value as String?;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 5,
                        //     blurRadius: 7,
                        //     offset: Offset(0, 3), // changes position of shadow
                        //   ),
                        // ],
                      ),
                      height: 50,
                      width: double.infinity,
                      child: RadioListTile(
                        title: Text('E.${ques['optione']}'),
                        value: 'E',
                        groupValue: _selectedAnswer,
                        onChanged: (value) {
                          setState(() {
                            _selectedAnswer = value as String?;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Container(
              // width: 100,
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // SizedBox(width: 10),
                  Container(
                    width: _width * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 5,
                        //     blurRadius: 7,
                        //     offset: Offset(0, 3), // changes position of shadow
                        //   ),
                        // ],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: _handleClearButtonPressed,
                      child: Text('Clear'),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    width: _width * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 5,
                        //     blurRadius: 7,
                        //     offset: Offset(0, 3), // changes position of shadow
                        //   ),
                        // ],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () async {
                        String status = await nextques(
                          ques['id'],
                          // 'option$option',
                          '0',
                          widget.examid,
                          userId!,
                        );
                        setState(() {
                          index++;
                          // if (index > widget.l) {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => examcomplete()),
                          //   );
                          // }
                        });
                      },
                      child: Text('Skip'),
                    ),
                  ),
                  Container(
                    width: _width * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 5,
                        //     blurRadius: 7,
                        //     offset: Offset(0, 3), // changes position of shadow
                        //   ),
                        // ],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () async {
                        if (_selectedAnswer != null) {
                          String option = _selectedAnswer!.substring(0, 1);
                          print('${ques['id']}1');
                          print('option${option}1');
                          print(userId);
                          print(widget.examid);
                          String status = await nextques(
                            ques['id'],
                            '$option',
                            widget.examid,
                            userId!,
                          );
                          print(status);
                          // Increase index
                          setState(() {
                            index++;
                            // if (index > widget.l) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => examcomplete()),
                            //   );
                            // }
                          }); // Removing the prefix
                          print('Selected option: $option');
                        } else {
                          print('No option selected');
                        }
                      },
                      child: Text('Next'),
                    ),
                  ),
                ],
              ),
            ))
      ]),
    );
  }
}

// import 'package:flutter/material.dart';

class SubmitButtonAnimation extends StatefulWidget {
  @override
  _SubmitButtonAnimationState createState() => _SubmitButtonAnimationState();
}

class _SubmitButtonAnimationState extends State<SubmitButtonAnimation> {
  double _width = 150;
  double _height = 50;
  Color _color = Colors.white;

  void _animateButton() {
    setState(() {
      _width = 200; // New width value
      _height = 60; // New height value
      _color = Colors.green; // New color value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500), // Animation duration
        width: _width, // Animated width
        height: _height, // Animated height
        decoration: BoxDecoration(
          color: _color, // Animated color
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: _animateButton, // Call the function to animate the button
          child: Text(
            'Final Submit',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
