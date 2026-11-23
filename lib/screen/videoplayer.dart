import 'package:flutter/material.dart';
import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/screen/videolisting.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MyVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String Des;
  final String date;
  final String topicid;

  const MyVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.Des,
    required this.topicid,
    required this.date,
  });

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late Future<List<Map<String, dynamic>>> _related;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Brand.primary,
        handleColor: Brand.primary,
        bufferedColor: Colors.white38,
        backgroundColor: Colors.white24,
      ),
      errorBuilder: (context, message) => const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded, color: Colors.white70, size: 40),
              SizedBox(height: 8),
              Text('This video can\'t be played right now.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
    _related = getallvideos(widget.topicid);
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  String get _date {
    final v = clean(widget.date);
    if (v.isEmpty || int.tryParse(v) == null) return v;
    return timeconvert(v);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar('Video'),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Chewie(controller: _chewieController),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(Brand.gutter),
              children: [
                Text(
                  clean(widget.Des, 'Untitled video'),
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w800, height: 1.3),
                ),
                if (_date.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined,
                          size: 14, color: Brand.textMuted),
                      const SizedBox(width: 6),
                      Text(_date,
                          style: const TextStyle(
                              fontSize: 13, color: Brand.textMuted)),
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                const SectionHeader('Related videos'),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _related,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: LoadingView(),
                      );
                    }
                    final data = snapshot.data ?? const [];
                    if (data.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('No other videos in this topic.',
                            style: TextStyle(color: Brand.textMuted)),
                      );
                    }
                    return Column(
                      children: [
                        for (final subject in data)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: VideoTile(
                              subject: subject,
                              playing:
                                  '${subject['name']}' == widget.videoUrl,
                              onTap: () {
                                if ('${subject['name']}' == widget.videoUrl) {
                                  return;
                                }
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyVideoPlayer(
                                      videoUrl: '${subject['name']}',
                                      Des: '${subject['videoname']}',
                                      topicid: widget.topicid,
                                      date: '${subject['created_at']}',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
