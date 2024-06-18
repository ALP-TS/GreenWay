import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:greenway_lms/splashscreen/widgets/loader.dart';

class pdfpage extends StatefulWidget {
  final String pdfUrl;

  pdfpage({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  _pdfpageState createState() => _pdfpageState();
}

class _pdfpageState extends State<pdfpage> {
  late PDFDocument _pdfDocument;
  int _currentPage = 1;
  bool isvisible = true;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    final document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {
      isvisible = false;
      _pdfDocument = document;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: isvisible
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: PDFViewer(
                    showPicker: false,
                    // controller: PageController(),
                    document: _pdfDocument,
                    // onPageChanged: (page) {
                    //   setState(() {
                    //     _currentPage = page;
                    //   });
                    // },
                  ),
                ),
                // Container(
                //   color: Colors.blue,
                //   padding: EdgeInsets.symmetric(vertical: 8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         'Page $_currentPage',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 18.0,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
    );
  }
}
