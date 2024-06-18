// import 'dart:convert';

import 'package:greenway_lms/colors.dart';
import 'package:greenway_lms/data.dart/coursedetailsindivitual/coursedetailsindivitual.dart';
import 'package:greenway_lms/others/constants.dart';
// import 'package:caams_learning_app/others/Colors.dart';
// import 'package:caams_learning_app/others/components.dart';
// import 'package:caams_learning_app/screens/Tabbarcoursedetailing.dart';
import 'package:flutter/material.dart';
// import 'package:mcj/colors.dart';
// import 'package:mcj/others/constants.dart';

class coursedetailpage extends StatefulWidget {
  // final Coursedetailsindivitual? course;
  // const coursedetailpage({super.key, required this.course});

  @override
  State<coursedetailpage> createState() => _coursedetailpageState();
}

class _coursedetailpageState extends State<coursedetailpage> {
  bool pic = false;

  // bool curriculum = false;
  // bool instructor = false;
  // bool Review = false;
  @override
  Widget build(BuildContext context) {
    if (profile == '') {
      setState(() {
        pic = true;
      });
    } else {}
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;

    // List<dynamic> teachersList = widget.course['requirements'].split(',');

    print(requirements);
    // print(teachersList[1]);
    print('hi');
    // json.decode(widget.course['requirements']).cast<String>().toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: buildText('Details of Course', Appcolor.black, 20),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: _width * 0.025,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Appcolor.grey,
                  ),
                  height: _height * 0.4, // Adjust height as needed
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: _width * 0.01, right: _width * 0.01),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: pic
                          ? Image.asset(
                              'assets/default image.png',
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              profile!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: _height * 0.15, // Adjust height as needed
                  // color: Colors.green,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: _width * 0.04, right: _width * 0.04),
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildText(coursename!, Appcolor.black, 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(children: [
                                    Icon(
                                      Icons.group,
                                      color: Appcolor.grey,
                                    ),
                                    buildText(student ?? '0', Appcolor.grey, 15)
                                  ]),
                                ),
                                Container(
                                  child: Row(children: [
                                    // Icon(
                                    //   Icons.calendar_month_outlined,
                                    //   color: Appcolor.grey,
                                    // ),
                                    // buildText('15/04/2024', Appcolor.grey, 15)
                                  ]),
                                ),
                              ]),
                        ]),
                  ),
                ),
                CustomTabBarsPage(
                    // overview: widget.course['overview'],
                    // Specification: widget.course['specifications'],
                    // instructer: teachersList,
                    ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // color: Colors.grey[200],
                  ),
                  height: _height * 0.6,
                  width: _width,
                  child: Padding(
                    padding: EdgeInsets.all(_width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        buildText('Course Includes :', Appcolor.black, 25),
                        _buildcontainer1(Icons.network_cell_rounded, 'Level',
                            'Beginer', _height, _width),
                        Divider(
                          color: Appcolor.yellowlight,
                          thickness: 2,
                        ),
                        _buildcontainer1(Icons.av_timer_rounded, 'Duration',
                            duration ?? '', _height, _width),
                        Divider(
                          color: Appcolor.yellowlight,
                          thickness: 2,
                        ),
                        _buildcontainer1(Icons.menu_book, 'Lesson',
                            lectures ?? '', _height, _width),
                        Divider(
                          color: Appcolor.yellowlight,
                          thickness: 2,
                        ),
                        _buildcontainer1(Icons.language_rounded, 'Languages',
                            language ?? '', _height, _width),
                        Divider(
                          color: Appcolor.yellowlight,
                          thickness: 2,
                        ),
                        // _buildcontainer1(Icons.network_cell_rounded,
                        //     'Certificate', 'yes', _height, _width),
                        // Divider(
                        //   color: Appcolor.white,
                        //   thickness: 2,
                        // ),
                        // _buildcontainer1(Icons.network_cell_rounded, 'Level', 'g',
                        //     _height, _width),
                      ],
                    ),
                  ),
                )
                // Add more widgets as needed
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            color: Appcolor.greylightstack,
            height: _height * 0.1,
            width: _width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  buildText('Price', Appcolor.black, 15),
                  buildText('₹$orgamount', Appcolor.green, 15)
                ]),
                _buildbutton('Buy Now', _height, _width, Appcolor.white,
                    Appcolor.green, 15)
              ],
            ),
          ),
        )
      ]),
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
      width: width * 0.6,
      height: height * 0.05,
      child: Center(child: buildText(text, textcolor, 15)),
    );
  }

  Widget _buildcontainer(
      // IconData icondata,
      String text,
      double height,
      double width,
      Color textcolor,
      Color bgcolor,
      bool variable) {
    return Container(
      width: width * 0.275,
      height: variable ? (height * 0.06) + 11 : height * 0.05,
      decoration: BoxDecoration(
        borderRadius: variable
            ? BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))
            : BorderRadius.circular(15),
        color: bgcolor,
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: buildText(text, textcolor, 15),
      ),
    );
  }

  Widget _buildcontainer1(
    IconData icondata,
    String iconname,
    String data,
    double height,
    double width,
  ) {
    return Container(
      width: width,
      //  height: 50,
      // height: height * 0.075,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        // color: Appcolor.yellowlight,
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Icon(icondata, color: Appcolor.black),
              SizedBox(
                width: 5,
              ),
              buildText(iconname, Appcolor.black, 15),
            ]),
            SizedBox(
                width: width * 0.4, child: buildText(data, Appcolor.black, 15))
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';

