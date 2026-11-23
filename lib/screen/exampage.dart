import 'package:flutter/material.dart';
import 'package:greenway/Profilepage/temp.dart';
import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/screen/examresult.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';

class exampage extends StatefulWidget {
  const exampage({super.key});

  @override
  State<exampage> createState() => _exampageState();
}

class _exampageState extends State<exampage> {
  String? _busyExamId;

  Future<void> _start(
      Map<String, dynamic> exam, Future<void> Function() reload) async {
    if (_busyExamId != null) return;
    final examId = '${exam['exam_id']}';
    setState(() => _busyExamId = examId);
    try {
      final data = await startexam(userId!, examId);
      if (!mounted) return;
      if (data.length < 2 || (data[0] as List).isEmpty) {
        // Usually means the exam was already started (e.g. the student left
        // it with the back arrow). Refresh so the card shows its real state.
        setState(() => _busyExamId = null);
        await reload();
        return;
      }
      final List<Map<String, dynamic>> questions =
          List<Map<String, dynamic>>.from(data[0]);
      final Map<String, dynamic> info = Map<String, dynamic>.from(data[1]);
      final time = secondconvert('${info['totaltime']}');
      setState(() => _busyExamId = null);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => temp(
            exam: questions,
            l: questions.length,
            examid: examId,
            time: time,
            isMock: '${exam['is_mock']}' == '1' || exam['is_mock'] == true,
          ),
        ),
      );
      // Back from the exam (finished or quit): refresh the exam list.
      if (mounted) await reload();
    } catch (e) {
      // No error message: just refresh so the card shows its current state.
      debugPrint('startexam failed: $e');
      if (mounted) {
        setState(() => _busyExamId = null);
        await reload();
      }
    } finally {
      if (mounted) setState(() => _busyExamId = null);
    }
  }

  Future<void> _reset(String examId, Future<void> Function() reload) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear exam data?'),
        content: const Text(
            'Your answers for this exam will be removed so you can attempt it again.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Brand.danger),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    setState(() => _busyExamId = examId);
    final status = await resetexamdata(examId);
    if (!mounted) return;
    setState(() => _busyExamId = null);
    if (status == 'success') {
      showAppSnack(context, 'Exam data cleared successfully');
    } else {
      showAppSnack(context, 'You can\'t reset this exam right now',
          error: true);
    }
    // Always refresh so the card reflects the server's current state
    // (shows "Start Now" once the data is cleared).
    await reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar('Online Exams'),
      body: AsyncView<List<Map<String, dynamic>>>(
        load: () => getexam(userId ?? ''),
        emptyIcon: Icons.assignment_outlined,
        emptyTitle: 'No exams scheduled',
        emptyMessage: 'When an exam is assigned to you it will show up here.',
        builder: (context, exams, reload) {
          return RefreshIndicator(
            onRefresh: reload,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(Brand.gutter),
              itemCount: exams.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) =>
                  _examCard(exams[index], reload),
            ),
          );
        },
      ),
    );
  }

  Widget _examCard(Map<String, dynamic> exam, Future<void> Function() reload) {
    final button = clean(exam['button']);
    final buttonKey = button.toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
    final startnow = buttonKey == 'start now';
    final missed = buttonKey == 'missed';
    final examId = '${exam['exam_id']}';
    final busy = _busyExamId == examId;

    final Color statusColor =
        startnow ? Brand.primary : (missed ? Brand.danger : Brand.accent);
    final String statusLabel =
        startnow ? 'Available' : (missed ? 'Missed' : 'Completed');

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconBadge(icon: Icons.assignment_rounded, color: statusColor),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clean(exam['name'], 'Exam'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    if (clean(exam['topics']).isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        clean(exam['topics']),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13, color: Brand.textMuted),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              StatusChip(label: statusLabel, color: statusColor),
            ],
          ),
          if (clean(exam['date']).isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.event_outlined,
                    size: 16, color: Brand.textMuted),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(clean(exam['date']),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, color: Brand.textMuted)),
                ),
              ],
            ),
          ],
          const SizedBox(height: 14),
          if (startnow)
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: busy ? null : () => _start(exam, reload),
                icon: busy
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.play_arrow_rounded),
                label: Text(busy ? 'Starting…' : 'Start Now'),
              ),
            )
          else if (missed)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () =>
                    showAppSnack(context, 'You did not attend this exam'),
                style: OutlinedButton.styleFrom(
                    foregroundColor: Brand.danger,
                    side: const BorderSide(color: Brand.dangerLight)),
                icon: const Icon(Icons.call_missed_rounded),
                label: const Text('Missed'),
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                        backgroundColor: Brand.accent),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => viewresult(examid: examId),
                        ),
                      );
                    },
                    icon: const Icon(Icons.bar_chart_rounded),
                    label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(button.isEmpty ? 'View Result' : button),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Brand.danger,
                        side: const BorderSide(color: Brand.dangerLight)),
                    onPressed: busy ? null : () => _reset(examId, reload),
                    icon: busy
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.delete_outline_rounded),
                    label: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(busy ? 'Clearing…' : 'Clear Data')),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

int secondconvert(String time) {
  final parts = time.split(':');
  final hours = int.tryParse(parts.isNotEmpty ? parts[0] : '') ?? 0;
  final minutes = int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0;
  return hours * 60 + minutes;
}
