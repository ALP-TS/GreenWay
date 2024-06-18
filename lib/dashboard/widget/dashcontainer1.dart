import 'package:flutter/material.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/loginpage/loginpage.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/screen/check.dart';
import 'package:greenway_lms/screen/course_listing_page.dart';
import 'package:greenway_lms/screen/exampage.dart';
// import 'package:greenway_lms/screen/invoicelistingpage%20copy.dart';
import 'package:greenway_lms/screen/invoicelistingpage.dart';
import 'package:greenway_lms/screen/newcorsedetailpage.dart';
import 'package:greenway_lms/screen/subjectlisting.dart';

class dash_container1 extends StatefulWidget {
  const dash_container1({super.key});

  @override
  State<dash_container1> createState() => _dash_container1State();
}

class _dash_container1State extends State<dash_container1> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // SizedBox(height: 10),
            Container(
              height: _height * 0.12,
              width: _width,
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('hello $stuname',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'inter')),
                      Text(
                        'Welcome to school',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: 'inter'),
                      ),
                    ]),
              ),
            )
          ],
        ),
        // SizedBox(
        //   height: 20,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () async {
                final categorydata = await coursecategory();
                print(categorydata);
                List<String> pic = await getsliderimage();
                setState(() {
                  img = pic;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => newcourse(
                            categorydata: categorydata,
                          )),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white),
                height: _height * 0.1,
                width: _width * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: _width * 0.12,
                      height: _height * 0.06,
                      child: Image.asset('assets/explore icon (1).webp',
                          fit: BoxFit.cover),
                    ),
                    Text('Explore')
                  ],
                ),

                // color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (feestatus == 'active') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => subjectlisting()),
                  );
                } else {
                  final snackBar = SnackBar(
                    content: Text('Your subscreption is expired'),
                    duration:
                        Duration(seconds: 3), // Optional: Set the duration
                    action: SnackBarAction(
                      label: 'Close',
                      onPressed: () {
                        // Perform an action when the SnackBar's action button is pressed
                        print('SnackBar action button pressed');
                      },
                    ),
                  );

                  // Find the Scaffold in the widget tree and show the SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white),
                height: _height * 0.1,
                width: _width * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: _width * 0.12,
                      height: _height * 0.06,
                      child: Image.asset(
                        'assets/go_to_study_logo__1_-removebg-preview (1).png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'Go to study',
                      maxLines: 1,
                    )
                  ],
                ),

                // color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => exampage()),
                );
                // final snackBar = SnackBar(
                //   content: Text(
                //       'This feature is not available rihght now. dont worry It will updated soon'),
                //   duration: Duration(seconds: 3), // Optional: Set the duration
                //   action: SnackBarAction(
                //     label: 'Close',
                //     onPressed: () {
                //       // Perform an action when the SnackBar's action button is pressed
                //       print('SnackBar action button pressed');
                //     },
                //   ),
                // );

                // // Find the Scaffold in the widget tree and show the SnackBar
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);

                // print('tapped');
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white),
                height: _height * 0.1,
                width: _width * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // color: Colors.amber,
                      width: _width * 0.12,
                      height: _height * 0.06,
                      child: Image.asset(
                        'assets/examicon-removebg-preview.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text('Exam')
                  ],
                ),

                // color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Invoicelist()),
                );

                // final snackBar = SnackBar(
                //   content: Text(
                //       'This feature is not available rihght now. dont worry It will updated soon'),
                //   duration: Duration(seconds: 3), // Optional: Set the duration
                //   action: SnackBarAction(
                //     label: 'Close',
                //     onPressed: () {
                //       // Perform an action when the SnackBar's action button is pressed
                //       print('SnackBar action button pressed');
                //     },
                //   ),
                // );

                // // Find the Scaffold in the widget tree and show the SnackBar
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // print('tapped');
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white),
                height: _height * 0.1,
                width: _width * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Container(
                      // color: Colors.amber,
                      width: _width * 0.12,
                      height: _height * 0.06,
                      child: Image.asset('assets/invoices logo.png'),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Text(
                      'Invoices',
                    )
                  ],
                ),

                // color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}
