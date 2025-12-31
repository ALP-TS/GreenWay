// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greenway_lms/dashboard/dashboard.dart';
// import 'package:get/get.dart';
import 'package:greenway_lms/dashboard/widget/bottomnavigationbar.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
// import 'package:greenway_lms/data.dart/urls.dart';
import 'package:greenway_lms/loginpage/loginpage.dart';
// ignore: depend_on_referenced_packages
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/screen/coursedetailsdisplayscreen.dart';
import 'package:greenway_lms/screen/courselist_categeory_list.dart';
import 'package:greenway_lms/screen/newcoursedetailpage.dart';
import 'package:greenway_lms/screen/searchresult.dart';
// import 'package:http/http.dart';

class course_listing_page extends StatefulWidget {
  const course_listing_page({super.key});

  @override
  State<course_listing_page> createState() => _course_listing_pageState();
}

class _course_listing_pageState extends State<course_listing_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.0),
        child: AppBar(
            flexibleSpace: Container(
          height: 50,
          decoration: BoxDecoration(gradient: myGradient),
        )),
      ),
      body: SafeArea(
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomScrollView(
              // scrollDirection: Axis.horizontal,
              slivers: [
                const SliverAppBar(
                  elevation: 0,
                  centerTitle: false,
                  expandedHeight: 625,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      background: customslider1(),
                      stretchModes: [StretchMode.blurBackground]),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  // return allcourselister();
                }, childCount: 1))
              ],
            ),
            Container(
              width: double.infinity,
              height: 155,
              decoration: BoxDecoration(gradient: myGradient),
              child: const headingpart(),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class customslider1 extends StatelessWidget {
  const customslider1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: 380,
          ),
          const searchbarcontainer(),
          const category_container(),
        ]),
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blueGrey.withOpacity(0.2)),
            width: 150,
            height: 30,
            child: Center(
              child: Text('FEATURED',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        CourseList()
        // carousalcourselist()
      ]),
    );
  }
}

class searchbarcontainer extends StatelessWidget {
  const searchbarcontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 210,
      decoration: BoxDecoration(
        gradient: myGradient,
      ),
    );
  }
}

class headingpart extends StatelessWidget {
  const headingpart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool iscondition;
    if (rememberUser == true) {
      iscondition = true;
    } else {
      iscondition = false;
    }

    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              // color: Colors.amber,
              child: iscondition
                  ? Row(children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => navigationbar()),
                            );
                          },
                          child: CircleAvatar()),
                      const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'hello ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          )),
                    ])
                  : Row(
                      children: [
                        TextButton.icon(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            icon: Icon(
                              Icons.power_settings_new,
                              size: 30,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ))
                      ],
                    )),
          Image.asset(
            'assets/Rnlogo-removebg-preview (3).png',
            width: 50,
            height: 50,
          ),
        ]),
        // searchbar()
      ]),
    );
  }
}

// class searchbar extends StatelessWidget {
//   searchbar({
//     super.key,
//   });
//   TextEditingController _controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.symmetric(vertical: 15),
//         child: Container(
//           width: double.infinity,
//           height: 40,
//           decoration: BoxDecoration(boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2), // Color of the shadow
//               spreadRadius: 5, // Spread radius
//               blurRadius: 7, // Blur radius
//               offset: Offset(0, 3),
//             )
//           ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
//           child: Row(children: [
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.only(left: 10),
//                 child: TextField(
//                   controller: _controller,
//                   onChanged: (value) {
//                     // Fetch data when the user types
//                     // _fetchData(value);
//                   },
//                   decoration: InputDecoration(
//                     // labelText: 'Search',
//                     hintText: 'Type course name here...',
//                   ),
//                 ),
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           Searchresult(search: _controller.text.toString())),
//                 );
//                 // Fetch data when the search icon is tapped
//                 // _fetchData(_controller.text);
//               },
//             )
//             // Icon(Icons.search),
//             // Text(
//             //   'Search here',
//             //   selectionColor: Colors.grey,
//             // ),
//           ]),
//         ));
//   }
// }

