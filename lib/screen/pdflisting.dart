import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/others/constants.dart';

import 'package:greenway_lms/screen/imageviewer.dart';
import 'package:greenway_lms/screen/notesinnerlist.dart';
import 'package:greenway_lms/screen/pdfviewer.dart';
import 'package:greenway_lms/screen/pptviewer.dart';

class notelisting extends StatelessWidget {
  const notelisting({super.key, required this.topicid});
  final String topicid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<List<Map<String, dynamic>>?>(
        future: getallpdf(topicid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Use the fetched data as needed

            List<Map<String, dynamic>> data = snapshot.data!;
            return CustomScrollView(
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
                            'Notes',
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                            pdflistcard(subject: subject),
                        ],
                      ),
                    );
                  }, childCount: 1),
                ),
              ],
            );
          }
        },
      )),
    );
  }
}

class pdflistcard extends StatelessWidget {
  const pdflistcard({
    super.key,
    required this.subject,
  });

  final Map<String, dynamic> subject;

  @override
  Widget build(BuildContext context) {
    bool multiple = false;
    dynamic fileName = subject['file_name'];

    dynamic pdf = jsonDecode(fileName);
    int length = pdf.length;
    print(length);

    if (length > 1) {
      multiple = true;
      print(multiple);
      print('123');
    } else {}
    String Pdf = pdf.toString();

    String apiResponse = "$Pdf";
    print('Original API Response: $apiResponse');

    String pdffileurl = apiResponse.replaceAll('[', '').replaceAll(']', '');
    print('Cleaned Response: $pdffileurl');
    bool isPdf = checkFileExtension(pdffileurl, '.pdf');
    bool isPng = checkFileExtension(pdffileurl, '.png');
    bool isPPt = checkFileExtension(pdffileurl, '.ppt');
    bool isPPtx = checkFileExtension(pdffileurl, '.pptx');

    bool isJpg = checkFileExtension(pdffileurl, '.jpg');
    bool isJpeg = checkFileExtension(pdffileurl, '.jpeg');
    String name = '${subject['title']}';
    String dec = '${subject['descp']}';

    return Card(
      child: multiple
          ? GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => noteinnerlist(
                            pdf: pdf,
                            name: name,
                            dec: dec,
                          )),
                );
              },
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
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
                        padding: EdgeInsets.all(15),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(15),
                                // color: Colors.orange,
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Files',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.orange),
                                    ),
                                    Text(
                                      '$length',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.orange),
                                    )
                                  ]),
                            )),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${subject['title']}'),
                            Text('${subject['descp']}')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : GestureDetector(
              onTap: () {
                if (isPdf) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => pdfpage(pdfUrl: pdffileurl)),
                  );
                }
                if (isPng || isJpg || isJpeg) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => imgviewer(
                              imgurl: pdffileurl,
                            )),
                  );
                }
                if (isPPt || isPPtx) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomPDFViewer()),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ]),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: isPdf
                                ? Image.asset('assets/pdfdeafaulticon.png')
                                : isPng || isJpeg || isJpg
                                    ? Image.asset('assets/defaulticonjpg.png')
                                    : isPPt || isPPtx
                                        ? Image.asset(
                                            'assets/pptdefault icon.jpeg')
                                        : Image.asset(
                                            'assets/image not found.png')),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${subject['title']}'),
                            Text('${subject['descp']}')
                          ],
                        ),
                      ))
                ]),
              ),
            ),
    );
  }

  bool checkFileExtension(String url, String extension) {
    String lowercaseUrl = url.toLowerCase();
    return lowercaseUrl.endsWith(extension);
  }
}
