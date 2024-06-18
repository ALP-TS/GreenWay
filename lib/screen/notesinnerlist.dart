// import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:flutter/material.dart';
// import 'package:rn_plus/dashboard/dashboard.dart';
import 'package:greenway_lms/screen/imageviewer.dart';
import 'package:greenway_lms/screen/pdfviewer.dart';

class noteinnerlist extends StatelessWidget {
  const noteinnerlist(
      {super.key, required this.pdf, required this.name, required this.dec});
  final dynamic pdf;
  final String name;
  final String dec;
  // final Map<String, dynamic> subject;

  @override
  Widget build(BuildContext context) {
    int l = pdf.length;
    print(pdf);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: const Color.fromARGB(255, 207, 203, 203), width: 2)),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * (0.15 * l),
          child: Column(children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.01,
                  decoration: BoxDecoration(
                      // color: Colors.amber,
                      // color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          dec,
                          style: TextStyle(fontSize: 20),
                        )
                      ]),
                ),
              ),
            ),
            Divider(
                color: const Color.fromARGB(255, 207, 203, 203), thickness: 2),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        // color: Colors.black,
                        borderRadius: BorderRadius.circular(15)),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Display 2 items in a row
                      ),
                      itemCount: pdf.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isPdf = checkFileExtension(pdf[index], '.pdf');
                        bool isPng = checkFileExtension(pdf[index], '.png');
                        bool isPPt = checkFileExtension(pdf[index], '.ppt');
                        bool isJpg = checkFileExtension(pdf[index], '.jpg');
                        bool isJpeg = checkFileExtension(pdf[index], '.jpeg');
                        return GestureDetector(
                          onTap: () {
                            if (isPdf) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => pdfpage(
                                          pdfUrl: pdf[index],

                                          // 'https://databackupservices.sgp1.digitaloceanspaces.com/demo/notes/(1632117680)data-interpretation-concepts-and-formulas-splessons.pdf'
                                          // '${subject['file_name']}', /////////////////////////////////////////////
                                        )),
                              );
                            }
                            if (isPng || isJpg || isJpeg) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => imgviewer(
                                          imgurl: pdf[index],
                                          // 'https://databackupservices.sgp1.digitaloceanspaces.com/demo/notes/(1632117680)data-interpretation-concepts-and-formulas-splessons.pdf'
                                          // '${subject['file_name']}', /////////////////////////////////////////////
                                        )),
                              );
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Card(
                              // color: Colors.orange,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: isPdf
                                      ? Image.asset(
                                          'assets/pdfdeafaulticon.png')
                                      : isPng || isJpeg || isJpg
                                          ? Image.asset(
                                              'assets/defaulticonjpg.png')
                                          : isPPt
                                              ? Image.asset(
                                                  'assets/pptdefault icon.jpeg')
                                              : Image.asset(
                                                  'assets/image not found.png') /////////////////////////////////////////////
                                  ),
                            ),
                          ),
                        );
                        // GestureDetector(
                        //   onTap: () {
                        //     if (isPdf) {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => PDFViewer(
                        //                   pdfUrl: pdf[index],
                        //                   // 'https://databackupservices.sgp1.digitaloceanspaces.com/demo/notes/(1632117680)data-interpretation-concepts-and-formulas-splessons.pdf'
                        //                   // '${subject['file_name']}', /////////////////////////////////////////////
                        //                 )),
                        //       );
                        //     }
                        //     if (isPng || isJpg || isJpeg) {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => imgviewer(
                        //                   imgurl: pdf[index],
                        //                   // 'https://databackupservices.sgp1.digitaloceanspaces.com/demo/notes/(1632117680)data-interpretation-concepts-and-formulas-splessons.pdf'
                        //                   // '${subject['file_name']}', /////////////////////////////////////////////
                        //                 )),
                        //       );
                        //     }
                        //   },
                        //   child: Container(
                        //     width: double.infinity,
                        //     height: 150,
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(15),
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.black.withOpacity(0.2),
                        //             spreadRadius: 5,
                        //             blurRadius: 7,
                        //             offset: Offset(0, 3),
                        //           ),
                        //         ]),
                        //     child: Row(children: [
                        //       Expanded(
                        //         flex: 1,
                        //         child: Padding(
                        //           padding: EdgeInsets.symmetric(horizontal: 10),
                        //           child: Container(
                        //             decoration: BoxDecoration(
                        //                 // color: Colors.black,
                        //                 borderRadius: BorderRadius.circular(15)),
                        //             // height: 150,
                        //             child: ClipRRect(
                        //                 borderRadius: BorderRadius.circular(15),
                        //                 child: isPdf
                        //                     ? Image.asset('assets/pdfdeafaulticon.png')
                        //                     : isPng || isJpeg || isJpg
                        //                         ? Image.asset('assets/defaulticonjpg.png')
                        //                         : isPPt
                        //                             ? Image.asset(
                        //                                 'assets/pptdefault icon.jpeg')
                        //                             : Image.asset(
                        //                                 'assets/image not found.png') /////////////////////////////////////////////
                        //                 ),
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(
                        //           flex: 2,
                        //           child: Container(
                        //             child: Column(
                        //               mainAxisAlignment: MainAxisAlignment.center,
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 // Text('${subject['file_name']}'),
                        //                 Text(pdf[index])
                        //               ],
                        //             ),
                        //           ))
                        //     ]),
                        //   ),
                        // ),
                      },
                    ),
                  ),
                ))
          ]),
        ),
      )),
    );
  }

  bool checkFileExtension(String url, String extension) {
    String lowercaseUrl = url.toLowerCase();
    return lowercaseUrl.endsWith(extension);
  }
}
