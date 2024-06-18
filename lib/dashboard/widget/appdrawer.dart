import 'package:flutter/material.dart';
import 'package:greenway_lms/loginpage/loginpage.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue, // Set the background color of the app drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'RN Plus Academy',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Dashboard', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // You can add additional logic here if needed
              },
            ),
            // ListTile(
            //   title: Text('Screen 1', style: TextStyle(color: Colors.white)),
            //   onTap: () {
            //     Navigator.pop(context); // Close the drawer
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Screen1()),
            //     );
            //   },
            // ),
            ListTile(
              title: Text('logout', style: TextStyle(color: Colors.white)),
              onTap: () async {
                Navigator.pop(context);
                var sharedPref = await SharedPreferences.getInstance();
                sharedPref.setBool(KEYLOGIN, false);

                // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            // Add more drawer items as needed
          ],
        ),
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),
      ),
      body: Center(
        child: Text('Content of Screen 1'),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
      ),
      body: Center(
        child: Text('Content of Screen 2'),
      ),
    );
  }
}
