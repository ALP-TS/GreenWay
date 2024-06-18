import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greenway_lms/dashboard/dashboard.dart';
import 'package:greenway_lms/dashboard/widget/bottomnavigationbar.dart';
import 'package:greenway_lms/dashboard/widget/carousaldash.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/loginpage/loginpage.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/screen/course_listing_page.dart';
import 'package:greenway_lms/screen/newcoursedetailpage.dart';

// import 'package:mcj/colors.dart';
class newcourse extends StatefulWidget {
  final List<String> categorydata;
  const newcourse({super.key, required this.categorydata});

  @override
  State<newcourse> createState() => _newcourseState();
}

class _newcourseState extends State<newcourse> {
  @override
  Widget build(BuildContext context) {
    bool islogin = false;
    if (rememberUser == true) {
      islogin = true;
    }
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
        body: Stack(children: [
      CustomScrollView(slivers: [
        const SliverAppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          expandedHeight: 500,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              background: sliverbar(),
              stretchModes: [StretchMode.blurBackground]),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return allcourselister(
            categorydata: widget.categorydata,
          );
        }, childCount: 1))
      ]),
      Positioned(
        left: 0, right: 0,
        // height: _width * 0.5,
        bottom: 0,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.blue))),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Already have an Account?',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
                onTap: () {
                  if (islogin == true) {
                    print('tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => navigationbar(),
                      ),
                    );
                  } else {
                    print('tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  }
                },
                child: Text(
                  islogin ? 'Go To Dashboard' : 'Login',
                  style: TextStyle(color: Colors.blue),
                ))
          ]),
          height: _width * 0.15,
          width: double.infinity,
          // color: const Color.fromARGB(255, 175, 171, 171),
        ),
      )
    ]));
  }
}

class sliverbar extends StatelessWidget {
  const sliverbar({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController;
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            // height: _height*0.25,
            decoration: BoxDecoration(
              gradient: myGradient,
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welcome To \nRN Plus',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          CircleAvatar(
                            backgroundImage: AssetImage(logo),
                            radius: _width * 0.05,
                          ),
                          //  CircleAvatar(backgroundImage: ,)
                        ]),
                    // Row(children: [
                    //   Text(
                    //     'Already have an account ?',
                    //     style: TextStyle(color: Colors.white, fontSize: 15),
                    //   ),
                    //   Text(
                    //     'Login',
                    //     style: TextStyle(color: Colors.orange, fontSize: 20),
                    //   )
                    // ]),
                    SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   height: 50,
                    //   decoration: BoxDecoration(boxShadow: [
                    //     BoxShadow(
                    //         offset: const Offset(12, 26),
                    //         blurRadius: 50,
                    //         spreadRadius: 0,
                    //         color: Colors.grey.withOpacity(.1)),
                    //   ]),
                    //   child: TextField(
                    //     // controller: searchController,
                    //     textAlign: TextAlign.center,
                    //     onChanged: (value) {},
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => searchpages(),
                    //         ),
                    //       );
                    //     },
                    //     style: const TextStyle(fontSize: 14),
                    //     decoration: InputDecoration(
                    //       // prefixIcon: Icon(Icons.email),
                    //       prefixIcon: const Icon(Icons.search,
                    //           size: 20, color: Color(0xffFF5A60)),
                    //       filled: true,
                    //       fillColor: Colors.white,
                    //       hintText: 'Search Courses',
                    //       hintStyle:
                    //           TextStyle(color: Colors.black.withOpacity(.75)),
                    //       contentPadding: const EdgeInsets.symmetric(
                    //           vertical: 0.0, horizontal: 20.0),
                    //       border: const OutlineInputBorder(
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(15.0)),
                    //       ),
                    //       enabledBorder: const OutlineInputBorder(
                    //         borderSide:
                    //             BorderSide(color: Colors.white, width: 1.0),
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(15.0)),
                    //       ),
                    //       focusedBorder: const OutlineInputBorder(
                    //         borderSide:
                    //             BorderSide(color: Colors.white, width: 2.0),
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(15.0)),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ]),
            ),
          ),
        ),
        // searchbarcontainer(),
        SizedBox(
          height: 20,
        ),
        Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  // Text(
                  //   'WELCOME TO ',
                  //   style: TextStyle(
                  //       // shadows: [
                  //       //   Shadow(
                  //       //     color: Appcolor.yellow,
                  //       //     // Set shadow color same as text color
                  //       //     blurRadius: 5,
                  //       //     offset: Offset(0, 0),
                  //       //   ),
                  //       // ],
                  //       color: Colors.blue,
                  //       fontSize: 30,
                  //       fontWeight: FontWeight.w700),
                  // ),
                  Container(
                    width: _width * 0.8,
                    child: Align(
                      alignment: Alignment.center,
                      child: buildText(
                          'Our platform offers a wide range of features  to make your learning experience more enjoyable experience more enjoyable',
                          Colors.black,
                          15),
                    ),
                  ),
                ],
              ),
            )),
        Expanded(flex: 2, child: carousaldash()),
        // carousaldash()
      ],
      // height: _height,
      // color: Colors.amber,
    );
  }
}