// Assuming these are your color variables

class newpage extends StatefulWidget {
  @override
  _newpageState createState() => _newpageState();
}

class _newpageState extends State<newpage> {
  // Assuming these are your state variables
  bool overview = true;
  bool curriculum = false;
  bool instructor = false;

  @override
  Widget build(BuildContext context) {
    double _height = 100; // Example height
    double _width = 100; // Example width

    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                overview = true;
                curriculum = false;
                instructor = false;
              });
            },
            child: _buildContainer(
              'Overview',
              _height,
              _width,
              overview ? Appcolor.green : Appcolor.yellowlight,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                overview = false;
                curriculum = true;
                instructor = false;
              });
            },
            child: _buildContainer(
              'Curriculum',
              _height,
              _width,
              curriculum ? Appcolor.green : Appcolor.yellowlight,
            ),
          ),
          // Add more GestureDetector widgets for other options if needed
        ],
      ),
    );
  }

  Widget _buildContainer(
    String text,
    double height,
    double width,
    Color backgroundColor,
  ) {
    return Container(
      height: height,
      width: width,
      color: backgroundColor,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class CustomTabBarsPage extends StatefulWidget {
  const CustomTabBarsPage({
    Key? key,
    // required this.overview,
    // required this.Specification,
    // required this.instructer
  }) : super(key: key);
  // final String overview;
  // final String Specification;
  // final List<dynamic> instructer;

  @override
  State<CustomTabBarsPage> createState() => _CustomTabBarsPageState();
}

class _CustomTabBarsPageState extends State<CustomTabBarsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _selectedColor = Appcolor.yellow;
  final _unselectedColor = Appcolor.green;
  final _tabs = const [
    Tab(text: 'Overview'),
    Tab(text: 'Curriculum'),
    Tab(text: 'Requirements'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> teachersList = [''];
    // int length = 0;
    if (requirements != null) {
      teachersList = requirements!.split(',');
      // length = teachersList.length;
    } else {
      List<dynamic> teachersList = [];
    }
    // List<dynamic> teachersList = requirements.split(',');
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Container(
      width: double.infinity,
      height: _height * 0.5,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: _selectedColor,
            unselectedLabelColor: _unselectedColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: MaterialDesignIndicator(
              indicatorHeight: 4,
              indicatorColor: _selectedColor,
            ),
            tabs: _tabs,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  // color: Colors.red, // Replace with your content for Tab1
                  child: Container(
                    color: Appcolor.white,
                    height: _height * 0.25,
                    width: _width,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: buildText(overview!, Appcolor.grey, 12),
                    ),
                  ),
                ),
                Container(
                  color: Appcolor.white,
                  height: _height * 0.5,
                  width: _width,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: buildText(specification ?? '', Appcolor.grey, 12),
                  ),
                ),
                Container(
                  // color: Appcolor.yellow,
                  height: 100,
                  width: _width,
                  child: ListView.builder(
                    // scrollDirection:
                    // Axis.horizontal, // Set scroll direction to horizontal
                    itemCount: teachersList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(_width * 0.02),
                        child: Row(
                          children: [
                            // Icon(
                            //   Icons.arrow_forward_ios_rounded,
                            //   color: Appcolor.yellow,
                            // ),
                            Container(
                                height: _height * 0.5,
                                width: _width - 20,
                                // width: double.infinity,
                                // height: _height * 0.5,
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: buildText(
                                      teachersList[index], Appcolor.grey, 12),
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialDesignIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;

  const MaterialDesignIndicator({
    required this.indicatorHeight,
    required this.indicatorColor,
  });

  @override
  createBoxPainter([VoidCallback? onChanged]) {
    return _MaterialDesignPainter(this, onChanged);
  }
}

class _MaterialDesignPainter extends BoxPainter {
  final MaterialDesignIndicator decoration;

  _MaterialDesignPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Rect rect = Offset(
          offset.dx,
          configuration.size!.height - decoration.indicatorHeight,
        ) &
        Size(configuration.size!.width, decoration.indicatorHeight);

    final Paint paint = Paint()
      ..color = decoration.indicatorColor
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topRight: const Radius.circular(8),
        topLeft: const Radius.circular(8),
      ),
      paint,
    );
  }
}