class category_container extends StatelessWidget {
  const category_container({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 15,
      right: 15,
      top: 156,
      child: Container(
          constraints: BoxConstraints(maxHeight: 200, minHeight: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Color of the shadow
                spreadRadius: 5, // Spread radius
                blurRadius: 7, // Blur radius
                offset: Offset(0, 3),
              )
            ],
            // color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          width: double.infinity,
          height: 200,
          child: FutureBuilder<List<String>>(
              future: coursecategory(),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot1.hasError) {
                  return Center(
                      child: Column(children: [
                    Text('Error: ${snapshot1.error}'),
                    Text('its a server error')
                  ]));
                } else if (snapshot1.hasData) {
                  List<String> category = snapshot1.data as List<String>;
                  print(category.length);
                  int length;
                  if (category.length < 4) {
                    length = category.length;
                  } else {
                    length = 4;
                  }
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: GridView.builder(
                      addRepaintBoundaries: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: length, // Number of icons in each row
                        crossAxisSpacing: 8.0, // Spacing between columns
                        mainAxisSpacing: 8.0, // Spacing between rows
                      ),
                      itemCount: category.length, // Total number of icons
                      itemBuilder: (context, index) {
                        // print(category[index]);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => course_category_list(
                                        label: category[index],
                                      )),
                            );
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/category.png'),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    category[index],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ); // Replace with your icon widget
                      },
                    ),
                  );
                  ;
                } else {
                  return Center(
                    child: Text('data'),
                  );
                }
              })
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         Padding(
          //             padding: EdgeInsets.all(10),
          //             child: Column(children: [
          //               GestureDetector(
          //                   onTap: () {
          //                     Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) => course_category_list()),
          //                     );
          //                   },
          //                   child: CircleAvatar()),
          //               Text('data')
          //             ])),
          //         const Padding(
          //             padding: EdgeInsets.all(10),
          //             child: Column(children: [CircleAvatar(), Text('data')])),
          //         const Padding(
          //             padding: EdgeInsets.all(10),
          //             child: Column(children: [CircleAvatar(), Text('data')])),
          //         const Padding(
          //             padding: EdgeInsets.all(10),
          //             child: Column(children: [CircleAvatar(), Text('data')])),
          //       ],
          //     ),
          //     const SizedBox(
          //       height: 10,
          //     ),
          //     const Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         Padding(
          //             padding: EdgeInsets.all(10),
          //             child: Column(children: [CircleAvatar(), Text('data')])),
          //         Padding(
          //             padding: EdgeInsets.all(10),
          //             child: Column(children: [CircleAvatar(), Text('data')])),
          //         Padding(
          //             padding: EdgeInsets.all(10),
          //             child: Column(children: [CircleAvatar(), Text('data')])),
          //         Padding(
          //             padding: EdgeInsets.all(10),
          //             child: Column(children: [CircleAvatar(), Text('data')])),
          //       ],
          //     )
          //   ],
          // ),
          ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CourseList extends StatefulWidget {
  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: randomcourse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Column(children: [
              Text('Error: ${snapshot.error}'),
              Text('its a server error')
            ]));
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> courses =
                snapshot.data as List<Map<String, dynamic>>;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(courses.length, (index) {
                  return CourseCard(courseData: courses[index]);
                }),
              ),
            );
          } else {
            return Center(
              child: Text('data'),
            );
          }
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> courseData;

  CourseCard({required this.courseData});

  @override
  Widget build(BuildContext context) {
    bool imagecondition;
    if (courseData['profile'] == '') {
      imagecondition = true;
    } else {
      imagecondition = false;
    }
    return Container(
      // color: Colors.amber,
      // margin: EdgeInsets.all(8.0),
      // padding: EdgeInsets.all(8.0),
      width: 200,
      height: 200,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () async {
            print('tapped');
            courseid = {courseData['site_courseid' ?? '']}.toList();
            final _result = await courseindivitual(courseid!);
            print(_result?.status);
            print('123');
            if (_result?.status == 'success') {
              print(_result?.message);
              print(_result?.data?.course);
              coursename = _result?.data?.course;
              subcoursename = _result?.data?.subName;
              orgamount = _result?.data?.orgAmount;
              offeramount = _result?.data?.offerAmount;
              profile = _result?.data?.profile;
              overview = _result?.data?.overview;
              duration = _result?.data?.duration;
              previewvideo = _result?.data?.previewVideo;
              lectures = _result?.data?.lectures;
              language = _result?.data?.language;
              requirements = _result?.data?.requirements;
              student = _result?.data?.students;
              specification = _result?.data?.specifications;
              print(specification);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => coursedetailpage()),
              );
            }
          },
          child: Card(
            elevation: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(children: [
                imagecondition
                    ? Image.asset('assets/default image.png')
                    : Image.network(
                        courseData['profile'] ?? '',
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                      ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        courseData['course'] ?? '',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                    )),
                    height: 50,
                    color: Colors.black.withOpacity(0.3),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class allcourselister extends StatefulWidget {
  final List<String> categorydata;

  const allcourselister({
    super.key,
    required this.categorydata,
  });

  @override
  State<allcourselister> createState() => _allcourselisterState();
}

class _allcourselisterState extends State<allcourselister> {
  bool alllist = true;
  String? name;
  int? id = null;
  // Color buttoncolor = trans
  @override
  Widget build(BuildContext context) {
    print(name);
    print(alllist);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    bool _wascondition;
    return Column(children: [
      Padding(
        padding: EdgeInsets.all(10),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              // color: Colors.blueGrey.withOpacity(0.2),
            ),
            // width: 200,
            // height: 30,
            child: Container(
              decoration: BoxDecoration(),
              height: _width * 0.1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          alllist = true;
                          // print(alllist);
                          name = null;
                          id = null;
                          // print(name);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: id == null ? Colors.blue : null,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        // width: 100,
                        // height: 100,
                        height: _width * 0.1,
                        // color: Colors.red,
                        margin: EdgeInsets.all(5),
                        child: Center(
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                      color: id == null ? Colors.white : null),
                                ))),
                      ),
                    ),
                    for (int i = 0; i < widget.categorydata.length; i++)
                      //  if(id == i)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            alllist = false;
                            // print(alllist);
                            name = widget.categorydata[i];
                            id = i;
                            // print(name);
                          });
                        },
                        child:
                            // if(id == i)
                            Container(
                          decoration: BoxDecoration(
                              color: id == i ? Colors.blue : null,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)),
                          // width: 100,
                          height: 100,
                          // color: Colors.red,
                          margin: EdgeInsets.all(5),
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    widget.categorydata[i],
                                    style: TextStyle(
                                        color: id == i ? Colors.white : null),
                                  ))),
                        ),
                      ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.grey),
                    //       borderRadius: BorderRadius.circular(5)),
                    //   width: 100,
                    //   height: 100,
                    //   // color: Colors.red,
                    //   margin: EdgeInsets.all(5),
                    // ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.grey),
                    //       borderRadius: BorderRadius.circular(5)),
                    //   width: 100,
                    //   height: 100,
                    //   // color: Colors.red,
                    //   margin: EdgeInsets.all(5),
                    // ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.grey),
                    //       borderRadius: BorderRadius.circular(5)),
                    //   width: 100,
                    //   height: 100,
                    //   // color: Colors.red,
                    //   margin: EdgeInsets.all(5),
                    // ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.grey),
                    //       borderRadius: BorderRadius.circular(5)),
                    //   width: 100,
                    //   height: 100,
                    //   // color: Colors.red,
                    //   margin: EdgeInsets.all(5),
                    // ),
                  ],
                ),
              ),
            )),
      ),
      alllist
          ? FutureBuilder<List<Map<String, dynamic>>>(
              future: getallcourse(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Use the fetched data as needed

                  List<Map<String, dynamic>> data = snapshot.data!;

                  List image = data.toList();
                  // print('dataaaaaa');

                  // Display the data in a Container
                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (Map<String, dynamic> subject in data)
                          GestureDetector(
                            onTap: () async {
                              courseid = {subject['site_courseid']}.toList();
                              final _result = await courseindivitual(courseid!);
                              print(_result?.status);
                              if (_result?.status == 'success') {
                                print(_result?.message);
                                print(_result?.data?.course);
                                coursename = _result?.data?.course;
                                subcoursename = _result?.data?.subName;
                                orgamount = _result?.data?.orgAmount;
                                offeramount = _result?.data?.offerAmount;
                                profile = _result?.data?.profile;
                                overview = _result?.data?.overview;
                                duration = _result?.data?.duration;
                                previewvideo = _result?.data?.previewVideo;
                                lectures = _result?.data?.lectures;
                                language = _result?.data?.language;
                                requirements = _result?.data?.requirements;
                                specification = _result?.data?.specifications;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => coursedetailpage()),
                                );
                              }
                            },
                            child: allcourse_card(subject: subject),
                          ),
                      ],
                    ),
                  );
                }
              },
            )
          : FutureBuilder<List<Map<String, dynamic>>>(
              future: categorycourse(name),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Use the fetched data as needed

                  List<Map<String, dynamic>> data = snapshot.data!;
                  List image = data.toList();
                  print(data);

                  // Display the data in a Container
                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (Map<String, dynamic> subject in data)
                          GestureDetector(
                            onTap: () async {
                              courseid = {subject['site_courseid']}.toList();
                              final _result = await courseindivitual(courseid!);
                              print(_result?.status);
                              if (_result?.status == 'success') {
                                print(_result?.message);
                                print(_result?.data?.course);
                                coursename = _result?.data?.course;
                                subcoursename = _result?.data?.subName;
                                orgamount = _result?.data?.orgAmount;
                                offeramount = _result?.data?.offerAmount;
                                profile = _result?.data?.profile;
                                overview = _result?.data?.overview;
                                duration = _result?.data?.duration;
                                previewvideo = _result?.data?.previewVideo;
                                lectures = _result?.data?.lectures;
                                language = _result?.data?.language;
                                requirements = _result?.data?.requirements;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => coursedetailpage()),
                                );
                              }
                            },
                            child:
                                // Container()
                                allcourse_card(subject: subject),
                          ),
                      ],
                    ),
                  );
                }
              },
            )
    ]);
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              ListTile(
                // leading: Icon(Icons.photo),
                title: Text('Photos'),
                onTap: () {
                  // Handle tapping on Photos
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Music'),
                onTap: () {
                  // Handle tapping on Music
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library),
                title: Text('Videos'),
                onTap: () {
                  // Handle tapping on Videos
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class allcourse_card extends StatelessWidget {
  const allcourse_card({
    super.key,
    required this.subject,
  });

  final Map<String, dynamic> subject;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    // print(subject);
    bool imagecondition;
    if (subject['profile'] == '') {
      imagecondition = true;
    } else {
      imagecondition = false;
    }
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            width: _width,
            // height: _height * 0.35,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(_width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildText(' ${subject['course']}', Colors.black, 15),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    // height: _height * 0.15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: imagecondition
                          ? Image.asset(
                              'assets/course.jpg',
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              '${subject['profile']}',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  buildText(' ${subject['sub_name']}', Colors.black, 15),
                  Divider(
                    color: Colors.orange,
                    thickness: 2,
                  ),
                  Row(children: [
                    Icon(
                      Icons.currency_rupee_rounded,
                      color: Colors.orange,
                      size: 15,
                    ),
                    buildText('${subject['offer_amount']}', Colors.orange, 15),
                    SizedBox(
                      width: 5,
                    ),
                    // buildText(course['org_amount'], Appcolor.greenlight, 15),
                    Text('${subject['org_amount']}',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.blue))
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildbutton('Explore', _height, _width, Colors.yellow,
                          Colors.blue, 15),
                      // _buildbutton('Buy Now', height, width, Appcolor.white,
                      //     Appcolor.green, 15)
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: _width * 0.02,
          )
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Photos'),
                onTap: () {
                  // Handle tapping on Photos
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Music'),
                onTap: () {
                  // Handle tapping on Music
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library),
                title: Text('Videos'),
                onTap: () {
                  // Handle tapping on Videos
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildText(String text, Color textColor, double fontSize) {
    return Text(
      text, textAlign: TextAlign.center, // Pass the text parameter here

      maxLines: 10,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildbutton(String text, double height, double width, Color textcolor,
      Color color, double fontsize) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        // border: Border.all(color: Appcolor.green),
      ),
      width: width * 0.8,
      height: height * 0.05,
      child: Center(child: buildText(text, textcolor, 15)),
    );
  }

  // Card(
  //     child: Container(
  //   decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(15),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.2),
  //           spreadRadius: 5,
  //           blurRadius: 7,
  //           offset: Offset(0, 3),
  //         )
  //       ]),
  //   // color: Colors.amber,
  //   width: double.infinity,
  //   height: 150,
  //   child: Row(
  //     children: [
  //       Expanded(
  //         flex: 1,
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 10),
  //           child: Container(
  //             decoration: BoxDecoration(
  //                 // color: Colors.black,
  //                 borderRadius: BorderRadius.circular(15)),
  //             // height: 150,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(15),
  //               child: imagecondition
  //                   ? Image.asset('assets/default image.png')
  //                   : Image.network(
  //                       '${subject['profile']}',
  //                       fit: BoxFit.cover,
  //                     ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       Expanded(
  //         flex: 2,
  //         child: Padding(
  //           padding: EdgeInsets.all(10),
  //           child: Container(
  //             // color: Colors.amber,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   ' ${subject['course']}',
  //                   style:
  //                       TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  //                 ),
  //                 Text(
  //                   ' ${subject['course']}',
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //                 Row(children: [
  //                   Padding(
  //                     padding: EdgeInsets.all(10),
  //                     child: Container(
  //                       height: 35,
  //                       decoration: BoxDecoration(
  //                           boxShadow: [
  //                             BoxShadow(
  //                               color: Colors.black.withOpacity(0.2),
  //                               spreadRadius: 5,
  //                               blurRadius: 7,
  //                               offset: Offset(0, 3),
  //                             )
  //                           ],
  //                           borderRadius: BorderRadius.circular(15),
  //                           color: Colors.red),
  //                       child: TextButton.icon(
  //                           onPressed: () {},
  //                           icon: Icon(Icons.currency_rupee_outlined),
  //                           label: Text('${subject['org_amount']}')),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.all(10),
  //                     child: Container(
  //                       height: 35,
  //                       decoration: BoxDecoration(
  //                           boxShadow: [
  //                             BoxShadow(
  //                               color: Colors.black.withOpacity(0.2),
  //                               spreadRadius: 5,
  //                               blurRadius: 7,
  //                               offset: Offset(0, 3),
  //                             )
  //                           ],
  //                           borderRadius: BorderRadius.circular(15),
  //                           color: Colors.amber),
  //                       child: TextButton.icon(
  //                           onPressed: () {},
  //                           icon: Icon(Icons.currency_rupee_outlined),
  //                           label: Text('${subject['offer_amount']}')),
  //                     ),
  //                   ),
  //                 ]),
  //               ],
  //             ),
  //           ),
  //         ),
  //       )
  //     ],
  //   ),
  // ));
}

// import 'package:flutter/material.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Bottomsheet(),
//     );
//   }
// }

class Bottomsheet extends StatelessWidget {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Photos'),
                onTap: () {
                  // Handle tapping on Photos
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Music'),
                onTap: () {
                  // Handle tapping on Music
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library),
                title: Text('Videos'),
                onTap: () {
                  // Handle tapping on Videos
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Sheet Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showBottomSheet(context);
          },
          child: Text('Show Bottom Sheet'),
        ),
      ),
    );
  }
}




























































































































































// GridView.builder(
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 2, // Number of columns
//     crossAxisSpacing: 10.0, // Spacing between columns
//     mainAxisSpacing: 10.0, // Spacing between rows
//   ),
//   itemCount: data.length,
//   itemBuilder: (BuildContext context, int index) {
//     Datum datum = data[index];
//     return GridTile(
//       child: Padding(
//         padding: EdgeInsets.all(10),
//         child: GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => topiclisting(
//                         subid: '${datum.subjectId}',
//                       )),
//             );
//           },
//           child: Container(
//             height: 50, // Set the height of the container to 50px
//             decoration: BoxDecoration(
//               border: Border(
//                 left: BorderSide(color: Colors.orange, width: 3),
//               ),
//               color: Colors.white,
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Row(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '${datum.name}',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       Text(
//                         'Topic Count :${datum.tCount}',
//                         style: TextStyle(fontSize: 15),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   },
// ),
































// // import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:lms/dashboard/dashboard.dart';
// // import 'package:get/get.dart';
// import 'package:lms/dashboard/widget/bottomnavigationbar.dart';
// import 'package:lms/data.dart/apicalls.dart';
// // import 'package:lms/data.dart/urls.dart';
// import 'package:lms/loginpage/loginpage.dart';
// // ignore: depend_on_referenced_packages
// // import 'package:carousel_slider/carousel_slider.dart';
// import 'package:lms/others/constants.dart';
// import 'package:lms/screen/coursedetailsdisplayscreen.dart';
// import 'package:lms/screen/courselist_categeory_list.dart';
// import 'package:lms/screen/searchresult.dart';

// // import 'package:http/http.dart';
// class course_listing_page extends StatefulWidget {
//   const course_listing_page({super.key});

//   @override
//   State<course_listing_page> createState() => _course_listing_pageState();
// }

// class _course_listing_pageState extends State<course_listing_page> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(10.0),
//         child: AppBar(
//             flexibleSpace: Container(
//           height: 50,
//           decoration: BoxDecoration(gradient: myGradient),
//         )),
//       ),
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               elevation: 0,
//               centerTitle: false,
//               expandedHeight: 625,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                   background: Container(
//                     color: Colors.amber,
//                     height: MediaQuery.of(context).size.height * 0.5,
//                     width: MediaQuery.of(context).size.width,
//                   ),
//                   //  customslider1(),
//                   stretchModes: [StretchMode.blurBackground]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
