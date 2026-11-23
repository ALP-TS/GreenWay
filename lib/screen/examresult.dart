import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';

class viewresult extends StatelessWidget {
  const viewresult({super.key, required this.examid});
  final dynamic examid;

  int _toInt(dynamic v) => int.tryParse('${v ?? 0}') ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gradientAppBar('Result'),
      body: AsyncView<List<dynamic>>(
        load: () => examresult(userId ?? '', '$examid'),
        isEmpty: (d) => d.length < 2,
        emptyIcon: Icons.bar_chart_rounded,
        emptyTitle: 'No result available',
        emptyMessage:
            'Your result for this exam isn\'t ready yet. Please check back later.',
        builder: (context, data, reload) {
          final List<Map<String, dynamic>> questions =
              List<Map<String, dynamic>>.from(data[0] as List);
          final Map<String, dynamic> result =
              Map<String, dynamic>.from(data[1] as Map);
          final mark = _toInt(result['total_mark']);

          // Count from the answer list itself so the totals always match the
          // review cards below (the server's total_worng is unreliable).
          int correct = 0, wrong = 0, skipped = 0;
          for (final q in questions) {
            final correctAns = clean(q['currect_anwser']);
            final yourAns = clean(q['your_ans']);
            if (yourAns.isEmpty) {
              skipped++;
            } else if (correctAns.isNotEmpty && correctAns == yourAns) {
              correct++;
            } else {
              wrong++;
            }
          }

          return ListView(
            padding: const EdgeInsets.all(Brand.gutter),
            children: [
              AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    markindicater(
                      label: 'Your score',
                      total: questions.length.toDouble(),
                      completed: mark.toDouble(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _stat('Correct', '$correct', Brand.accent),
                        const SizedBox(width: 10),
                        _stat('Wrong', '$wrong', Brand.danger),
                        const SizedBox(width: 10),
                        if (skipped > 0) ...[
                          _stat('Skipped', '$skipped', Brand.warning),
                          const SizedBox(width: 10),
                        ],
                        _stat('Score', '$mark/${questions.length}',
                            Brand.primary),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const SectionHeader('Answer review'),
              for (int index = 0; index < questions.length; index++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _reviewCard(questions[index], index),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _stat(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(Brand.radiusSm + 2),
        ),
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(value,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w800, color: color)),
            ),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(fontSize: 12, color: Brand.textMuted)),
          ],
        ),
      ),
    );
  }

  Widget _reviewCard(Map<String, dynamic> q, int index) {
    final correctAns = clean(q['currect_anwser']);
    final yourAns = clean(q['your_ans']);
    final isCorrect = correctAns.isNotEmpty && correctAns == yourAns;
    final explanation = clean(q['explanation']);
    final color = isCorrect ? Brand.accent : Brand.danger;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: color.withValues(alpha: 0.12),
                child: Icon(
                    isCorrect ? Icons.check_rounded : Icons.close_rounded,
                    size: 16,
                    color: color),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${index + 1}. ${clean(q['qns'])}',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600, height: 1.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _answerRow('Correct answer', correctAns.isEmpty ? '—' : correctAns,
              Brand.accent),
          const SizedBox(height: 6),
          _answerRow('Your answer', yourAns.isEmpty ? 'Not answered' : yourAns,
              color),
          if (explanation.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Brand.background,
                borderRadius: BorderRadius.circular(Brand.radiusSm),
              ),
              child: Text(
                explanation,
                style: const TextStyle(
                    fontSize: 13, color: Brand.textMuted, height: 1.45),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _answerRow(String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(label,
              style: const TextStyle(fontSize: 13, color: Brand.textMuted)),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w700, color: color)),
        ),
      ],
    );
  }
}

class markindicater extends StatelessWidget {
  markindicater(
      {super.key,
      required this.label,
      required this.total,
      required this.completed});
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();
  final String label;
  final double total;
  final double completed;

  @override
  Widget build(BuildContext context) {
    final safeTotal = total <= 0 ? 1.0 : total;
    final done = completed.clamp(0, safeTotal).toDouble();
    final percent = (done / safeTotal) * 100;

    final Color color;
    final String text;
    if (percent >= 75) {
      color = Brand.accent;
      text = 'Excellent work!';
    } else if (percent >= 40) {
      color = Brand.warning;
      text = 'Good effort — keep practising.';
    } else {
      color = Brand.danger;
      text = 'Needs improvement — review the answers below.';
    }

    return LayoutBuilder(builder: (context, constraints) {
      final size = (constraints.maxWidth * 0.5).clamp(120.0, 180.0);
      return Column(
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 14,
                  color: Brand.textMuted,
                  fontWeight: FontWeight.w600)),
          AnimatedCircularChart(
            duration: const Duration(seconds: 1),
            key: _chartKey,
            size: Size(size, size),
            initialChartData: <CircularStackEntry>[
              CircularStackEntry(
                <CircularSegmentEntry>[
                  CircularSegmentEntry(done, color, rankKey: 'completed'),
                  CircularSegmentEntry(safeTotal - done,
                      color.withValues(alpha: 0.15),
                      rankKey: 'remaining'),
                ],
                rankKey: 'progress',
              ),
            ],
            chartType: CircularChartType.radial,
            edgeStyle: SegmentEdgeStyle.round,
            holeLabel: '${percent.toStringAsFixed(0)}%',
            labelStyle: TextStyle(
                fontSize: 26, fontWeight: FontWeight.w800, color: color),
            percentageValues: false,
          ),
          Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color, fontSize: 15, fontWeight: FontWeight.w600)),
        ],
      );
    });
  }
}
