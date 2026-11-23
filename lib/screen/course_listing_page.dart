
import 'package:flutter/material.dart';
import 'package:greenway/dashboard/dashboard.dart';
import 'package:greenway/dashboard/widget/bottomnavigationbar.dart';
import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/loginpage/loginpage.dart';
// ignore: depend_on_referenced_packages
import 'package:greenway/others/constants.dart';
import 'package:greenway/screen/coursedetailsdisplayscreen.dart';
import 'package:greenway/screen/courselist_categeory_list.dart';
import 'package:greenway/screen/newcoursedetailpage.dart';
import 'package:greenway/screen/searchresult.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';

class course_listing_page extends StatefulWidget {
  const course_listing_page({super.key});

  @override
  State<course_listing_page> createState() => _course_listing_pageState();
}

class _course_listing_pageState extends State<course_listing_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.0),
        child: AppBar(
            flexibleSpace: Container(
          height: 50,
          decoration: BoxDecoration(gradient: myGradient),
        )),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const SliverAppBar(
                  elevation: 0,
                  centerTitle: false,
                  expandedHeight: 625,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      background: customslider1(),
                      stretchModes: [StretchMode.blurBackground]),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                }, childCount: 1))
              ],
            ),
            Container(
              width: double.infinity,
              height: 155,
              decoration: BoxDecoration(gradient: myGradient),
              child: const headingpart(),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class customslider1 extends StatelessWidget {
  const customslider1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: 380,
          ),
          const searchbarcontainer(),
          const category_container(),
        ]),
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blueGrey.withOpacity(0.2)),
            width: 150,
            height: 30,
            child: Center(
              child: Text('FEATURED',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        CourseList()
      ]),
    );
  }
}

class searchbarcontainer extends StatelessWidget {
  const searchbarcontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 210,
      decoration: BoxDecoration(
        gradient: myGradient,
      ),
    );
  }
}

class headingpart extends StatelessWidget {
  const headingpart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool iscondition;
    if (rememberUser == true) {
      iscondition = true;
    } else {
      iscondition = false;
    }

    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              child: iscondition
                  ? Row(children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => navigationbar()),
                            );
                          },
                          child: CircleAvatar()),
                      const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'hello ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          )),
                    ])
                  : Row(
                      children: [
                        TextButton.icon(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            icon: Icon(
                              Icons.power_settings_new,
                              size: 30,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ))
                      ],
                    )),
          Image.asset(
            'assets/Rnlogo-removebg-preview (3).png',
            width: 50,
            height: 50,
          ),
        ]),
      ]),
    );
  }
}

