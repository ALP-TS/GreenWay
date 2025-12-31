// import 'package:flutter/material.dart';
// import 'package:mcj/carousal/caroualpage.dart';
// import 'package:mcj/others/constants.dart';
// import 'package:mcj/screen/videoplayer.dart';

// class coursedetailsdisplay extends StatelessWidget {
//   const coursedetailsdisplay({super.key});

//   // const coursedetailsdisplay.data({super.key,});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: course_indivitualpage(),
//     );
//   }
// }

// class course_indivitualpage extends StatelessWidget {
//   const course_indivitualpage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(children: [
//         CustomScrollView(slivers: [
//           const SliverAppBar(
//             floating: true,
//             backgroundColor: Colors.blue,
//             elevation: 0,
//             centerTitle: false,
//             expandedHeight: 400,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               background: course_background(),
//               stretchModes: [StretchMode.blurBackground],
//             ),
//           ),
//           SliverList(
//               delegate: SliverChildBuilderDelegate((context, index) {
//             return coursedescrption();
//           }, childCount: 1))
//         ]),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             width: double.infinity,
//             height: 100,
//             // decoration: BoxDecoration(gradient: myGradient),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.deepOrange,
//                       borderRadius: BorderRadius.circular(15)),
//                   child: TextButton.icon(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.currency_rupee,
//                         color: Colors.white,
//                       ),
//                       label: Text(
//                         orgamount ?? 'notfound',
//                         style: TextStyle(
//                           decoration: TextDecoration.lineThrough,
//                           decorationColor: Colors.black,
//                           decorationThickness: 3,
//                           fontSize: 20,
//                           color: Colors.white,
//                         ),
//                       )),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.deepOrange,
//                       borderRadius: BorderRadius.circular(15)),
//                   child: TextButton.icon(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.currency_rupee,
//                         color: Colors.white,
//                       ),
//                       label: Text(
//                         offeramount ?? 'notfound',
//                         style: TextStyle(
//                           decorationThickness: 2,
//                           fontSize: 20,
//                           color: Colors.white,
//                         ),
//                       )),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ]),
//     );
//   }
// }

// class coursedescrption extends StatelessWidget {
//   const coursedescrption({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'OverView',
//             style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
//           ),
//           Text(overview ?? ''),
//           TextButton.icon(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.timer,
//                 color: kblack,
//               ),
//               label: Text(
//                 duration ?? '',
//                 style: TextStyle(color: kblack),
//               )),
//           TextButton.icon(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.language,
//                 color: kblack,
//               ),
//               label: Text(
//                 language ?? 'not found',
//                 style: TextStyle(color: kblack),
//               )),
//           TextButton.icon(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.person_2_outlined,
//                 color: kblack,
//               ),
//               label: Text(
//                 lectures ?? 'not found',
//                 style: TextStyle(color: kblack),
//               )),
//           TextButton.icon(
//               onPressed: () {
//                 // Navigator.of(context).push(
//                 //   MaterialPageRoute(
//                 //     builder: (context) => MyVideoPlayer(
//                 //       videoUrl: '',
//                 //       Des: '',
//                 //       topicid: '',
//                 //     ),
//                 //   ),
//                 // );
//               },
//               icon: Icon(
//                 Icons.video_library_outlined,
//                 color: kblack,
//               ),
//               label: Text(
//                 'PreviewVideo',
//                 style: TextStyle(color: kblack),
//               )),
//         ],
//       ),
//     );
//   }
// }

// class course_background extends StatelessWidget {
//   const course_background({super.key});

//   @override
//   Widget build(BuildContext context) {
//     bool wascondition;
//     if (profile == '') {
//       wascondition = true;
//     } else {
//       wascondition = false;
//     }
//     return Stack(children: [
//       Column(children: [
//         Container(
//           child: Padding(
//               padding: EdgeInsets.only(top: 50),
//               child: Align(
//                   alignment: Alignment.topCenter,
//                   child: Column(children: [
//                     Text(
//                       coursename!,
//                       style: TextStyle(
//                           fontSize: 25,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w800),
//                     ),
//                     Text(
//                       subcoursename ?? '',
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.white,
//                       ),
//                     )
//                   ]))),
//           width: double.infinity,
//           height: 437,
//           decoration: BoxDecoration(gradient: myGradient),
//         ),
//       ]),
//       Padding(
//         padding: EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 150),
//         child: Container(
//           decoration: BoxDecoration(
//               color: Colors.black, borderRadius: BorderRadius.circular(30)),
//           width: double.infinity,
//           child: wascondition
//               ? ClipRRect(
//                   borderRadius: BorderRadius.circular(30),
//                   child: Image.asset(
//                     'assets/course.jpg',
//                     fit: BoxFit.cover,
//                   ))
//               : ClipRRect(
//                   borderRadius: BorderRadius.circular(30),
//                   child: Image.network(
//                     profile ?? 'assets/course.jpg',
//                     fit: BoxFit.cover,
//                   )),
//         ),
//       )
//     ]);
//   }
// }
