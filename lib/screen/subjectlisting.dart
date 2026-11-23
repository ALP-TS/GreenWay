import 'package:flutter/material.dart';

import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/data.dart/getsubjectmodel/datum.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/screen/topiclisting.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';

class subjectlisting extends StatelessWidget {
  const subjectlisting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar('Subjects'),
      body: AsyncView<List<Datum>>(
        load: () => getsubjects(classId ?? ''),
        emptyIcon: Icons.menu_book_outlined,
        emptyTitle: 'No subjects yet',
        emptyMessage:
            'Subjects for your course will appear here once they are added.',
        builder: (context, data, reload) {
          return RefreshIndicator(
            onRefresh: reload,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(Brand.gutter),
              itemCount: data.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (BuildContext context, int index) {
                final datum = data[index];
                final count = datum.tCount ?? 0;
                return AppCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => topiclisting(
                          subid: '${datum.subjectId}',
                          title: clean(datum.name, 'Topics'),
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      IconBadge(
                        icon: Icons.auto_stories_rounded,
                        color: _palette[index % _palette.length],
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              clean(datum.name, 'Untitled subject'),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$count ${count == 1 ? 'topic' : 'topics'}',
                              style: const TextStyle(
                                  fontSize: 13, color: Brand.textMuted),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded,
                          color: Brand.textMuted),
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

const _palette = [
  Brand.primary,
  Brand.accent,
  Brand.warning,
  Color(0xFF7C3AED),
  Color(0xFFDB2777),
];
