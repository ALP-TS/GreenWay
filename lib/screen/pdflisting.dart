import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greenway/data.dart/apicalls.dart';

import 'package:greenway/screen/imageviewer.dart';
import 'package:greenway/screen/notesinnerlist.dart';
import 'package:greenway/screen/pdfviewer.dart';
import 'package:greenway/screen/pptviewer.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';

class notelisting extends StatelessWidget {
  const notelisting({super.key, required this.topicid});
  final String topicid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar('Notes'),
      body: AsyncView<List<Map<String, dynamic>>>(
        load: () => getallpdf(topicid),
        emptyIcon: Icons.description_outlined,
        emptyTitle: 'No notes yet',
        emptyMessage: 'Notes for this topic will appear here once uploaded.',
        builder: (context, data, reload) {
          return RefreshIndicator(
            onRefresh: reload,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(Brand.gutter),
              itemCount: data.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) =>
                  pdflistcard(subject: data[index]),
            ),
          );
        },
      ),
    );
  }
}

/// File-type helpers shared by the notes screens.
enum NoteFileType { pdf, image, ppt, unknown }

NoteFileType noteFileType(String url) {
  final u = url.toLowerCase().split('?').first;
  if (u.endsWith('.pdf')) return NoteFileType.pdf;
  if (u.endsWith('.png') || u.endsWith('.jpg') || u.endsWith('.jpeg')) {
    return NoteFileType.image;
  }
  if (u.endsWith('.ppt') || u.endsWith('.pptx')) return NoteFileType.ppt;
  return NoteFileType.unknown;
}

IconData noteFileIcon(NoteFileType t) {
  switch (t) {
    case NoteFileType.pdf:
      return Icons.picture_as_pdf_rounded;
    case NoteFileType.image:
      return Icons.image_rounded;
    case NoteFileType.ppt:
      return Icons.slideshow_rounded;
    case NoteFileType.unknown:
      return Icons.insert_drive_file_rounded;
  }
}

Color noteFileColor(NoteFileType t) {
  switch (t) {
    case NoteFileType.pdf:
      return Brand.danger;
    case NoteFileType.image:
      return Brand.accent;
    case NoteFileType.ppt:
      return Brand.warning;
    case NoteFileType.unknown:
      return Brand.textMuted;
  }
}

/// Opens a single note file in the right viewer.
void openNoteFile(BuildContext context, String url) {
  switch (noteFileType(url)) {
    case NoteFileType.pdf:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => pdfpage(pdfUrl: url)));
      break;
    case NoteFileType.image:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => imgviewer(imgurl: url)));
      break;
    case NoteFileType.ppt:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CustomPDFViewer(url: url)));
      break;
    case NoteFileType.unknown:
      showAppSnack(context, 'This file type can\'t be opened in the app.',
          error: true);
  }
}

class pdflistcard extends StatelessWidget {
  const pdflistcard({
    super.key,
    required this.subject,
  });

  final Map<String, dynamic> subject;

  /// `file_name` is usually a JSON array of URLs, but may be a plain string.
  List<String> _files() {
    final raw = subject['file_name'];
    if (raw == null) return [];
    if (raw is List) return raw.map((e) => '$e').toList();
    try {
      final decoded = jsonDecode('$raw');
      if (decoded is List) {
        return decoded
            .map((e) => '$e'.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      }
      return ['$decoded'];
    } catch (_) {
      final s = '$raw'.trim();
      return s.isEmpty ? [] : [s];
    }
  }

  @override
  Widget build(BuildContext context) {
    final files = _files();
    final multiple = files.length > 1;
    final name = clean(subject['title'], 'Untitled note');
    final dec = clean(subject['descp']);
    final type =
        files.isEmpty ? NoteFileType.unknown : noteFileType(files.first);
    final color = multiple ? Brand.primary : noteFileColor(type);

    return AppCard(
      padding: const EdgeInsets.all(14),
      onTap: () {
        if (files.isEmpty) {
          showAppSnack(context, 'No file attached to this note.', error: true);
        } else if (multiple) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  noteinnerlist(pdf: files, name: name, dec: dec),
            ),
          );
        } else {
          openNoteFile(context, files.first);
        }
      },
      child: Row(
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: multiple
                ? Container(
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${files.length}',
                              style: TextStyle(
                                  color: color,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800)),
                          Text('files',
                              style: TextStyle(color: color, fontSize: 11)),
                        ],
                      ),
                    ),
                  )
                : IconBadge(icon: noteFileIcon(type), color: color, size: 56),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700, height: 1.3),
                ),
                if (dec.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    dec,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 13, color: Brand.textMuted, height: 1.35),
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

  bool checkFileExtension(String url, String extension) {
    return url.toLowerCase().endsWith(extension);
  }
}
