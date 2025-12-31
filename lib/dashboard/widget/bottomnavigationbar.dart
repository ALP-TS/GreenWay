import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:greenway_lms/Profilepage/profile.dart';
import 'package:greenway_lms/dashboard/dashboard.dart';
import 'package:greenway_lms/dashboard/widget/carousaldash.dart';
// import 'package:mcj/data.dart/apicalls.dart';
// import 'package:mcj/data.dart/loginmodel/loginmodel.dart';
import 'package:greenway_lms/others/constants.dart';

// ignore: camel_case_types
class navigationbar extends StatefulWidget {
  const navigationbar({super.key});

  @override
  State<navigationbar> createState() => _navigationbarState();
}

// ignore: camel_case_types
class _navigationbarState extends State<navigationbar> {
  int _currentindex = 0;
  final List<Widget> _pages = [
    const dashboard(),
    const pagetwo(),
    const profile_page(),
  ];
  @override
  Widget build(BuildContext context) {
    bool user = false;
    if (rememberUser == null) {
      user = true;
    }
    return Scaffold(
      body: _pages[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentindex,
          onTap: (int index) {
            setState(() {
              _currentindex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Nottification'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: 'profile')
          ]),
    );
  }

  // print('printed');
}

class pagetwo extends StatelessWidget {
  const pagetwo({super.key});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('data'),
      // ),
      body: Column(children: [
        Expanded(
          flex: 3,
          child: Container(
            height: _height * 0.4,
            // width: _width * 0.8,
            decoration: BoxDecoration(
              // color: Colors.black,
              image: DecorationImage(
                image: AssetImage(
                    'assets/nonottification.jpg'), // Replace 'background_image.jpg' with your image path
                fit: BoxFit.contain, // Adjust the fit as needed
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Column(
              children: [
                Text(
                  'No Nottification Yet',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text('You have no Nottification right now come back latter')
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Page'),
    );
  }
}
