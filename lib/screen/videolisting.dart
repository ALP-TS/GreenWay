import 'package:flutter/material.dart';
import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/screen/videoplayer.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';

class Videolisting extends StatelessWidget {
  const Videolisting({super.key, required this.topicid});
  final String topicid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar('Videos'),
      body: AsyncView<List<Map<String, dynamic>>>(
        load: () => getallvideos(topicid),
        emptyIcon: Icons.video_library_outlined,
        emptyTitle: 'No videos yet',
        emptyMessage: 'Videos for this topic will appear here once uploaded.',
        builder: (context, data, reload) {
          return RefreshIndicator(
            onRefresh: reload,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(Brand.gutter),
              itemCount: data.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final subject = data[index];
                return VideoTile(
                  subject: subject,
                  onTap: () async {
                    if (userId != null) {
                      videoseen(userId!, '${subject['video_id']}');
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyVideoPlayer(
                          videoUrl: '${subject['name']}',
                          Des: '${subject['videoname']}',
                          topicid: topicid,
                          date: '${subject['created_at']}',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// A single row in a video list. Shared with the player's "Related videos".
class VideoTile extends StatelessWidget {
  const VideoTile({
    super.key,
    required this.subject,
    required this.onTap,
    this.playing = false,
  });

  final Map<String, dynamic> subject;
  final VoidCallback onTap;
  final bool playing;

  String _date(dynamic raw) {
    final v = clean(raw);
    if (v.isEmpty || int.tryParse(v) == null) return v;
    return timeconvert(v);
  }

  @override
  Widget build(BuildContext context) {
    final date = _date(subject['created_at']);
    return AppCard(
      onTap: onTap,
      color: playing ? Brand.primaryLight : Brand.surface,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: Brand.gradient,
              borderRadius: BorderRadius.circular(Brand.radiusSm + 2),
            ),
            child: Icon(
              playing ? Icons.equalizer_rounded : Icons.play_arrow_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clean(subject['videoname'], 'Untitled video'),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700, height: 1.3),
                ),
                if (date.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined,
                          size: 13, color: Brand.textMuted),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(date,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, color: Brand.textMuted)),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Brand.textMuted),
        ],
      ),
    );
  }
}
