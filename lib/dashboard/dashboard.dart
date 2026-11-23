import 'package:flutter/material.dart';
import 'package:greenway/dashboard/widget/appdrawer.dart';
import 'package:greenway/dashboard/widget/dashcontainer1.dart';
import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/data.dart/feestatusmodel/feestatusmodel.dart';
import 'package:greenway/data.dart/studentdetailsmodel/studentdetailsmodel.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_actions.dart';
import 'package:greenway/widgets/app_widgets.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  late Future<Feestatusmodel?> _feeFuture;
  int _refreshKey = 0;

  @override
  void initState() {
    super.initState();
    _feeFuture = _loadFee();
  }

  Future<Feestatusmodel?> _loadFee() async {
    if (userId == null) return null;
    final result = await fee_status(userId!);
    final s = result?.data?.status;
    if (s != null) feestatus = s;
    return result;
  }

  Future<void> _refresh() async {
    setState(() {
      _feeFuture = _loadFee();
      _refreshKey++;
    });
    await _feeFuture;
  }

  @override
  Widget build(BuildContext context) {
    final iscondition = rememberUser == true && studentId != null;

    return Scaffold(
      appBar: gradientAppBar(
        'Dashboard',
        actions: [
          IconButton(
            tooltip: 'Notifications',
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () => homeTab.value = kTabNotifications,
          ),
          const SizedBox(width: 4),
        ],
      ),
      drawer: const MyDrawer(),
      body: iscondition
          ? AsyncView<Studentdetailsmodel?>(
              key: ValueKey('student-$_refreshKey'),
              load: () => loginalready(studentId!),
              isEmpty: (r) => r?.data == null,
              emptyIcon: Icons.person_off_outlined,
              emptyTitle: 'Couldn\'t load your profile',
              emptyMessage:
                  'We were unable to fetch your account details. Please try again.',
              builder: (context, result, reload) {
                password_status = result?.status;
                loginmessage = result?.message;
                studentId = result?.data?.studentId;
                userId = result?.data?.userId;
                classId = result?.data?.classId;
                stuname = result?.data?.name;
                phone = result?.data?.phone;
                expireDate = result?.data?.expireDate;
                seenVideo = result?.data?.seenVideo;
                ip = result?.data?.ip;
                deviceId = result?.data?.deviceId;
                status = result?.data?.status;
                return _content();
              },
            )
          : _content(),
    );
  }

  Widget _content() {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          FutureBuilder<Feestatusmodel?>(
            future: _feeFuture,
            builder: (context, snap) => dash_container1(
              feeLoading: snap.connectionState != ConnectionState.done,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Brand.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SectionHeader('Your progress'),
                coursedetails(key: ValueKey('progress-$_refreshKey')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Kept for compatibility; the header now lives in [dash_container1].
class container1 extends StatelessWidget {
  const container1({super.key});

  @override
  Widget build(BuildContext context) => const dash_container1();
}

Widget bottem_container() {
  return const Padding(
    padding: EdgeInsets.all(Brand.gutter),
    child: coursedetails(),
  );
}

class coursedetails extends StatelessWidget {
  const coursedetails({super.key});

  int _toInt(dynamic v) => int.tryParse('${v ?? 0}') ?? 0;

  @override
  Widget build(BuildContext context) {
    return AsyncView<List<Map<String, dynamic>>>(
      load: courseprogress,
      compact: true,
      errorAsEmpty: true,
      emptyIcon: Icons.insights_outlined,
      emptyTitle: 'No progress yet',
      emptyMessage:
          'Start watching videos, listening to audio and reading notes to see your progress here.',
      builder: (context, course, reload) {
        final c = course.first;
        final items = [
          _ProgressItem('Videos', Icons.play_circle_fill_rounded, Brand.primary,
              _toInt(c['seen_video']), _toInt(c['video'])),
          _ProgressItem('Audio', Icons.headphones_rounded, Brand.accent,
              _toInt(c['seen_audio']), _toInt(c['audio'])),
          _ProgressItem('Notes', Icons.description_rounded, Brand.warning,
              _toInt(c['seen_notes']), _toInt(c['notes'])),
        ];
        final total = items.fold<int>(0, (s, i) => s + i.total);
        final done =
            items.fold<int>(0, (s, i) => s + i.done.clamp(0, i.total));
        final overall = total == 0 ? 0.0 : done / total;

        return Appear(
          child: AppCard(
            animate: false,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    _Ring(value: overall),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Current course',
                              style: TextStyle(
                                  fontSize: 12, color: Brand.textMuted)),
                          const SizedBox(height: 2),
                          Text(
                            clean(c['class'], 'Your course'),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                height: 1.25),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '$done of $total lessons completed',
                            style: const TextStyle(
                                fontSize: 13, color: Brand.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                for (final item in items) _ProgressBar(item: item),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProgressItem {
  const _ProgressItem(this.label, this.icon, this.color, this.done, this.total);
  final String label;
  final IconData icon;
  final Color color;
  final int done;
  final int total;
}

class _Ring extends StatelessWidget {
  const _Ring({required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      height: 76,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: value),
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutCubic,
        builder: (context, v, _) => Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1,
              strokeWidth: 8,
              color: Brand.primaryLight,
            ),
            CircularProgressIndicator(
              value: v,
              strokeWidth: 8,
              strokeCap: StrokeCap.round,
              color: Brand.primary,
            ),
            Center(
              child: Text(
                '${(v * 100).round()}%',
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.item});
  final _ProgressItem item;

  @override
  Widget build(BuildContext context) {
    final done = item.done.clamp(0, item.total);
    final value = item.total == 0 ? 0.0 : done / item.total;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          IconBadge(icon: item.icon, color: item.color, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(item.label,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    Text('$done/${item.total}',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Brand.textMuted)),
                  ],
                ),
                const SizedBox(height: 6),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: value),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  builder: (context, v, _) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: v,
                      minHeight: 8,
                      color: item.color,
                      backgroundColor: item.color.withValues(alpha: 0.12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Small status pill (kept for any external use).
class feestatus_indicater extends StatelessWidget {
  const feestatus_indicater({super.key});

  @override
  Widget build(BuildContext context) {
    final active = feestatus == 'active';
    return StatusChip(
      label: active ? 'Active' : 'Inactive',
      color: active ? Brand.accent : Brand.danger,
    );
  }
}
