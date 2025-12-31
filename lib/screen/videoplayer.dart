import 'package:flutter/material.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MyVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String Des;
  final String date;
  final String topicid;

  const MyVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.Des,
    required this.topicid,
    required this.date,
    // required this.name
  }) : super(key: key);

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9, // Adjust as needed
      autoPlay: true,
      looping: true,
      // Other customization options...
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
      body: SafeArea(
        child: Container(
          // height: 500,
          // color: Colors.amber,
          child: FutureBuilder<List<Map<String, dynamic>>?>(
            future: getallvideos(widget.topicid),
            // getallcourse(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // Use the fetched data as needed

                List<Map<String, dynamic>> data = snapshot.data!;
                // List image = data.toList();

                // Display the data in a Container
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      centerTitle: false,
                      expandedHeight: MediaQuery.of(context).size.height * 0.45,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                          background: Column(children: [
                            Container(
                              child: Center(
                                child: Text(
                                  'VideoPlayer',
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                              // color: Colors.amber,
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            VideoPlayerScreen(
                              chewieController: _chewieController,
                              widget: widget,
                              // name: widget.date,
                              date: widget.date,
                            ),
                          ]),
                          stretchModes: [StretchMode.zoomBackground]),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Related Videos',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              for (Map<String, dynamic> subject in data)
                                GestureDetector(
                                  onTap: () async {},
                                  child: Column(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                width: 3,
                                                color: Colors.orange)),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyVideoPlayer(
                                                      videoUrl:
                                                          '${subject['name']}',
                                                      Des:
                                                          '${subject['videoname']}',
                                                      topicid: widget.topicid,
                                                      date:
                                                          '${subject['created_at']}',
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,

                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey),
                                                top: BorderSide(
                                                    color: Colors.grey),
                                                right: BorderSide(
                                                    color: Colors.grey)
                                                // color: Colors.black, // Border color
                                                ),
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                topRight: Radius.circular(
                                                    10)), // Border radius
                                          ),
                                          height: _height * 0.15,
                                          width: double.infinity,
                                          child: Row(children: [
                                            Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Column(children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        child: Text(
                                                          '${subject['videoname']}',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                      //  Text(
                                                      //       '${subject['videoname']}'),
                                                      // color: Colors.amber,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2),
                                                      child: Divider(
                                                          color: Colors.grey)),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                        child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(timeconvert(
                                                          '${subject['created_at']}')),
                                                    )),
                                                  )
                                                ]),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                  child: Icon(
                                                Icons.play_circle_outline,
                                                size: 80,
                                                color: Colors.blue,
                                                // size: double.infinity,
                                              )
                                                  // Image.asset(
                                                  //     'assets/defaultvideoicon.png'),
                                                  ),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ]),
                                ),
                            ],
                          ),
                        );
                      }, childCount: 1),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  // final String name;
  final String date;
  const VideoPlayerScreen({
    Key? key,
    required this.chewieController,
    // required this.name,
    // required this.widget,
    required this.date,
    required this.widget,
    // required this.widget,
  }) : super(key: key);

  final ChewieController chewieController;
  final MyVideoPlayer widget;

  @override
  Widget build(BuildContext context) {
    chewieController.setLooping(false);
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Chewie(
              controller: chewieController,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Text(
                widget.Des,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.04,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(timeconvert(widget.date)),
                  // Text(widget.Des),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
