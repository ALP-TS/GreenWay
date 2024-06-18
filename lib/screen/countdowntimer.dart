// import 'dart:async';
// import 'package:flutter/material.dart';

// class CountdownTimer extends StatefulWidget {
//   // final String time;

//   const CountdownTimer({
//     super.key,
//   });
//   @override
//   _CountdownTimerState createState() => _CountdownTimerState();
// }

// class _CountdownTimerState extends State<CountdownTimer> {
//   // int intValue = int.parse(widget.time);
//   late Timer _timer;
//   int _countdown = 60; // Initial countdown value in seconds

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   @override
//   void dispose() {
//     _timer.cancel(); // Cancel the timer to avoid memory leaks
//     super.dispose();
//   }

//   void startTimer() {
//     const oneSec = Duration(seconds: 1); // Changed back to one second
//     _timer = Timer.periodic(
//       oneSec,
//       (Timer timer) {
//         if (_countdown == 0) {
//           timer.cancel();
//           // Optionally, you can handle when the countdown reaches 0
//           // For example, you can show a message or trigger an action
//           // when the countdown ends.
//         } else {
//           setState(() {
//             _countdown--;
//           });
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // int intValue = int.parse(widget.time);
//     // _countdown = _countdown * 30;

//     return Container(
//       decoration: BoxDecoration(
//           // color: Colors.white,
//           ),
//       width: 150,
//       height: 50,
//       child: TextButton.icon(
//         onPressed: () {},
//         icon: Icon(
//           Icons.timer_outlined,
//           color: Colors.white,
//         ),
//         label: Text(
//           ' ${_countdown ~/ 60} : ${_countdown % 60}  ', // Updated to display minutes and seconds
//           style: TextStyle(fontSize: 20, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final int time;
  final Function(bool) onTimerFinish; // Callback function

  const CountdownTimer({
    Key? key,
    required this.time,
    required this.onTimerFinish,
  }) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late int _countdown; // Initial countdown value in seconds

  @override
  void initState() {
    super.initState();
    _countdown = widget.time * 60; // Convert minutes to seconds
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countdown == 0) {
          timer.cancel();
          // Invoke callback with true when timer finishes
          widget.onTimerFinish(true);
        } else {
          setState(() {
            _countdown--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      width: 150,
      height: 50,
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(
          Icons.timer_outlined,
          color: Colors.white,
        ),
        label: Text(
          ' ${_countdown ~/ 60} : ${_countdown % 60}  ', // Displaying minutes and seconds
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}

// class MainWidget extends StatefulWidget {
//   @override
//   _MainWidgetState createState() => _MainWidgetState();
// }

// class _MainWidgetState extends State<MainWidget> {
//   bool timerFinished = false;

//   void handleTimerFinish(bool finished) {
//     setState(() {
//       timerFinished = finished;
//     });
//     // Do something with the variable `timerFinished` when the timer finishes
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CountdownTimer(
//           time: 10, // Example time
//           onTimerFinish: handleTimerFinish,
//         ),
//       ),
//     );
//   }
// }
