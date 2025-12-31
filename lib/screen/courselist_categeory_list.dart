// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/screen/course_listing_page.dart';
import 'package:greenway_lms/screen/coursedetailsdisplayscreen.dart';
import 'package:greenway_lms/screen/newcoursedetailpage.dart';
// import 'package:lms/screen/demo.dart';
// import 'package:lms/data.dart/apicalls.dart';

// import 'package:lms/data.dart/urls.dart';
// import 'package:http/http.dart';

class course_category_list extends StatelessWidget {
  const course_category_list({super.key, required this.label});
  final label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(label)),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              centerTitle: false,
              expandedHeight: 50,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                child: Center(
                    child: Text(
                  label,
                  style: TextStyle(fontSize: 25),
                )),
                width: double.infinity,
                height: 200,
              )),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return categorylister(
                name: label,
              );
            }, childCount: 1))
          ],
        ),
      ),
    );
  }
}

class categorylister extends StatelessWidget {
  const categorylister({
    super.key,
    required this.name,
  });
  final name;

  @override
  Widget build(BuildContext context) {
    bool _wascondition;
    return FutureBuilder<List<Map<String, dynamic>>>(
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
    );
  }
}
