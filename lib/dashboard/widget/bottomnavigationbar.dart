import 'package:flutter/material.dart';
import 'package:greenway/Profilepage/profile.dart';
import 'package:greenway/dashboard/dashboard.dart';
import 'package:greenway/dashboard/widget/appdrawer.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/widgets/app_actions.dart';
import 'package:greenway/widgets/app_widgets.dart';

// ignore: camel_case_types
class navigationbar extends StatefulWidget {
  const navigationbar({super.key});

  @override
  State<navigationbar> createState() => _navigationbarState();
}

// ignore: camel_case_types
class _navigationbarState extends State<navigationbar> {
  static const List<Widget> _pages = [
    dashboard(),
    pagetwo(),
    profile_page(),
  ];

  @override
  void initState() {
    super.initState();
    homeTab.value = kTabDashboard;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: homeTab,
      builder: (context, current, _) {
        return PopScope(
          // Back from Notifications/Profile returns to Dashboard first.
          canPop: current == kTabDashboard,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) homeTab.value = kTabDashboard;
          },
          child: Scaffold(
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: KeyedSubtree(
                  key: ValueKey(current), child: _pages[current]),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1B2559).withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: NavigationBar(
                selectedIndex: current,
                height: 68,
                onDestinationSelected: (int index) => homeTab.value = index,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.dashboard_outlined),
                    selectedIcon: Icon(Icons.dashboard_rounded),
                    label: 'Dashboard',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.notifications_none_rounded),
                    selectedIcon: Icon(Icons.notifications_rounded),
                    label: 'Notifications',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline_rounded),
                    selectedIcon: Icon(Icons.person_rounded),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class pagetwo extends StatelessWidget {
  const pagetwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar('Notifications'),
      drawer: const MyDrawer(),
      body: EmptyView(
        icon: Icons.notifications_none_rounded,
        title: 'You\'re all caught up',
        message:
            'Announcements, exam alerts and updates from $Instittename will appear here.',
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Page'));
  }
}
