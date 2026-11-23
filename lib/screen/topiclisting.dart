import 'package:flutter/material.dart';

import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/data.dart/topiclistingmodel/datum.dart';
import 'package:greenway/screen/audiolisting.dart';
import 'package:greenway/screen/pdflisting.dart';
import 'package:greenway/screen/videolisting.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';

class topiclisting extends StatelessWidget {
  const topiclisting({super.key, required this.subid, this.title = 'Topics'});
  final String subid;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar(title),
      body: AsyncView<List<Datumtopic>>(
        load: () => gettopic(subid),
        errorAsEmpty: true,
        emptyIcon: Icons.topic_outlined,
        emptyTitle: 'No topics yet',
        emptyMessage: 'Topics for this subject will appear here once added.',
        builder: (context, datatopic, reload) {
          return RefreshIndicator(
            onRefresh: reload,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(Brand.gutter),
              itemCount: datatopic.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) =>
                  _TopicCard(topic: datatopic[index], number: index + 1),
            ),
          );
        },
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.topic, required this.number});
  final Datumtopic topic;
  final int number;

  @override
  Widget build(BuildContext context) {
    final chapter = clean(topic.chapter, 'Chapter $number');
    final topics = clean(topic.topics);
    final description = clean(topic.description);
    final topicId = '${topic.topicId}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Brand.radius),
        border: Border.all(color: Brand.border),
        boxShadow: Brand.softShadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: Brand.primaryLight,
            child: Text(
              '$number',
              style: const TextStyle(
                  color: Brand.primary, fontWeight: FontWeight.w700),
            ),
          ),
          title: Text(
            chapter,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          subtitle: topics.isEmpty
              ? null
              : Text(
                  topics,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      const TextStyle(fontSize: 13, color: Brand.textMuted),
                ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (topics.isNotEmpty) ...[
              const Text('Topics',
                  style: TextStyle(
                      fontSize: 12,
                      color: Brand.textMuted,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(topics, style: const TextStyle(fontSize: 14, height: 1.4)),
              const SizedBox(height: 10),
            ],
            if (description.isNotEmpty) ...[
              const Text('Description',
                  style: TextStyle(
                      fontSize: 12,
                      color: Brand.textMuted,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(description,
                  style: const TextStyle(fontSize: 14, height: 1.4)),
              const SizedBox(height: 14),
            ],
            Row(
              children: [
                _ResourceButton(
                  icon: Icons.play_circle_outline_rounded,
                  label: 'Videos',
                  color: Brand.primary,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Videolisting(topicid: topicId)),
                  ),
                ),
                const SizedBox(width: 10),
                _ResourceButton(
                  icon: Icons.description_outlined,
                  label: 'Notes',
                  color: Brand.warning,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => notelisting(topicid: topicId)),
                  ),
                ),
                const SizedBox(width: 10),
                _ResourceButton(
                  icon: Icons.headphones_rounded,
                  label: 'Audio',
                  color: Brand.accent,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => audiolisting(topicid: topicId)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ResourceButton extends StatelessWidget {
  const _ResourceButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Brand.radiusSm),
        child: InkWell(
          borderRadius: BorderRadius.circular(Brand.radiusSm),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(label,
                      style: TextStyle(
                          color: color,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
