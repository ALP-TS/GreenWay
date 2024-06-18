import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
// import 'package:lms/Profilepage/profile.dart';
// import 'package:lms/carousal/caroualpage.dart';
import 'package:greenway_lms/dashboard/widget/appdrawer.dart';
// import 'package:greenway_lms/dashboard/widget/bottomnavigationbar.dart';
// import 'package:greenway_lms/carousal/caroualpage.dart';
// import 'package:greenway_lms/dashboard/widget/appdrawer.dart';
import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:greenway_lms/dashboard/widget/carousaldash.dart';
import 'package:greenway_lms/dashboard/widget/dashcontainer1.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/data.dart/feestatusmodel/feestatusmodel.dart';
// import 'package:greenway_lms/data.dart/loginmodel/loginmodel.dart';
import 'package:greenway_lms/data.dart/studentdetailsmodel/studentdetailsmodel.dart';
// import 'package:greenway_lms/loginpage/loginpage.dart';
// import 'package:greenway_lms/nointernet/check_conection.dart';
import 'package:greenway_lms/others/constants.dart';
// import 'package:MCJ/screen/course_listing_page.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    bool iscondition = false;
    // bool logout = false;

    if (rememberUser == true) {
      iscondition = true;
    }
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: FutureBuilder<Feestatusmodel?>(
                    future: fee_status(userId!),
                    builder: (context, snapshot2) {
                      if (snapshot2.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot2.hasError) {
                        return Text('Error: ${snapshot2.error}');
                      } else {
                        Feestatusmodel? result2 = snapshot2.data;
                        feestatus = result2!.data?.status;
                        return feestatus_indicater();
                      }
                    })),
          ),
          decoration: BoxDecoration(
            gradient: myGradient,
          ),
        ),
      ),
      drawer: MyDrawer(),
      // bottomNavigationBar: navigationbar(),
      body: iscondition
          ? FutureBuilder<Studentdetailsmodel?>(
              future: loginalready(studentId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.data}');
                } else if (snapshot.hasData) {
                  Studentdetailsmodel? result = snapshot.data;

                  password_status = result?.status;
                  loginmessage = result?.message;
                  studentId = result?.data?.studentId;
                  userId = result?.data?.userId;
                  classId = result?.data?.classId;
                  stuname = result?.data?.name;
                  phone = result?.data?.phone;
                  expireDate = result?.data?.expireDate;
                  seenVideo = result?.data?.seenVideo;
                  ip = result?.data?.ip;
                  deviceId = result?.data?.deviceId;
                  status = result?.data?.status;
                  // utype = result?.data?.utype;

                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: Colors.amber,
                      image: DecorationImage(
                          image: AssetImage('assets/backgroundlms.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          container1(),
                          SizedBox(
                            height: _height * 0.02,
                          ),
                          carousaldash(),
                          bottem_container()
                        ]),
                  );
                } else {
                  // print(snapshot);
                  return Center(
                    child: Image.asset(
                        'assets/no_data_found-removebg-preview (1) (1).png'),
                  );
                }
              },
            )
          : Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/backgroundlms.jpg'),
                      fit: BoxFit.cover)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    container1(),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    carousaldash(),
                    bottem_container(),
                  ]),
            ),
    );
  }

  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}

class container1 extends StatelessWidget {
  const container1({super.key});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Stack(
      children: [
        // flex: 3,
        Container(
            child: dash_container1(),
            height: _height * 0.25,
            decoration: BoxDecoration(gradient: myGradient)),
      ],
    );
  }
}

Widget bottem_container() {
  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
              height: 30,
              child: Text(
                'Information',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: coursedetails(),
        ),
      ]);
}

class coursedetails extends StatelessWidget {
  const coursedetails({super.key});

  @override
  Widget build(BuildContext context) {
    // print(studentId);
    // print(student_Id);
    // print(classId);
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: courseprogress(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Column(children: [
              SingleChildScrollView(
                  child: Container(
                      child: Column(children: [
                Text(
                  'Error: ${snapshot}',
                  style: TextStyle(fontSize: 4),
                ),
              ]))),
              // Text(Response())
              // Text('its a server error')
            ]));
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> course =
                snapshot.data as List<Map<String, dynamic>>;
            Map<String, dynamic> courseData = course[0];
            int totalvideo;
            int totalaudio;
            int totalnotes;
            if (courseData['video'] == 0) {
              totalvideo = 1;
            } else {
              totalvideo = courseData['video'];
            }
            if (courseData['audio'] == 0) {
              totalaudio = 1;
            } else {
              totalaudio = courseData['audio'];
            }
            if (courseData['notes'] == 0) {
              totalnotes = 1;
            } else {
              totalnotes = courseData['notes'];
            }

            int seennotes = courseData['seen_notes'];
            int seenvideo = courseData['seen_video'];
            int seenaudio = courseData['seen_audio'];
            final _width = MediaQuery.of(context).size.width;
            final _height = MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight;
            print(totalnotes);
            print(seennotes);
            print(course);

            return Column(children: [
              Container(
                width: double.infinity,
                height: _height * 0.25,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/courseicon.png',
                                cacheHeight: 50),
                            Expanded(
                              child: Container(
                                child: Text(
                                  courseData['class'],
                                  maxLines: 2,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(3),
                    //   child: Divider(
                    //     thickness: 2,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            processindicater(
                              label: 'Video',
                              total: totalvideo.toDouble(),
                              completed: seenvideo.toDouble(),
                              // total: 10,
                              // completed: 5,
                            ),
                            // Padding(
                            //     padding: EdgeInsets.all(3),
                            //     child: VerticalDivider(
                            //         thickness: 2, color: Colors.black)),
                            processindicater(
                              label: 'Audio',
                              total: totalaudio.toDouble(),
                              completed: seenaudio.toDouble(),
                              // total: 1,
                              // completed: 0,
                            ),
                            // Padding(
                            //     padding: EdgeInsets.all(3),
                            //     child: VerticalDivider(
                            //         thickness: 2, color: Colors.black)),
                            processindicater(
                              label: 'Notes',
                              total: totalnotes.toDouble(),
                              completed: seennotes.toDouble(),
                              // total: 10,
                              // completed: 5,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              )
            ]);
          } else {
            return const Center(
              child: Text('data'),
            );
          }
        });
  }
}

class processindicater extends StatelessWidget {
  processindicater(
      {super.key,
      required this.label,
      required this.total,
      required this.completed});
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  final label;
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
    return Column(children: [
      Text(label),
      AnimatedCircularChart(
        duration: Duration(seconds: 1),
        key: _chartKey,
        size: Size(_width * 0.2, _width * 0.2),
        initialChartData: <CircularStackEntry>[
          CircularStackEntry(
            <CircularSegmentEntry>[
              CircularSegmentEntry(
                completed,
                Colors.blue[400],
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
    ]);
  }
}

class feestatus_indicater extends StatefulWidget {
  const feestatus_indicater({super.key});

  @override
  State<feestatus_indicater> createState() => _feestatus_indicaterState();
}

class _feestatus_indicaterState extends State<feestatus_indicater> {
  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    String? data;
    setState(() {
      if (feestatus == 'active') {
        backgroundColor = Colors.green;
        data = 'active';
      } else {
        backgroundColor = Colors.red;
        data = 'Inactive ';
      }
    });

    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(
          content: Text('your subscription is $data'),
          duration: Duration(seconds: 3), // Optional: Set the duration
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
      },
      child: CircleAvatar(
          backgroundColor: backgroundColor,
          radius: 20,
          child: CircleAvatar(
            radius: 17,
          )),
    );
  }
}