class category_container extends StatelessWidget {
  const category_container({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 15,
      right: 15,
      top: 156,
      child: Container(
          constraints: BoxConstraints(maxHeight: 200, minHeight: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Color of the shadow
                spreadRadius: 5, // Spread radius
                blurRadius: 7, // Blur radius
                offset: Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          width: double.infinity,
          height: 200,
          child: FutureBuilder<List<String>>(
              future: coursecategory(),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot1.hasError) {
                  return Center(
                      child: Column(children: [
                    Text('Error: ${snapshot1.error}'),
                    Text('its a server error')
                  ]));
                } else if (snapshot1.hasData) {
                  List<String> category = snapshot1.data as List<String>;
                  print(category.length);
                  int length;
                  if (category.length < 4) {
                    length = category.length;
                  } else {
                    length = 4;
                  }
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: GridView.builder(
                      addRepaintBoundaries: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: length, // Number of icons in each row
                        crossAxisSpacing: 8.0, // Spacing between columns
                        mainAxisSpacing: 8.0, // Spacing between rows
                      ),
                      itemCount: category.length, // Total number of icons
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => course_category_list(
                                        label: category[index],
                                      )),
                            );
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/category.png'),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    category[index],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ); // Replace with your icon widget
                      },
                    ),
                  );
                  ;
                } else {
                  return Center(
                    child: Text('data'),
                  );
                }
              })
          ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CourseList extends StatefulWidget {
  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: randomcourse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Column(children: [
              Text('Error: ${snapshot.error}'),
              Text('its a server error')
            ]));
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> courses =
                snapshot.data as List<Map<String, dynamic>>;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(courses.length, (index) {
                  return CourseCard(courseData: courses[index]);
                }),
              ),
            );
          } else {
            return Center(
              child: Text('data'),
            );
          }
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> courseData;

  CourseCard({required this.courseData});

  @override
  Widget build(BuildContext context) {
    bool imagecondition;
    if (courseData['profile'] == '') {
      imagecondition = true;
    } else {
      imagecondition = false;
    }
    return Container(
      width: 200,
      height: 200,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () async {
            print('tapped');
            courseid = {courseData['site_courseid' ?? '']}.toList();
            final _result = await courseindivitual(courseid!);
            print(_result?.status);
            print('123');
            if (_result?.status == 'success') {
              print(_result?.message);
              print(_result?.data?.course);
              coursename = _result?.data?.course;
              subcoursename = _result?.data?.subName;
              orgamount = _result?.data?.orgAmount;
              offeramount = _result?.data?.offerAmount;
              profile = _result?.data?.profile;
              overview = _result?.data?.overview;
              duration = _result?.data?.duration;
              previewvideo = _result?.data?.previewVideo;
              lectures = _result?.data?.lectures;
              language = _result?.data?.language;
              requirements = _result?.data?.requirements;
              student = _result?.data?.students;
              specification = _result?.data?.specifications;
              print(specification);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => coursedetailpage()),
              );
            }
          },
          child: Card(
            elevation: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(children: [
                imagecondition
                    ? Image.asset('assets/default image.png')
                    : Image.network(
                        courseData['profile'] ?? '',
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                      ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        courseData['course'] ?? '',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                    )),
                    height: 50,
                    color: Colors.black.withOpacity(0.3),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class allcourselister extends StatefulWidget {
  final List<String> categorydata;

  const allcourselister({
    super.key,
    required this.categorydata,
  });

  @override
  State<allcourselister> createState() => _allcourselisterState();
}

class _allcourselisterState extends State<allcourselister> {
  bool alllist = true;
  String? name;
  int? id;
  late Future<List<Map<String, dynamic>>> _future;
  String? _openingId;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _future = alllist ? getallcourse() : categorycourse(name);
  }

  void _select(int? index) {
    setState(() {
      id = index;
      alllist = index == null;
      name = index == null ? null : widget.categorydata[index];
      _load();
    });
  }

  Future<void> _openCourse(Map<String, dynamic> subject) async {
    if (_openingId != null) return;
    final cid = '${subject['site_courseid']}';
    setState(() => _openingId = cid);
    try {
      courseid = {subject['site_courseid']}.toList();
      final result = await courseindivitual(courseid!);
      if (!mounted) return;
      if (result?.status == 'success') {
        coursename = result?.data?.course;
        subcoursename = result?.data?.subName;
        orgamount = result?.data?.orgAmount;
        offeramount = result?.data?.offerAmount;
        profile = result?.data?.profile;
        overview = result?.data?.overview;
        duration = result?.data?.duration;
        previewvideo = result?.data?.previewVideo;
        lectures = result?.data?.lectures;
        language = result?.data?.language;
        requirements = result?.data?.requirements;
        specification = result?.data?.specifications;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => coursedetailpage()),
        );
      } else {
        showAppSnack(context, 'Could not open this course. Please try again.',
            error: true);
      }
    } finally {
      if (mounted) setState(() => _openingId = null);
    }
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        showCheckmark: false,
        selectedColor: Brand.primary,
        backgroundColor: Colors.white,
        side: BorderSide(color: selected ? Brand.primary : Brand.border),
        labelStyle: TextStyle(
          color: selected ? Colors.white : Brand.text,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.categorydata.isNotEmpty)
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: Brand.gutter, vertical: 6),
              children: [
                _chip('All', id == null, () => _select(null)),
                for (int i = 0; i < widget.categorydata.length; i++)
                  _chip(widget.categorydata[i], id == i, () => _select(i)),
              ],
            ),
          ),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: LoadingView(),
              );
            }
            final data = snapshot.data ?? const [];
            if (snapshot.hasError || data.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: EmptyView(
                  compact: true,
                  icon: Icons.school_outlined,
                  title: alllist
                      ? 'No courses available'
                      : 'No courses in "$name"',
                  message: 'Please check back later or try another category.',
                  actionLabel: 'Refresh',
                  onAction: () => setState(_load),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                  Brand.gutter, 8, Brand.gutter, Brand.gutter),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final subject in data)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () => _openCourse(subject),
                            child: Appear(child: allcourse_card(subject: subject)),
                          ),
                          if (_openingId == '${subject['site_courseid']}')
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  borderRadius:
                                      BorderRadius.circular(Brand.radius),
                                ),
                                child: const LoadingView(),
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class allcourse_card extends StatelessWidget {
  const allcourse_card({
    super.key,
    required this.subject,
  });

  final Map<String, dynamic> subject;

  @override
  Widget build(BuildContext context) {
    final title = clean(subject['course'], 'Untitled course');
    final sub = clean(subject['sub_name']);
    final offer = clean(subject['offer_amount']);
    final org = clean(subject['org_amount']);
    final showStrike = org.isNotEmpty && org != offer;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Brand.radius),
        border: Border.all(color: Brand.border),
        boxShadow: Brand.softShadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: SafeNetworkImage(url: '${subject['profile']}'),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w700, height: 1.3),
                ),
                if (sub.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    sub,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14, color: Brand.textMuted, height: 1.3),
                  ),
                ],
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        spacing: 8,
                        children: [
                          if (offer.isNotEmpty)
                            Text(
                              '₹$offer',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Brand.accent),
                            ),
                          if (showStrike)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                '₹$org',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Brand.textMuted,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Brand.primaryLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Explore',
                              style: TextStyle(
                                  color: Brand.primary,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_rounded,
                              size: 16, color: Brand.primary),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildText(String text, Color textColor, double fontSize) {
    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 10,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class Bottomsheet extends StatelessWidget {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Photos'),
                onTap: () {
                  // Handle tapping on Photos
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Music'),
                onTap: () {
                  // Handle tapping on Music
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library),
                title: Text('Videos'),
                onTap: () {
                  // Handle tapping on Videos
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Sheet Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showBottomSheet(context);
          },
          child: Text('Show Bottom Sheet'),
        ),
      ),
    );
  }
}

