import 'package:flutter/material.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/screen/course_listing_page.dart';
import 'package:greenway_lms/screen/coursedetailsdisplayscreen.dart';
import 'package:greenway_lms/screen/newcoursedetailpage.dart';
// import 'package:lms/screen/demo.dart';

class Searchresult extends StatefulWidget {
  const Searchresult({super.key, this.search});
  final dynamic search;

  @override
  State<Searchresult> createState() => _SearchresultState();
}

class _SearchresultState extends State<Searchresult> {
  @override
  Widget build(BuildContext context) {
    bool searchcontent = false;
    if (widget.search == '') {
      searchcontent = true;
    }
    return Scaffold(
      body: SafeArea(
        child: searchcontent
            ? Center(
                child: Text(
                  'the value is empty',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              )
            : FutureBuilder<List<Map<String, dynamic>>>(
                future: searchresult(widget.search),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Center(
                      child: Image.asset(
                          'assets/no_data_found-removebg-preview (1) (1).png'),
                    );
                  } else {
                    // Use the fetched data as needed

                    List<Map<String, dynamic>> data = snapshot.data!;
                    List image = data.toList();

                    // Display the data in a Container
                    return Container(
                      // padding: EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (Map<String, dynamic> subject in data)
                              GestureDetector(
                                  onTap: () async {
                                    courseid =
                                        {subject['site_courseid']}.toList();
                                    final _result =
                                        await courseindivitual(courseid!);
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
                                      previewvideo =
                                          _result?.data?.previewVideo;
                                      lectures = _result?.data?.lectures;
                                      language = _result?.data?.language;
                                      requirements =
                                          _result?.data?.requirements;

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                coursedetailpage()),
                                      );
                                    }
                                  },
                                  child: Container()
                                  // allcourse_card(subject: subject),
                                  ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
      ),
    );
  }
}
