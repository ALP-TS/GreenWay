import 'dart:async';
import 'package:flutter/material.dart';
import 'package:greenway/theme/app_theme.dart';

class CountdownTimer extends StatefulWidget {
  /// Duration in minutes.
  final int time;
  final Function(bool) onTimerFinish;

  const CountdownTimer({
    super.key,
    required this.time,
    required this.onTimerFinish,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late int _countdown;

  @override
  void initState() {
    super.initState();
    _countdown = widget.time * 60;
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_countdown <= 0) {
        timer.cancel();
        widget.onTimerFinish(true);
      } else if (mounted) {
        setState(() => _countdown--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = _countdown ~/ 3600;
    final m = (_countdown % 3600) ~/ 60;
    final s = _countdown % 60;
    final text = h > 0
        ? '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}'
        : '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    final low = _countdown <= 60;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: low ? Brand.danger : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer_outlined,
              size: 16, color: low ? Colors.white : Brand.primary),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFeatures: const [FontFeature.tabularFigures()],
              color: low ? Colors.white : Brand.primary,
            ),
          ),
        ],
      ),
    );
  }
}
