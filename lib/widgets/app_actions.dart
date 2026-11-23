import 'package:flutter/material.dart';
import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/loginpage/loginpage.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/screen/exampage.dart';
import 'package:greenway/screen/invoicelistingpage.dart';
import 'package:greenway/screen/newcorsedetailpage.dart';
import 'package:greenway/screen/subjectlisting.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Which tab of the home shell (Dashboard / Notifications / Profile) is shown.
/// The bottom bar and the side drawer both drive this.
final ValueNotifier<int> homeTab = ValueNotifier<int>(0);

const int kTabDashboard = 0;
const int kTabNotifications = 1;
const int kTabProfile = 2;

/// Loads course categories (tolerating failure) and opens Explore.
Future<void> openExplore(NavigatorState nav) async {
  List<String> categorydata = [];
  try {
    categorydata = await coursecategory();
  } catch (e) {
    debugPrint('coursecategory failed: $e');
  }
  img = await getsliderimage();
  if (!nav.mounted) return;
  nav.push(MaterialPageRoute(
      builder: (context) => newcourse(categorydata: categorydata)));
}

void openStudy(BuildContext context) {
  if (feestatus == 'active') {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const subjectlisting()));
  } else {
    showAppSnack(context,
        'Your subscription has expired. Please renew to continue studying.',
        error: true);
  }
}

void openExams(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const exampage()));
}

void openInvoices(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const Invoicelist()));
}

/// Asks for confirmation, clears the saved login and returns to Login.
Future<void> confirmLogout(NavigatorState nav) async {
  final ok = await showDialog<bool>(
    context: nav.context,
    builder: (ctx) => AlertDialog(
      icon: const Icon(Icons.logout_rounded, color: Brand.danger, size: 32),
      title: const Text('Log out?'),
      content: const Text('You will need to sign in again to continue.',
          textAlign: TextAlign.center),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel')),
        FilledButton(
          onPressed: () => Navigator.pop(ctx, true),
          style: FilledButton.styleFrom(
              backgroundColor: Brand.danger, minimumSize: const Size(90, 42)),
          child: const Text('Log out'),
        ),
      ],
    ),
  );
  if (ok != true) return;
  var sharedPref = await SharedPreferences.getInstance();
  sharedPref.setBool(KEYLOGIN, false);
  rememberUser = false; // keep in-memory login state in sync
  if (!nav.mounted) return;
  nav.pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const LoginPage()),
    (route) => false,
  );
}
