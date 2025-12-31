import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';

import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/data.dart/topiclistingmodel/datum.dart';

import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/screen/audiolisting.dart';
import 'package:greenway_lms/screen/pdflisting.dart';
import 'package:greenway_lms/screen/videolisting.dart';

class topiclisting extends StatelessWidget {
  const topiclisting({super.key, required this.subid});
  final String subid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          flexibleSpace: Container(
        decoration: BoxDecoration(gradient: myGradient),
        height: 100,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Topics',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      )),
      body: FutureBuilder<List<Datumtopic>>(
        future: gettopic(subid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('No topic AvailBle'));
          } else if (snapshot.hasData) {
            // return Center(child: CircularProgressIndicator());
            List<Datumtopic> datatopic = snapshot.data!;
            // print(snapshot.data);
            // print('hello');
            return ListView.builder(
              shrinkWrap: true,
              physics: PageScrollPhysics(),
              itemCount: datatopic.length,
              itemBuilder: ((context, index) {
                Datumtopic datumtopic = datatopic[index];
                return Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                      // color: Colors.amber,
                      child: Accordion(
                    rightIcon: Icon(Icons.keyboard_arrow_down_sharp),
                    headerBorderColor: Color.fromARGB(255, 189, 186, 186),
                    headerBorderWidth: 10,
                    contentBorderColor: Color.fromARGB(255, 228, 226, 226),
                    contentBorderWidth: 2,
                    headerBackgroundColor: Colors.white,
                    // contentBackgroundColor: Colors.black,
                    paddingListBottom: 0,
                    paddingListTop: 0,
                    children: [
                      AccordionSection(
                        headerBorderWidth: 2,
                        contentBorderWidth: 2,
                        header: Container(
                          // decoration: BoxDecoration(gradient: myGradient),
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(children: [
                                  Text(
                                    '${datumtopic.chapter}' ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Topics:${datumtopic.topics}' ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              'Description:${datumtopic.description}' ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(fontSize: 15),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(15),
                                    child: TextButton.icon(
                                        onPressed: () {
                                          // String id = ;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Videolisting(
                                                topicid:
                                                    '${datumtopic.topicId}',
                                              ),
                                            ),
                                          );
                                        },
                                        icon:
                                            Icon(Icons.video_library_outlined),
                                        label: Text('Videos'))),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => notelisting(
                                                  topicid:
                                                      '${datumtopic.topicId}',
                                                )),
                                      );
                                    },
                                    icon: Icon(Icons.note_add_sharp),
                                    label: Text('Notes'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => audiolisting(
                                            topicid: '${datumtopic.topicId}',
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.audio_file_outlined),
                                    label: Text('Audios'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
                );
              }),
            );
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }
}
