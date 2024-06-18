import 'package:greenway_lms/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/screen/course_listing_page.dart';
import 'package:greenway_lms/screen/videoplayer.dart';
import 'package:get/get.dart';

class Videolisting extends StatelessWidget {
  const Videolisting({super.key, required this.topicid});
  final String topicid;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
        decoration: BoxDecoration(gradient: myGradient),
        height: 100,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Videos',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      )),
      body: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>?>(
          future: getallvideos(topicid),
          // getallcourse(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Use the fetched data as needed

              List<Map<String, dynamic>> data = snapshot.data!;
              // List image = data.toList();

              // Display the data in a Container
              return CustomScrollView(
                slivers: [
                  // SliverAppBar(
                  //   elevation: 0,
                  //   centerTitle: false,
                  //   expandedHeight: 100,
                  //   pinned: true,
                  //   flexibleSpace: FlexibleSpaceBar(
                  //       background: Container(
                  //         decoration: BoxDecoration(gradient: myGradient),
                  //         child: Center(
                  //           child: Text(
                  //             'Videos',
                  //             style:
                  //                 TextStyle(color: Colors.white, fontSize: 20),
                  //           ),
                  //         ),
                  //       ),
                  //       stretchModes: [StretchMode.zoomBackground]),
                  // ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (Map<String, dynamic> subject in data)
                              GestureDetector(
                                onTap: () async {},
                                child: Column(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      // borderRadius:
                                      // BorderRadius.all(Radius.circular(15)),
                                      border: Border(
                                          // right: BorderSide(color: Colors.grey),
                                          // top: BorderSide(color: Colors.grey),
                                          // bottom: BorderSide(color: Colors.grey),
                                          left: BorderSide(
                                              width: 3, color: Colors.orange)),
                                      // borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        String? status = await videoseen(
                                            userId!, '${subject['video_id']}');
                                        print('status');
                                        print(status);
                                        print('status');
                                        print(userId);
                                        print('${subject['video_id']}');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyVideoPlayer(
                                                    videoUrl:
                                                        '${subject['name']}',
                                                    Des:
                                                        '${subject['videoname']}',
                                                    topicid: topicid,
                                                    date:
                                                        '${subject['created_at']}',
                                                    // name:
                                                    // '${subject['videoname']}',
                                                  )),
                                        );
                                      },
                                      // child:
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.grey.withOpacity(
                                          //         0.5), // Shadow color
                                          //     spreadRadius: 1, // Spread radius
                                          //     blurRadius: 2, // Blur radius
                                          //     offset: Offset(0, 3), // Offset
                                          //   ),
                                          // ],
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey),
                                              top: BorderSide(
                                                  color: Colors.grey),
                                              right:
                                                  BorderSide(color: Colors.grey)
                                              // color: Colors.black, // Border color
                                              ),
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(
                                                  10)), // Border radius
                                        ),
                                        height: _height * 0.15,
                                        width: double.infinity,
                                        child: Row(children: [
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Column(children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Text(
                                                        '${subject['videoname']}',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                    //  Text(
                                                    //       '${subject['videoname']}'),
                                                    // color: Colors.amber,
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 2),
                                                    child: Divider(
                                                        color: Colors.grey)),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                      child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(timeconvert(
                                                        '${subject['created_at']}')),
                                                  )),
                                                )
                                              ]),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                                child: Icon(
                                              Icons.play_circle_outline,
                                              size: 80,
                                              color: Colors.blue,
                                              // size: double.infinity,
                                            )
                                                // Image.asset(
                                                //     'assets/defaultvideoicon.png'),
                                                ),
                                          )
                                        ]),
                                      ),
                                      // child: Container(
                                      //   width: double.infinity,
                                      //   height: 150,
                                      //   decoration: BoxDecoration(
                                      //       color: Colors.white,
                                      //       borderRadius:
                                      //           BorderRadius.circular(15),
                                      //       boxShadow: [
                                      //         BoxShadow(
                                      //           color:
                                      //               Colors.black.withOpacity(0.2),
                                      //           spreadRadius: 5,
                                      //           blurRadius: 7,
                                      //           offset: Offset(0, 3),
                                      //         ),
                                      //       ]),
                                      //   child: Row(children: [
                                      //     Expanded(
                                      //       flex: 1,
                                      //       child: Padding(
                                      //         padding: EdgeInsets.symmetric(
                                      //             horizontal: 10),
                                      //         child: Container(
                                      //           decoration: BoxDecoration(
                                      //               // color: Colors.black,
                                      //               borderRadius:
                                      //                   BorderRadius.circular(
                                      //                       15)),
                                      //           // height: 150,
                                      //           child: ClipRRect(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(15),
                                      //             child: Image.asset(
                                      //                 'assets/defaultvideoicon.png'),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     Expanded(
                                      //         flex: 2,
                                      //         child: Container(
                                      //           child: Column(
                                      //             mainAxisAlignment:
                                      //                 MainAxisAlignment.center,
                                      //             crossAxisAlignment:
                                      //                 CrossAxisAlignment.start,
                                      //             children: [
                                      //               Text(
                                      //                   '${subject['videoname']}'),
                                      //               // Text('${subject['name']}')
                                      //             ],
                                      //           ),
                                      //         ))
                                      //   ]),
                                      // ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ]),
                              ),
                          ],
                        ),
                      );
                    }, childCount: 1),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
