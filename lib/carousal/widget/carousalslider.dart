import 'package:flutter/material.dart';
import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/loginpage/loginpage.dart';
import 'package:greenway/carousal/caroualpage.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/screen/newcorsedetailpage.dart';
import 'package:greenway/theme/app_theme.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  bool _loading = false;
  late PageController _controller;

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

  bool get _isLast => currentIndex == contents.length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 8, 0),
              child: Row(
                children: [
                  Image.asset(logo, height: 36),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      Instittename,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Brand.text),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _isLast ? 0 : 1,
                    duration: const Duration(milliseconds: 200),
                    child: TextButton(
                      onPressed: _isLast
                          ? null
                          : () => _controller.animateToPage(
                                contents.length - 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
                      child: const Text('Skip'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() => currentIndex = index);
                },
                itemBuilder: (_, i) => buildPageItem(i),
              ),
            ),
            buildDots(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: buildContinueButton(),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Already have an account? Login'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  static const _slideIcons = [
    Icons.school_rounded,
    Icons.groups_rounded,
    Icons.favorite_rounded,
  ];
  static const _slideGradients = [
    Brand.gradient,
    Brand.greenGradient,
    Brand.violetGradient,
  ];

  /// Text-only slide: a large icon emblem above the welcome message.
  Widget buildPageItem(int index) {
    final icon = _slideIcons[index % _slideIcons.length];
    final gradient = _slideGradients[index % _slideGradients.length];
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SlideEmblem(icon: icon, gradient: gradient),
              const SizedBox(height: 36),
              FadingText(text: contents[index].title),
              if (contents[index].discription.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  contents[index].discription,
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(fontSize: 14, color: Brand.textMuted),
                ),
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(contents.length, (index) => buildDot(index)),
    );
  }

  Widget buildDot(int index) {
    final active = currentIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 8,
      width: active ? 24 : 8,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: active ? Brand.primary : Brand.border,
      ),
    );
  }

  Widget buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _loading
            ? null
            : () async {
                if (_isLast) {
                  setState(() => _loading = true);
                  List<String> categorydata = [];
                  try {
                    categorydata = await coursecategory();
                  } catch (e) {
                    debugPrint('coursecategory failed: $e');
                  }
                  List<String> pic = await getsliderimage();
                  if (!mounted) return;
                  img = pic;
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          newcourse(categorydata: categorydata),
                    ),
                  );
                } else {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              },
        child: _loading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2.5, color: Colors.white),
              )
            : Text(_isLast ? 'Get Started' : 'Next'),
      ),
    );
  }
}

/// Layered circles with a gradient icon, used instead of slide pictures.
class _SlideEmblem extends StatelessWidget {
  const _SlideEmblem({required this.icon, required this.gradient});
  final IconData icon;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    final tint = gradient.colors.last;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.85, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: tint.withValues(alpha: 0.06),
        ),
        alignment: Alignment.center,
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: tint.withValues(alpha: 0.10),
          ),
          alignment: Alignment.center,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: gradient,
              boxShadow: [
                BoxShadow(
                  color: tint.withValues(alpha: 0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 48),
          ),
        ),
      ),
    );
  }
}

class FadingText extends StatefulWidget {
  final String text;

  const FadingText({super.key, required this.text});
  @override
  State<FadingText> createState() => _FadingTextState();
}

class _FadingTextState extends State<FadingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
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
        textAlign: TextAlign.center,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 20,
          height: 1.35,
          fontWeight: FontWeight.w600,
          color: Brand.text,
        ),
      ),
    );
  }
}

class FadeInImageExample extends StatefulWidget {
  final String url;
  const FadeInImageExample({super.key, required this.url});
  @override
  State<FadeInImageExample> createState() => _FadeInImageExampleState();
}

class _FadeInImageExampleState extends State<FadeInImageExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Image.asset(widget.url, fit: BoxFit.contain),
    );
  }
}
