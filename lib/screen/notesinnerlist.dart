import 'package:flutter/material.dart';
import 'package:greenway/screen/pdflisting.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';

class noteinnerlist extends StatelessWidget {
  const noteinnerlist(
      {super.key, required this.pdf, required this.name, required this.dec});
  final dynamic pdf;
  final String name;
  final String dec;

  String _fileName(String url, int index) {
    try {
      final seg = Uri.parse(url).pathSegments;
      if (seg.isNotEmpty) return Uri.decodeComponent(seg.last);
    } catch (_) {}
    return 'File ${index + 1}';
  }

  @override
  Widget build(BuildContext context) {
    final List<String> files =
        pdf is List ? (pdf as List).map((e) => '$e').toList() : <String>[];

    return Scaffold(
      appBar: gradientAppBar(name.isEmpty ? 'Notes' : name),
      body: files.isEmpty
          ? const EmptyView(
              icon: Icons.folder_open_rounded,
              title: 'No files',
              message: 'This note doesn\'t have any files attached.',
            )
          : ListView(
              padding: const EdgeInsets.all(Brand.gutter),
              children: [
                if (dec.isNotEmpty) ...[
                  Text(dec,
                      style: const TextStyle(
                          fontSize: 14, color: Brand.textMuted, height: 1.4)),
                  const SizedBox(height: 16),
                ],
                SectionHeader('${files.length} files'),
                for (int i = 0; i < files.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Builder(builder: (context) {
                      final type = noteFileType(files[i]);
                      return AppCard(
                        padding: const EdgeInsets.all(14),
                        onTap: () => openNoteFile(context, files[i]),
                        child: Row(
                          children: [
                            IconBadge(
                              icon: noteFileIcon(type),
                              color: noteFileColor(type),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                _fileName(files[i], i),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const Icon(Icons.open_in_new_rounded,
                                size: 20, color: Brand.textMuted),
                          ],
                        ),
                      );
                    }),
                  ),
              ],
            ),
    );
  }

  bool checkFileExtension(String url, String extension) {
    return url.toLowerCase().endsWith(extension);
  }
}
