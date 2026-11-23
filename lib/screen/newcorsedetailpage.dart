import 'package:flutter/material.dart';
import 'package:greenway/dashboard/widget/bottomnavigationbar.dart';
import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/loginpage/loginpage.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/screen/course_listing_page.dart';
import 'package:greenway/screen/newcoursedetailpage.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';

class newcourse extends StatefulWidget {
  final List<String> categorydata;
  const newcourse({super.key, required this.categorydata});

  @override
  State<newcourse> createState() => _newcourseState();
}

class _newcourseState extends State<newcourse> {
  @override
  Widget build(BuildContext context) {
    final islogin = rememberUser == true;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 190,
            backgroundColor: Brand.primary,
            foregroundColor: Colors.white,
            title: const Text('Explore Courses'),
            flexibleSpace: const FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: sliverbar(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  Brand.gutter, 20, Brand.gutter, 4),
              child: const SectionHeader('All courses'),
            ),
          ),
          SliverToBoxAdapter(
            child: allcourselister(categorydata: widget.categorydata),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Brand.border)),
          ),
          padding: const EdgeInsets.fromLTRB(Brand.gutter, 10, Brand.gutter, 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  islogin ? 'You\'re signed in' : 'Already have an account?',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Brand.textMuted),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 42),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                onPressed: () {
                  final nav = Navigator.of(context);
                  if (islogin) {
                    // Opened from the dashboard: just go back to it.
                    if (nav.canPop()) {
                      nav.pop();
                    } else {
                      nav.pushReplacement(MaterialPageRoute(
                          builder: (context) => const navigationbar()));
                    }
                  } else {
                    nav.push(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  }
                },
                child: Text(islogin ? 'Go to Dashboard' : 'Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Header shown behind the Explore app bar.
class sliverbar extends StatelessWidget {
  const sliverbar({super.key});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Container(
      decoration: const BoxDecoration(gradient: Brand.gradient),
      padding: EdgeInsets.fromLTRB(
          Brand.gutter, top + kToolbarHeight + 4, Brand.gutter, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to $Instittename',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  'A wide range of courses to make your learning more enjoyable.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13,
                      height: 1.35),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Image.asset(logo),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildText(String text, Color textColor, double fontSize) {
  return Text(
    text,
    textAlign: TextAlign.center,
    maxLines: 3,
    softWrap: true,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    ),
  );
}

class SearchInputFb1 extends StatelessWidget {
  final TextEditingController searchController;
  final String hintText;

  const SearchInputFb1(
      {required this.searchController, required this.hintText, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search_rounded),
        hintText: hintText,
      ),
    );
  }
}

class searchpages extends StatefulWidget {
  const searchpages({super.key});

  @override
  State<searchpages> createState() => _searchpagesState();
}

class _searchpagesState extends State<searchpages> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar('Search courses'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Brand.gutter),
            child: TextField(
              controller: _controller,
              autofocus: true,
              onChanged: (value) async {
                final searchResults = await search(value);
                if (!mounted) return;
                setState(() => _searchResults = searchResults);
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Search courses',
              ),
            ),
          ),
          Expanded(
            child: _searchResults.isEmpty
                ? EmptyView(
                    icon: Icons.search_rounded,
                    title: _controller.text.isEmpty
                        ? 'Find a course'
                        : 'No matching courses',
                    message: _controller.text.isEmpty
                        ? 'Start typing to search.'
                        : 'Try a different keyword.',
                  )
                : ListView.separated(
                    itemCount: _searchResults.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final r = _searchResults[index];
                      return ListTile(
                        leading: const Icon(Icons.search_rounded,
                            color: Brand.textMuted),
                        title: Text(clean(r['course']),
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Searchlist(
                                searchvalue: clean(r['course']),
                                searchid: clean(r['site_courseid']),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class Searchlist extends StatelessWidget {
  final String searchid;
  final String searchvalue;
  const Searchlist(
      {super.key, required this.searchvalue, required this.searchid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar(searchvalue),
      body: AsyncView<Map<String, dynamic>>(
        load: () => corsebyid(searchid),
        emptyIcon: Icons.school_outlined,
        emptyTitle: 'Course not found',
        builder: (context, data, reload) {
          return ListView(
            padding: const EdgeInsets.all(Brand.gutter),
            children: [
              GestureDetector(
                onTap: () {
                  coursename = data['course'];
                  subcoursename = data['sub_name'];
                  orgamount = data['org_amount'];
                  offeramount = data['offer_amount'];
                  profile = data['profile'];
                  overview = data['overview'];
                  duration = data['duration'];
                  lectures = data['lectures'];
                  language = data['language'];
                  requirements = data['requirements'];
                  specification = data['specifications'];
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => coursedetailpage()),
                  );
                },
                child: allcourse_card(subject: data),
              ),
            ],
          );
        },
      ),
    );
  }
}
