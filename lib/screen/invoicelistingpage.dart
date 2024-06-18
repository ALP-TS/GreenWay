// import 'package:flutter/material.dart';
// import 'package:lms/dashboard/dashboard.dart';

// class Invoicelist extends StatelessWidget {
//   const Invoicelist({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: ListView.builder(
//           itemCount: 50, // Specify the number of items in the list
//           itemBuilder: (BuildContext context, int index) {
//             // Build each item in the list
//             return Padding(
//               padding: EdgeInsets.all(15),
//               child: Container(
//                 // color: Colors.amber,
//                 height: 50,
//                 width: double.infinity,
//                 child: Container(
//                   decoration: BoxDecoration(color: Colors.white54),
//                   child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Sujith'),
//                             Text('March 1 , 2024'),
//                           ],
//                         ),
//                         Text(
//                           'Completed',
//                           style: TextStyle(color: Colors.green),
//                         ),
//                         Text(
//                           '40000',
//                           style: TextStyle(fontSize: 20, color: Colors.green),
//                         )
//                       ]),
//                 ),
//               ),
//             );
//             // ListTile(
//             //   title: Text('index'), // Display the item text
//             //   onTap: () {
//             //     // Define what happens when the item is tapped
//             //     // print('Tapped on ${items[index]}');
//             //   },
//             // );
//           },
//         ),
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   // Define a list of items
//   final List<String> items = List.generate(100, (index) => 'Item $index');

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('ListView Builder Example'),
//         ),
//         body: ListView.builder(
//           itemCount: items.length, // Specify the number of items in the list
//           itemBuilder: (BuildContext context, int index) {
//             // Build each item in the list
//             return ListTile(
//               title: Text(items[index]), // Display the item text
//               onTap: () {
//                 // Define what happens when the item is tapped
//                 print('Tapped on ${items[index]}');
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:greenway_lms/colors.dart';
import 'package:greenway_lms/dashboard/dashboard.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/splashscreen/widgets/loader.dart';

class Invoicelist extends StatelessWidget {
  const Invoicelist({super.key});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'INVOICE',
        style: TextStyle(color: Colors.white),
      )),
      body: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: invoicelist(
              userId!), // The future to which this builder is connected
          builder: (context, snapshot) {
            // Check the connection state of the future
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While the future is still running, show a loading indicator
              return Center(child: loader());
            } else if (snapshot.hasError) {
              // If an error occurs, display an error message
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<Map<String, dynamic>> invoicedata = snapshot.data!;
              // If the future completes successfully, display the data
              return ListView.builder(
                itemCount: invoicedata
                    .length, // Specify the number of items in the list
                itemBuilder: (BuildContext context, int index) {
                  // Build each item in the list
                  bool paidstatus = false;
                  if (invoicedata[index]['status'] == 'paid') {
                    paidstatus = true;
                  }
                  return Padding(
                    padding: EdgeInsets.all(_width * 0.04),
                    child: Container(
                      height: _height * 0.25,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 222, 219, 219)),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.all(_width * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        invoicedata[index]['fee_name'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      // Container()
                                    ),
                                  ),
                                  Container(
                                    child: Row(children: [
                                      Icon(
                                        Icons.circle,
                                        size: 10,
                                        color: paidstatus
                                            ? Colors.green
                                            : Colors.yellow,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(paidstatus
                                              ? 'Completed'
                                              : 'Pending'))
                                    ]),
                                  )
                                ]),
                            Text(
                              '₹${invoicedata[index]['amount']}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w900),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('From Date: '),
                                  Text(timeconvert(
                                      invoicedata[index]['from_date']))
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('To Date: '),
                                  Text(timeconvert(
                                      invoicedata[index]['to_date']))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  //
                  //
                  // Padding(
                  //   padding: EdgeInsets.all(15),
                  //   child: Container(
                  //     // color: Colors.amber,
                  //     height: 50,
                  //     width: double.infinity,
                  //     child: Container(
                  //       decoration: BoxDecoration(color: Colors.white54),
                  //       child: Row(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text('${invoicedata[index]['fee_name']}'),
                  //                 Text('March 1 , 2024'),
                  //               ],
                  //             ),
                  //             Text(
                  //               'Completed',
                  //               style: TextStyle(color: Colors.green),
                  //             ),
                  //             Text(
                  //               '40000',
                  //               style: TextStyle(
                  //                   fontSize: 20, color: Colors.green),
                  //             )
                  //           ]),
                  //     ),
                  //   ),
                  // );
                  // ListTile(
                  //   title: Text('index'), // Display the item text
                  //   onTap: () {
                  //     // Define what happens when the item is tapped
                  //     // print('Tapped on ${items[index]}');
                  //   },
                  // );
                },
              );
            } else {
              return Text('data');
            }
          },
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

