// UI regression check: renders screens on a small phone with large text and
// fails on any overflow / build exception. Network calls fail in tests, so
// screens that fetch data exercise their empty / error states.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenway/Profilepage/profile.dart';
import 'package:greenway/Profilepage/temp.dart';
import 'package:greenway/carousal/widget/carousalslider.dart';
import 'package:greenway/dashboard/dashboard.dart';
import 'package:greenway/dashboard/widget/bottomnavigationbar.dart';
import 'package:greenway/loginpage/loginpage.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/screen/audiolisting.dart';
import 'package:greenway/screen/course_listing_page.dart';
import 'package:greenway/screen/exampage.dart';
import 'package:greenway/screen/examresult.dart';
import 'package:greenway/screen/invoicelistingpage.dart';
import 'package:greenway/screen/newcorsedetailpage.dart';
import 'package:greenway/screen/newcoursedetailpage.dart';
import 'package:greenway/screen/notesinnerlist.dart';
import 'package:greenway/screen/pdflisting.dart';
import 'package:greenway/screen/subjectlisting.dart';
import 'package:greenway/screen/topiclisting.dart';
import 'package:greenway/screen/videolisting.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_actions.dart';

const longText =
    'An extremely long title that keeps going and going to make sure nothing '
    'overflows on very small screens with large accessibility font sizes';

Future<void> pumpScreen(WidgetTester tester, Widget screen,
    {Size size = const Size(320, 568), double textScale = 1.15}) async {
  tester.view.physicalSize = size * 2;
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(MaterialApp(
    theme: Brand.theme(),
    home: MediaQuery(
      data: MediaQueryData(
          size: size, textScaler: TextScaler.linear(textScale)),
      child: screen,
    ),
  ));
  // Let futures (which fail fast in tests) resolve.
  for (int i = 0; i < 5; i++) {
    await tester.pump(const Duration(milliseconds: 300));
  }
}

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  setUp(() {
    stuname = longText;
    phone = '9999999999';
    expireDate = '1735689600';
    feestatus = 'active';
    userId = '1';
    studentId = '1';
    classId = '1';
    rememberUser = null;
    coursename = longText;
    subcoursename = longText;
    orgamount = '99999';
    offeramount = '49999';
    profile = '';
    overview = longText * 3;
    specification = longText;
    requirements = 'One requirement, $longText, three';
    duration = longText;
    lectures = '120';
    language = 'English';
  });

  final course = {
    'site_courseid': '1',
    'course': longText,
    'sub_name': longText,
    'profile': '',
    'offer_amount': '49999',
    'org_amount': '99999',
  };

  testWidgets('login', (t) async => pumpScreen(t, const LoginPage()));
  testWidgets('onboarding', (t) async => pumpScreen(t, const Onboarding()));
  testWidgets('dashboard (empty/error)',
      (t) async => pumpScreen(t, const dashboard()));
  testWidgets('drawer switches tabs', (t) async {
    await pumpScreen(t, const navigationbar());
    Future<void> openDrawerAndTap(String label) async {
      await t.tap(find.byTooltip('Open navigation menu'));
      for (int i = 0; i < 10; i++) {
        await t.pump(const Duration(milliseconds: 50));
      }
      final item = find.descendant(
          of: find.byType(Drawer), matching: find.text(label));
      await t.ensureVisible(item);
      await t.pump();
      await t.tap(item);
      for (int i = 0; i < 12; i++) {
        await t.pump(const Duration(milliseconds: 50));
      }
    }

    await openDrawerAndTap('Notifications');
    expect(find.text('You\'re all caught up'), findsOneWidget);
    await openDrawerAndTap('Profile');
    expect(homeTab.value, kTabProfile);
    await openDrawerAndTap('Dashboard');
    expect(homeTab.value, kTabDashboard);
  });
  testWidgets('nav + notifications', (t) async {
    await pumpScreen(t, const navigationbar());
    await t.tap(find.text('Notifications'));
    await t.pump(const Duration(milliseconds: 300));
    await t.tap(find.text('Profile'));
    await t.pump(const Duration(milliseconds: 300));
  });
  testWidgets('profile', (t) async => pumpScreen(t, const profile_page()));
  testWidgets('explore',
      (t) async => pumpScreen(t, const newcourse(categorydata: ['A', longText])));
  testWidgets('course detail', (t) async {
    await pumpScreen(t, const coursedetailpage());
    await t.tap(find.text('Requirements'));
    await t.pump(const Duration(milliseconds: 400));
  });
  testWidgets('course card', (t) async {
    await pumpScreen(
        t, Scaffold(body: ListView(children: [allcourse_card(subject: course)])));
  });
  testWidgets('subjects empty', (t) async => pumpScreen(t, const subjectlisting()));
  testWidgets('topics empty',
      (t) async => pumpScreen(t, const topiclisting(subid: '1', title: longText)));
  testWidgets('videos empty',
      (t) async => pumpScreen(t, const Videolisting(topicid: '1')));
  testWidgets('video tile', (t) async {
    await pumpScreen(
        t,
        Scaffold(
            body: ListView(children: [
          VideoTile(
              subject: {'videoname': longText, 'created_at': '1735689600'},
              onTap: () {}),
        ])));
  });
  testWidgets('notes empty', (t) async => pumpScreen(t, const notelisting(topicid: '1')));
  testWidgets('note cards', (t) async {
    await pumpScreen(
        t,
        Scaffold(
            body: ListView(children: [
          pdflistcard(subject: {
            'title': longText,
            'descp': longText,
            'file_name': '["https://x/a.pdf","https://x/b.png"]'
          }),
          pdflistcard(subject: {
            'title': longText,
            'descp': longText,
            'file_name': 'not json https://x/a.pdf'
          }),
          pdflistcard(subject: {'title': null, 'descp': null, 'file_name': null}),
        ])));
  });
  testWidgets('note inner list', (t) async {
    await pumpScreen(
        t,
        const noteinnerlist(
            pdf: ['https://x/very-long-file-name-for-testing-overflow.pdf', 'https://x/b.png'],
            name: longText,
            dec: longText));
  });
  testWidgets('audio empty', (t) async => pumpScreen(t, const audiolisting(topicid: '1')));
  testWidgets('exams empty', (t) async => pumpScreen(t, const exampage()));
  testWidgets('result empty', (t) async => pumpScreen(t, const viewresult(examid: '1')));
  testWidgets('invoices empty', (t) async => pumpScreen(t, const Invoicelist()));
  testWidgets('exam taking', (t) async {
    await pumpScreen(
        t,
        temp(
          exam: [
            {
              'id': '1',
              'qns': longText,
              'optiona': longText,
              'optionb': 'B',
              'optionc': 'C',
              'optiond': 'Delta option',
              'optione': '',
            }
          ],
          l: 1,
          examid: '1',
          time: 90,
        ));
    await t.scrollUntilVisible(find.text('Delta option'), 150,
        scrollable: find.byType(Scrollable).first);
    await t.tap(find.text('Delta option'));
    await t.pump();
    // Dispose to stop the countdown timer.
    await t.pumpWidget(const SizedBox());
  });
}
