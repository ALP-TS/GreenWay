import 'package:flutter/material.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_actions.dart';
import 'package:greenway/widgets/app_widgets.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final name = clean(stuname, 'Student');
    final active = feestatus == 'active';
    final top = MediaQuery.of(context).padding.top;

    return Drawer(
      backgroundColor: Colors.white,
      width: (MediaQuery.of(context).size.width * 0.85).clamp(0.0, 304.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(28)),
      ),
      child: ValueListenableBuilder<int>(
        valueListenable: homeTab,
        builder: (context, current, _) {
          void goTab(int tab) {
            homeTab.value = tab;
            Navigator.pop(context);
          }

          void goScreen(void Function(NavigatorState nav) open) {
            final nav = Navigator.of(context);
            nav.pop();
            open(nav);
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(20, top + 20, 20, 22),
                      decoration: const BoxDecoration(
                        gradient: Brand.gradient,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(28),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InitialsAvatar(
                                name: name,
                                size: 56,
                                ringColor: active ? Brand.accent : Brand.danger,
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.asset(logo, width: 28, height: 28),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (clean(phone).isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              clean(phone),
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 13,
                              ),
                            ),
                          ],
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: StatusChip(
                              label: active
                                  ? 'Subscription active'
                                  : 'Subscription inactive',
                              color: active ? Brand.accent : Brand.danger,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _DrawerItem(
                            icon: Icons.dashboard_outlined,
                            selectedIcon: Icons.dashboard_rounded,
                            label: 'Dashboard',
                            selected: current == kTabDashboard,
                            onTap: () => goTab(kTabDashboard),
                          ),
                          _DrawerItem(
                            icon: Icons.notifications_none_rounded,
                            selectedIcon: Icons.notifications_rounded,
                            label: 'Notifications',
                            selected: current == kTabNotifications,
                            onTap: () => goTab(kTabNotifications),
                          ),
                          _DrawerItem(
                            icon: Icons.person_outline_rounded,
                            selectedIcon: Icons.person_rounded,
                            label: 'Profile',
                            selected: current == kTabProfile,
                            onTap: () => goTab(kTabProfile),
                          ),
                          const _DrawerSection('Learning'),
                          _DrawerItem(
                            icon: Icons.explore_outlined,
                            label: 'Explore courses',
                            onTap: () => goScreen(openExplore),
                          ),
                          _DrawerItem(
                            icon: Icons.menu_book_outlined,
                            label: 'Study',
                            onTap: () =>
                                goScreen((nav) => openStudy(nav.context)),
                          ),
                          _DrawerItem(
                            icon: Icons.assignment_outlined,
                            label: 'Exams',
                            onTap: () =>
                                goScreen((nav) => openExams(nav.context)),
                          ),
                          _DrawerItem(
                            icon: Icons.receipt_long_outlined,
                            label: 'Invoices',
                            onTap: () =>
                                goScreen((nav) => openInvoices(nav.context)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: _DrawerItem(
                    icon: Icons.logout_rounded,
                    label: 'Log out',
                    color: Brand.danger,
                    onTap: () => goScreen(confirmLogout),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DrawerSection extends StatelessWidget {
  const _DrawerSection(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          letterSpacing: 1.1,
          fontWeight: FontWeight.w700,
          color: Brand.textMuted,
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selectedIcon,
    this.selected = false,
    this.color,
  });

  final IconData icon;
  final IconData? selectedIcon;
  final String label;
  final VoidCallback onTap;
  final bool selected;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final fg = color ?? (selected ? Brand.primary : Brand.text);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: selected ? Brand.primaryLight : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            child: Row(
              children: [
                Icon(
                  selected ? (selectedIcon ?? icon) : icon,
                  color: color ?? (selected ? Brand.primary : Brand.textMuted),
                  size: 22,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: fg,
                      fontSize: 15,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
                if (selected)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Brand.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
