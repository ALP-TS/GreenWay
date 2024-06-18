import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:greenway_lms/others/constants.dart';

class Topiclist extends StatefulWidget {
  const Topiclist({super.key});

  @override
  State<Topiclist> createState() => _TopiclistState();
}

class _TopiclistState extends State<Topiclist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const PageScrollPhysics(),
              itemCount: 10,
              itemBuilder: ((context, index) {
                return Container(
                    child: Accordion(
                  headerBackgroundColor: Colors.orange,
                  // contentBackgroundColor: Colors.black,
                  paddingListBottom: 0,
                  paddingListTop: 0,
                  children: [
                    AccordionSection(
                      header: Container(
                          decoration: BoxDecoration(gradient: myGradient),
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Text('data1')),
                      content: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  color: Colors.amber,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  color: Colors.amber,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ));
              }),
            ),
          ),
        ),
      ),
    );
  }
}
