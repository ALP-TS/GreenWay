import 'package:flutter/material.dart';
import 'package:greenway_lms/dashboard/dashboard.dart';
import 'package:greenway_lms/data.dart/apicalls.dart';
import 'package:greenway_lms/loginpage/loginpage.dart';
import 'package:greenway_lms/carousal/caroualpage.dart';
import 'package:greenway_lms/others/constants.dart';
import 'package:greenway_lms/screen/course_listing_page.dart';
import 'package:greenway_lms/screen/newcorsedetailpage.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _controller;

  get actions => null;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return buildPageItem(i);
              },
            ),
          ),
          buildDots(),
          const SizedBox(height: 100),
          buildContinueButton(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildPageItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                width: 1,
              ),
              TextButton(
                onPressed: () {
                  if (index == contents.length - 1) {
                    // If on the last content page, navigate to the LoginPage

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  } else {
                    // Otherwise, navigate to the last content page
                    _controller.animateToPage(
                      contents.length - 1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Text(
                  index == contents.length - 1 ? "" : "Skip >>",
                  style: TextStyle(
                    color: korange,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          FadingText(
            text: contents[index].title,
          ),
          // BouncingText(),
          // Text(
          //   contents[index].title,
          //   style: const TextStyle(
          //     fontSize: 25,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          const SizedBox(height: 20),
          Text(
            contents[index].discription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          // Fadingimg(text: contents[index].image,),
          FadeInImageExample(
            url: contents[index].image,
          ),
          // Image.asset(
          //   contents[index].image,
          //   height: 300,
          // ),
        ],
      ),
    );
  }

  Widget buildDots() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          contents.length,
          (index) => buildDot(index),
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kblue,
      ),
    );
  }

  Widget buildContinueButton() {
    return Container(
      width: 247,
      height: 52,
      child: ElevatedButton(
        child: Text(
          currentIndex == contents.length - 1 ? "Get Start" : "Next",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        onPressed: () async {
          if (currentIndex == contents.length - 1) {
            final categorydata = await coursecategory();
            print(categorydata);
            List<String> pic = await getsliderimage();
            setState(() {
              img = pic;
            });
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => newcourse(
                  categorydata: categorydata,
                ),
              ),
            );
          } else {
            _controller.nextPage(
              duration: Duration(milliseconds: 100),
              curve: Curves.bounceIn,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          // Set the background color here
          backgroundColor:
              kblue, // Example color, you can change it to your desired color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FadingText extends StatefulWidget {
  final String text;

  FadingText({super.key, required this.text});
  @override
  _FadingTextState createState() => _FadingTextState();
}

class _FadingTextState extends State<FadingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Do something when the animation completes, if necessary
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Text(
        widget.text,
        style: GoogleFonts.prociono(fontSize: 25),
      ),
    );
  }
}

class FadeInImageExample extends StatefulWidget {
  final String url;
  FadeInImageExample({required this.url});
  @override
  _FadeInImageExampleState createState() => _FadeInImageExampleState();
}

class _FadeInImageExampleState extends State<FadeInImageExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Image.asset(
            widget.url, // Replace with your image asset path
            height: 300,
          ),
        );
      },
    );
  }
}
