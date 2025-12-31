// import 'package:flutter/material.dart';
// import 'package:easy_docs_viewer/lib/easy_docs_viewer.dart';

// class CustomPDFViewer extends StatelessWidget {
//   const CustomPDFViewer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(
//       height: 150,
//       width: 150,
//       child: EasyDocsViewer(
//         url:"https://scholar.harvard.edu/files/torman_personal/files/samplepptx.pptx",

//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_office/flutter_office.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_office/flutter_office.dart';

// class PdfPage extends StatefulWidget {
//   final String fileUrl;

//   PdfPage({Key? key, required this.fileUrl}) : super(key: key);

//   @override
//   _PdfPageState createState() => _PdfPageState();
// }

// class _PdfPageState extends State<PdfPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('File Viewer'),
//       ),
//       body: Container(
//         child: FlutterOffice(
//           filePath: widget.fileUrl,
//           fileType: FileType
//               .ppt, // Specify the file type (ppt, pptx, doc, docx, etc.)
//           // other properties...
//         ),
//       ),
//     );
//   }
// }
///Dart 2.17
/// Dart
/// Dart 2.17
import 'package:easy_docs_viewer/easy_docs_viewer.dart';
// import 'package:easy_docs_viewer/lib/easy_docs_viewer.dart';
import 'package:flutter/material.dart';

class CustomPDFViewer extends StatelessWidget {
  const CustomPDFViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 150,
      width: 150,
      child: EasyDocsViewer(
        url:
            "https://databackupservices.sgp1.digitaloceanspaces.com/demo/notes/(1705903305)330f15_AnsariJonesWilder_Dart.pptx",
        // "https://scholar.harvard.edu/files/torman_personal/files/samplepptx.pptx",
      ),
    );
  }
}