Widget buildText(String text, Color textColor, double fontSize) {
  return Text(
    text, textAlign: TextAlign.center, // Pass the text parameter here

    maxLines: 3,
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

class SearchInputFb1 extends StatelessWidget {
  final TextEditingController searchController;
  final String hintText;

  const SearchInputFb1(
      {required this.searchController, required this.hintText, Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        controller: searchController,
        textAlign: TextAlign.center,
        onChanged: (value) {},
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.email),
          prefixIcon:
              const Icon(Icons.search, size: 20, color: Color(0xffFF5A60)),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black.withOpacity(.75)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
    );
  }
}

class searchpages extends StatefulWidget {
  const searchpages({super.key});

  @override
  State<searchpages> createState() => _searchpagesState();
}

class _searchpagesState extends State<searchpages> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(12, 26),
                        blurRadius: 50,
                        spreadRadius: 0,
                        color: Colors.grey.withOpacity(.1)),
                  ],
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                onChanged: (value) async {
                  final searchResults = await search(value);
                  setState(() {
                    _searchResults = searchResults;
                  });
                  print(searchResults);
                },
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.email),
                  prefixIcon: const Icon(Icons.search,
                      size: 20, color: Color(0xffFF5A60)),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search Courses',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(.75)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 20.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              // itemCount: 50,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Searchlist(
                          searchvalue: _searchResults[index]['course'],
                          searchid: _searchResults[index]['site_courseid'],
                        ),
                      ),
                    );
                    // print(_searchResults[index]['videoname']);
                    // setState(() {
                    //   // searchvalue = _searchResults[index]['videoname'];
                    //   widget.updateSearchValue(
                    //       _searchResults[index]['videoname']);
                    //   _searchResults = [];
                    // });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: _width * 0.02, right: _width * 0.02),
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(5),
                            // color: Colors.white,
                            // border: Border(
                            // bottom: BorderSide(color: Colors.grey),
                            // ),
                            ),
                        width: double.infinity,
                        height: _width * 0.1,

                        child: Padding(
                          padding: EdgeInsets.only(left: _width * 0.02),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(children: [
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                    flex: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.5)))),
                                      child: Text(
                                        _searchResults[index]['course'],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ))
                              ])),
                        ),
                        // You can customize ListTile as needed
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}

class Searchlist extends StatelessWidget {
  final String searchid;
  final String searchvalue;
  const Searchlist(
      {super.key, required this.searchvalue, required this.searchid});

  @override
  Widget build(BuildContext context) {
    // print(object)
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<Map<String, dynamic>>(
        future: corsebyid(searchid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Use the fetched data as needed

            Map<String, dynamic> data = snapshot.data!;
            print(data);

            // List image = data.toList();
            // print('dataaaaaa');

            // Display the data in a Container
            return SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(12, 26),
                              blurRadius: 50,
                              spreadRadius: 0,
                              color: Colors.grey.withOpacity(.1)),
                        ],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      // controller: searchController,
                      textAlign: TextAlign.center,
                      onChanged: (value) {},
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => searchpages(),
                          ),
                        );
                      },
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.email),
                        prefixIcon: const Icon(Icons.search,
                            size: 20, color: Color(0xffFF5A60)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: searchvalue,
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(.75)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 20.0),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // for (Map<String, dynamic> subject in data)
                      GestureDetector(
                        onTap: () async {
                          // courseid = {subject['site_courseid']}.toList();
                          // final _result = await courseindivitual(courseid!);
                          // print(_result?.status);
                          // if (_result?.status == 'success') {
                          // print(data['profile']);
                          // print(_result?.data?.course);
                          coursename = data['course'];
                          subcoursename = data['sub_name'];
                          orgamount = data['org_amount'];
                          offeramount = data['offer_amount'];
                          profile = data['profile'];
                          overview = data['overview'];
                          duration = data['duration'];
                          // previewvideo = _result?.data?.previewVideo;
                          lectures = data['lectures'];
                          language = data['language'];
                          requirements = data['requirements'];
                          specification = data['specifications'];

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => coursedetailpage()),
                          );
                          // }
                        },
                        child: allcourse_card(subject: data),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          }
        },
      )),
    );
  }
}
