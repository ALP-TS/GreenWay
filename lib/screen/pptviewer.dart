import 'package:easy_docs_viewer/easy_docs_viewer.dart';
import 'package:flutter/material.dart';
import 'package:greenway/widgets/app_widgets.dart';

class CustomPDFViewer extends StatelessWidget {
  const CustomPDFViewer({
    super.key,
    this.url =
        "https://databackupservices.sgp1.digitaloceanspaces.com/demo/notes/(1705903305)330f15_AnsariJonesWilder_Dart.pptx",
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar('Presentation'),
      body: SizedBox.expand(child: EasyDocsViewer(url: url)),
    );
  }
}
