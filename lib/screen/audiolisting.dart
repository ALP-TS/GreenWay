import 'package:flutter/material.dart';
import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/screen/audioplayer.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';

class audiolisting extends StatelessWidget {
  const audiolisting({super.key, required this.topicid});
  final String topicid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar('Audio'),
      body: AsyncView<List<Map<String, dynamic>>>(
        load: () => getallaudio(topicid),
        emptyIcon: Icons.headphones_outlined,
        emptyTitle: 'No audio yet',
        emptyMessage: 'Audio lessons for this topic will appear here.',
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
                final title = clean(subject['file_name'], 'Audio ${index + 1}');
                return AppCard(
                  padding: const EdgeInsets.all(14),
                  onTap: () {
                    if (userId != null) {
                      audioseen(userId!, '${subject['audio_id']}');
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            audioplayer(url: '${subject['name']}', title: title),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      const IconBadge(
                          icon: Icons.headphones_rounded,
                          color: Brand.accent,
                          size: 52),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              height: 1.3),
                        ),
                      ),
                      const Icon(Icons.play_circle_fill_rounded,
                          color: Brand.accent, size: 32),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class datanotfound extends StatelessWidget {
  const datanotfound({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyView(title: 'No data found');
  }
}
