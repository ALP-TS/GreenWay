import 'package:flutter/material.dart';

import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/data.dart/getsubjectmodel/datum.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/screen/topiclisting.dart';

class subjectlisting extends StatelessWidget {
  const subjectlisting({super.key});

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
              'couurse name',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      )),
      body: FutureBuilder<List<Datum>>(
        future: getsubjects(classId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            List<Datum> data = snapshot.data!;
            print(snapshot.data?.toString());
            print('hello');

            return ListView.builder(
              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: 2, // Number of columns
              //   // crossAxisSpacing: 10.0, // Spacing between columns
              //   // mainAxisSpacing: 10.0, // Spacing between rows
              // ),
              itemCount: data.length,
              // itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                Datum datum = data[index];
                // print('${datum.subjectId}');
                return GridTile(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => topiclisting(
                              subid: '${datum.subjectId}',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: _height * 0.1,
                        decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(color: Colors.orange, width: 3)),
                          color: Colors.white,
                        ),
                        width: double.infinity,
                        child: Container(
                          height: _height,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                  right: BorderSide(color: Colors.grey))),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      '${datum.name}',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        'Topic Count :${datum.tCount}',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }
}
