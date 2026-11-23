import 'package:flutter/material.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_actions.dart';
import 'package:greenway/widgets/app_widgets.dart';

/// Dashboard hero: greeting, subscription status and quick actions.
class dash_container1 extends StatefulWidget {
  const dash_container1({super.key, this.feeLoading = false});
  final bool feeLoading;

  @override
  State<dash_container1> createState() => _dash_container1State();
}

class _dash_container1State extends State<dash_container1> {
  bool _openingExplore = false;

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  Future<void> _openExplore() async {
    if (_openingExplore) return;
    setState(() => _openingExplore = true);
    await openExplore(Navigator.of(context));
    if (mounted) setState(() => _openingExplore = false);
  }

  @override
  Widget build(BuildContext context) {
    final name = clean(stuname, 'Student');
    final active = feestatus == 'active';
    final expiry = formatApiDate(expireDate);

    return Column(
      children: [
        // Gradient hero
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: Brand.gradient,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
          ),
          padding: const EdgeInsets.fromLTRB(Brand.gutter, 4, Brand.gutter, 56),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InitialsAvatar(name: name, size: 52, ringColor: Colors.white),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$_greeting 👋',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Subscription glass card
              Material(
                color: Colors.white.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(Brand.radius),
                child: InkWell(
                  borderRadius: BorderRadius.circular(Brand.radius),
                  onTap: () => homeTab.value = kTabProfile,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Brand.radius),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: widget.feeLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(11),
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2),
                                )
                              : Icon(
                                  active
                                      ? Icons.verified_rounded
                                      : Icons.error_outline_rounded,
                                  color:
                                      active ? Brand.accent : Brand.danger,
                                ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.feeLoading
                                    ? 'Checking subscription…'
                                    : active
                                        ? 'Subscription active'
                                        : 'Subscription inactive',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                active
                                    ? (expiry.isEmpty
                                        ? 'Full access to your course'
                                        : 'Valid until $expiry')
                                    : 'Renew to continue studying',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded,
                            color: Colors.white.withValues(alpha: 0.8)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Quick actions overlap the hero
        Transform.translate(
          // Layout space stays in place, so this also gives a 36px gap below.
          offset: const Offset(0, -36),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Brand.gutter),
            child: Column(
              children: [
                Row(
                  children: [
                    _ActionCard(
                      index: 0,
                      title: 'Explore',
                      subtitle: 'Browse courses',
                      icon: Icons.explore_rounded,
                      gradient: Brand.gradient,
                      loading: _openingExplore,
                      onTap: _openExplore,
                    ),
                    const SizedBox(width: 12),
                    _ActionCard(
                      index: 1,
                      title: 'Study',
                      subtitle: 'Subjects & lessons',
                      icon: Icons.menu_book_rounded,
                      gradient: Brand.greenGradient,
                      onTap: () => openStudy(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _ActionCard(
                      index: 2,
                      title: 'Exams',
                      subtitle: 'Tests & results',
                      icon: Icons.assignment_rounded,
                      gradient: Brand.amberGradient,
                      onTap: () => openExams(context),
                    ),
                    const SizedBox(width: 12),
                    _ActionCard(
                      index: 3,
                      title: 'Invoices',
                      subtitle: 'Fee history',
                      icon: Icons.receipt_long_rounded,
                      gradient: Brand.violetGradient,
                      onTap: () => openInvoices(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.onTap,
    this.loading = false,
  });

  final int index;
  final String title;
  final String subtitle;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Appear(
        index: index,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Brand.radius + 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1B2559).withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(Brand.radius + 2),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: loading ? null : onTap,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: gradient,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: loading
                          ? const Padding(
                              padding: EdgeInsets.all(12),
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : Icon(icon, color: Colors.white, size: 24),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12, color: Brand.textMuted),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
