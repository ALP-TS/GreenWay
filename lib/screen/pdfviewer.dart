import 'package:flutter/material.dart';
import 'package:greenway/widgets/app_widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdfpage extends StatefulWidget {
  final String pdfUrl;
  const pdfpage({super.key, required this.pdfUrl});

  @override
  State<pdfpage> createState() => _pdfpageState();
}

class _pdfpageState extends State<pdfpage> {
  bool _failed = false;
  int _attempt = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar('Document'),
      body: _failed
          ? ErrorView(
              title: 'Couldn\'t open document',
              message: 'The file may be unavailable or your connection dropped.',
              onRetry: () => setState(() {
                _failed = false;
                _attempt++;
              }),
            )
          : SfPdfViewer.network(
              widget.pdfUrl,
              key: ValueKey(_attempt),
              onDocumentLoadFailed: (_) {
                if (mounted) setState(() => _failed = true);
              },
            ),
    );
  }
}
