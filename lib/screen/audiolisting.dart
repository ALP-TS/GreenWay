import 'package:flutter/material.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/screen/audioplayer.dart';
import 'package:greenway_lms/screen/course_listing_page.dart';
import 'package:greenway_lms/screen/pdfviewer.dart';
import 'package:greenway_lms/screen/videoplayer.dart';

class audiolisting extends StatelessWidget {
  const audiolisting({super.key, required this.topicid});
  final String topicid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<List<Map<String, dynamic>>?>(
        future: getallaudio(
            topicid), ///////////////////////////////////////////////////////////
        // getallcourse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Use the fetched data as needed
            bool notnull = true;

            List<Map<String, dynamic>> data = snapshot.data!;
            print(data.length < 1);
            if (data.length < 1) {
              notnull = false;
            }

            // List image = data.toList();

            // Display the data in a Container
            return notnull
                ? CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        elevation: 0,
                        centerTitle: false,
                        expandedHeight: 100,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                              decoration: BoxDecoration(gradient: myGradient),
                              child: Center(
                                child: Text(
                                  'Audio', //////////////////////////////////////////////////////////////
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            stretchModes: [StretchMode.zoomBackground]),
                      ),
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
                                    child: Card(
                                      child: GestureDetector(
                                        onTap: () async {
                                          String? status = await audioseen(
                                              userId!,
                                              '${subject['audio_id']}');
                                          print('${subject['audio_id']}');
                                          print(status);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    audioplayer(
                                                      url: '${subject['name']}',
                                                      /////////////////////////////////////////////
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
                                                ),
                                              ]),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        // color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    // height: 150,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Image.asset(
                                                          'assets/audio default icon.png'), /////////////////////////////////////////////
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('name'),
                                                      Text(
                                                          '${subject['file_name']}')
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }, childCount: 1),
                      ),
                    ],
                  )
                : datanotfound();
          }
        },
      )),
    );
  }
}

class datanotfound extends StatelessWidget {
  const datanotfound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Image.asset(
          'assets/no_data_found-removebg-preview (1) (1).png',
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
