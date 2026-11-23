import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';
import 'package:lottie/lottie.dart';

class audioplayer extends StatefulWidget {
  final String url;
  final String? title;
  const audioplayer({super.key, required this.url, this.title});

  @override
  State<audioplayer> createState() => _audioplayerState();
}

class _audioplayerState extends State<audioplayer> {
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool isPlaying = false;
  bool _loading = false;
  final List<StreamSubscription> _subs = [];

  @override
  void initState() {
    super.initState();
    _subs.add(audioPlayer.onDurationChanged.listen((d) {
      if (mounted) setState(() => _duration = d);
    }));
    _subs.add(audioPlayer.onPositionChanged.listen((p) {
      if (mounted) setState(() => _position = p);
    }));
    _subs.add(audioPlayer.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          isPlaying = false;
          _position = Duration.zero;
        });
      }
    }));
  }

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    audioPlayer.dispose();
    super.dispose();
  }

  String get _title {
    final t = clean(widget.title);
    if (t.isNotEmpty) return t;
    try {
      final seg = Uri.parse(widget.url).pathSegments;
      if (seg.isNotEmpty) return Uri.decodeComponent(seg.last);
    } catch (_) {}
    return 'Audio lesson';
  }

  String _fmt(Duration d) =>
      '${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final maxMs = _duration.inMilliseconds.toDouble();
    final posMs =
        _position.inMilliseconds.toDouble().clamp(0.0, maxMs <= 0 ? 0.0 : maxMs);

    return Scaffold(
      appBar: gradientAppBar('Audio'),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: constraints.maxHeight - 48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 260),
                    child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: Brand.softShadow,
                      ),
                      padding: const EdgeInsets.all(24),
                      child: isPlaying
                          ? LottieBuilder.asset('assets/audioplayjson.json')
                          : const FittedBox(
                              child: Icon(Icons.headphones_rounded,
                                  color: Brand.primary),
                            ),
                    ),
                  ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    _title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 4,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 7),
                    ),
                    child: Slider(
                      activeColor: Brand.primary,
                      inactiveColor: Brand.primaryLight,
                      value: posMs,
                      min: 0.0,
                      max: maxMs <= 0 ? 1.0 : maxMs,
                      onChanged: maxMs <= 0 ? null : seekToPosition,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_fmt(_position),
                            style: const TextStyle(color: Brand.textMuted)),
                        Text(_fmt(_duration),
                            style: const TextStyle(color: Brand.textMuted)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 34,
                        color: Brand.text,
                        onPressed: maxMs <= 0
                            ? null
                            : () => _skip(const Duration(seconds: -10)),
                        icon: const Icon(Icons.replay_10_rounded),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 76,
                        height: 76,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: _loading
                              ? null
                              : () => isPlaying ? pauseAudio() : playAudio(),
                          child: _loading
                              ? const SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 3, color: Colors.white),
                                )
                              : Icon(
                                  isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  size: 42),
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        iconSize: 34,
                        color: Brand.text,
                        onPressed: maxMs <= 0
                            ? null
                            : () => _skip(const Duration(seconds: 10)),
                        icon: const Icon(Icons.forward_10_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _skip(Duration delta) {
    var target = _position + delta;
    if (target < Duration.zero) target = Duration.zero;
    if (target > _duration) target = _duration;
    audioPlayer.seek(target);
  }

  Future<void> playAudio() async {
    setState(() => _loading = true);
    try {
      if (_position > Duration.zero) {
        await audioPlayer.resume();
      } else {
        await audioPlayer.play(UrlSource(widget.url));
      }
      if (mounted) setState(() => isPlaying = true);
    } catch (e) {
      debugPrint("Error playing audio: $e");
      if (mounted) {
        showAppSnack(context, 'This audio can\'t be played right now.',
            error: true);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void pauseAudio() {
    audioPlayer.pause();
    setState(() => isPlaying = false);
  }

  void stopAudio() {
    audioPlayer.stop();
  }

  void seekToPosition(double value) {
    audioPlayer.seek(Duration(milliseconds: value.toInt()));
  }
}
