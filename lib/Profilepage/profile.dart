import 'package:flutter/material.dart';
import 'package:greenway/dashboard/widget/appdrawer.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_actions.dart';
import 'package:greenway/widgets/app_widgets.dart';

class profile_page extends StatelessWidget {
  const profile_page({super.key});

  @override
  Widget build(BuildContext context) {
    final active = feestatus == 'active';
    final name = clean(stuname, 'Student');
    final expiry = formatApiDate(expireDate, 'Not available');

    return Scaffold(
      appBar: gradientAppBar('Profile'),
      drawer: const MyDrawer(),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
            decoration: const BoxDecoration(
              gradient: Brand.gradient,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
            ),
            child: Column(
              children: [
                Appear(
                  child: InitialsAvatar(
                    name: name,
                    size: 96,
                    ringColor: active ? Brand.accent : Brand.danger,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800),
                ),
                if (clean(phone).isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    clean(phone),
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 14),
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
            padding: const EdgeInsets.fromLTRB(
                Brand.gutter, 24, Brand.gutter, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SectionHeader('Account details'),
                Appear(
                  index: 1,
                  child: AppCard(
                    animate: false,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      children: [
                        _InfoTile(
                          icon: Icons.person_outline_rounded,
                          label: 'Full name',
                          value: name,
                        ),
                        const Divider(height: 1, indent: 72),
                        _InfoTile(
                          icon: Icons.phone_outlined,
                          label: 'Phone',
                          value: clean(phone, 'Not available'),
                        ),
                        const Divider(height: 1, indent: 72),
                        _InfoTile(
                          icon: Icons.event_available_outlined,
                          label: 'Valid until',
                          value: expiry,
                          color: active ? Brand.accent : Brand.danger,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const SectionHeader('Quick links'),
                Appear(
                  index: 2,
                  child: AppCard(
                    animate: false,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      children: [
                        _LinkTile(
                          icon: Icons.menu_book_rounded,
                          color: Brand.accent,
                          label: 'Study',
                          onTap: () => openStudy(context),
                        ),
                        const Divider(height: 1, indent: 72),
                        _LinkTile(
                          icon: Icons.assignment_rounded,
                          color: Brand.warning,
                          label: 'My exams',
                          onTap: () => openExams(context),
                        ),
                        const Divider(height: 1, indent: 72),
                        _LinkTile(
                          icon: Icons.receipt_long_rounded,
                          color: const Color(0xFF7C3AED),
                          label: 'Invoices',
                          onTap: () => openInvoices(context),
                        ),
                        const Divider(height: 1, indent: 72),
                        _LinkTile(
                          icon: Icons.notifications_rounded,
                          color: Brand.primary,
                          label: 'Notifications',
                          onTap: () => homeTab.value = kTabNotifications,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () => confirmLogout(Navigator.of(context)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Brand.danger,
                    side: const BorderSide(color: Brand.dangerLight),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Log out'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.color = Brand.primary,
  });
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconBadge(icon: icon, size: 40, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 12, color: Brand.textMuted)),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  const _LinkTile({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            IconBadge(icon: icon, size: 40, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600)),
            ),
            const Icon(Icons.chevron_right_rounded, color: Brand.textMuted),
          ],
        ),
      ),
    );
  }
}
