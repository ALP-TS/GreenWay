// // import 'package:caams_learning_app/screens/tabview.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
// //import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
// import 'package:lms/Profilepage/profile.dart';
// import 'package:lms/dashboard/dashboard.dart';
// import 'package:lms/dashboard/widget/bottomnavigationbar.dart';

// // import 'package:caams_learning_app/others/Colors.dart';
// // import 'package:caams_learning_app/screens/apichecking.dart';
// // import 'package:caams_learning_app/screens/categorypage.dart';
// // import 'package:caams_learning_app/screens/coursedetailpage.dart';
// // import 'package:caams_learning_app/screens/dashboardinsidecourse.dart';
// // import 'package:caams_learning_app/screens/mycourses.dart';
// // import 'package:caams_learning_app/screens/otploginpage.dart';
// // import 'package:caams_learning_app/screens/paymentscreen.dart';
// // import 'package:caams_learning_app/screens/profilepage.dart';
// // import 'package:caams_learning_app/screens/wishlist.dart';

// class nav2 extends StatefulWidget {
//   // final List<Map<String, dynamic>>? subject;
//   const nav2({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _nav2State createState() => _nav2State();
// }

// class _nav2State extends State<nav2> {
//   int _currentindex = 0;
//   late final List<Widget> _pages;

//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       dashboard(
//           // subject: widget.subject,
//           ),
//       // mycourses(),
//       // apicheck(),

//       pagetwo(),
//       profile_page(),
//     ];
//   }

//   final BorderRadius _borderRadius = const BorderRadius.only(
//     topLeft: Radius.circular(25),
//     topRight: Radius.circular(25),
//   );

//   ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
//     borderRadius: BorderRadius.all(Radius.circular(25)),
//   );

//   SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;
//   EdgeInsets padding = EdgeInsets.zero;
//   // RoundedRectangleBorder bottomBarShape = RoundedRectangleBorder(borderRadius: _borderRadius);

//   SnakeShape snakeShape = SnakeShape.circle;

//   bool showSelectedLabels = false;
//   bool showUnselectedLabels = false;

//   Color selectedColor = Colors.black;
//   Color unselectedColor = Colors.white;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentindex],
//       bottomNavigationBar: SnakeNavigationBar.color(
//         backgroundColor: Colors.orange,
//         currentIndex: _currentindex,
//         onTap: (int index) {
//           setState(() {
//             _currentindex = index;
//           });
//         },
//         // height: 80,
//         behaviour: snakeBarStyle,
//         snakeShape: snakeShape,
//         shape: bottomBarShape,
//         padding: padding,

//         ///configuration for SnakeNavigationBar.color
//         snakeViewColor: selectedColor,
//         selectedItemColor:
//             snakeShape == SnakeShape.indicator ? selectedColor : null,
//         unselectedItemColor: unselectedColor,

//         showUnselectedLabels: showUnselectedLabels,
//         showSelectedLabels: showSelectedLabels,

//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.dashboard_rounded), label: 'tickets'),
//           // BottomNavigationBarItem(
//           //     icon: Icon(Icons.home_repair_service), label: 'calendar'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.notifications), label: 'home'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.account_circle_sharp), label: 'microphone'),
//         ],
//         selectedLabelStyle: const TextStyle(fontSize: 14),
//         unselectedLabelStyle: const TextStyle(fontSize: 10),
//       ),
//     );
//   }
// }
