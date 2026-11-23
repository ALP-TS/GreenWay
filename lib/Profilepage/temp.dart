import 'package:flutter/material.dart';
import 'package:greenway/dashboard/widget/bottomnavigationbar.dart';
import 'package:greenway/data.dart/apicalls.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/screen/countdowntimer.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';

class temp extends StatefulWidget {
  final List<Map<String, dynamic>> exam;
  final int l;
  final String examid;
  final int time;

  /// Mock exam: after each answer, show whether it was right and the correct answer.
  final bool isMock;

  const temp(
      {super.key,
      required this.exam,
      required this.l,
      required this.examid,
      required this.time,
      this.isMock = false});

  @override
  State<temp> createState() => _tempState();
}

class _tempState extends State<temp> {
  int index = 0;
  String? _selectedAnswer;
  bool timerFinished = false;
  bool _busy = false;

  static const _options = ['A', 'B', 'C', 'D', 'E'];

  /// Mock-exam feedback per question index, once that question is answered.
  final Map<int, _MockFeedback> _feedback = {};

  void handleTimerFinish(bool finished) {
    if (mounted) setState(() => timerFinished = finished);
  }

  void _handleClearButtonPressed() {
    setState(() => _selectedAnswer = null);
  }

  void _goNext() {
    setState(() {
      index++;
      _selectedAnswer = null;
    });
  }

  Future<void> _submitAnswer(String answer) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final quesId = '${widget.exam[index]['id']}';
      // Mock exams show feedback after every answer, including skips ('0').
      if (widget.isMock) {
        final reply =
            await submitAnswer(quesId, answer, widget.examid, userId!);
        if (!mounted) return;
        setState(() {
          _feedback[index] =
              _MockFeedback.from(widget.exam[index], answer, reply);
        });
      } else {
        await nextques(quesId, answer, widget.examid, userId!);
        if (!mounted) return;
        _goNext();
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _finalSubmit() async {
    if (_busy) return;
    setState(() => _busy = true);
    await finalsubmit(widget.examid, userId!);
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const navigationbar()),
      (route) => false,
    );
  }

  Widget _finishScreen({
    required IconData icon,
    required Color color,
    required String title,
    required String message,
  }) {
    return Scaffold(
      appBar: gradientAppBar('Exam', leading: const SizedBox.shrink()),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 48, color: color),
                ),
                const SizedBox(height: 24),
                Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text(message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15, color: Brand.textMuted, height: 1.4)),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _busy ? null : _finalSubmit,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Brand.accent),
                    child: _busy
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                                strokeWidth: 2.5, color: Colors.white),
                          )
                        : const Text('Final Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Asks before leaving the exam with the back arrow / back gesture.
  Future<bool> _confirmLeave() async {
    final finished = timerFinished || index >= widget.exam.length;
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Leave the exam?'),
        content: Text(finished
            ? 'You haven\'t tapped Final Submit yet. If you leave now, your exam may not be submitted.'
            : 'Your exam is in progress. If you leave now, you may not be able to restart it.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Stay'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Brand.danger),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
    return leave == true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop || _busy) return;
        final leave = await _confirmLeave();
        if (leave && mounted) Navigator.of(this.context).pop();
      },
      child: _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    if (timerFinished) {
      return _finishScreen(
        icon: Icons.timer_off_rounded,
        color: Brand.warning,
        title: 'Time\'s up!',
        message: 'Your time has ended. Tap Final Submit to save your progress.',
      );
    }
    if (index >= widget.exam.length) {
      return _finishScreen(
        icon: Icons.check_circle_rounded,
        color: Brand.accent,
        title: 'All questions answered',
        message: 'You have completed the exam. Tap Final Submit to finish.',
      );
    }

    final ques = widget.exam[index];
    final total = widget.l == 0 ? widget.exam.length : widget.l;
    final fb = _feedback[index];

    return Scaffold(
      appBar: gradientAppBar(
        'Question ${index + 1} of $total',
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: CountdownTimer(
                time: widget.time,
                onTimerFinish: handleTimerFinish,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (index + 1) / total,
            minHeight: 4,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Brand.gutter),
        children: [
          AppCard(
            padding: const EdgeInsets.all(18),
            child: Text(
              clean(ques['qns'], 'Question unavailable'),
              style: const TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w700, height: 1.45),
            ),
          ),
          const SizedBox(height: 16),
          for (final opt in _options)
            if (clean(ques['option${opt.toLowerCase()}']).isNotEmpty)
              _optionTile(opt, clean(ques['option${opt.toLowerCase()}']),
                  feedback: fb),
          if (fb != null) _feedbackCard(fb),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Brand.border)),
          ),
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          child: Row(
            children: [
              _navButton(
                label: 'Prev',
                icon: Icons.chevron_left_rounded,
                onPressed: index >= 1 && !_busy
                    ? () => setState(() {
                          index--;
                          _selectedAnswer = null;
                        })
                    : null,
              ),
              const SizedBox(width: 8),
              _navButton(
                label: 'Clear',
                icon: Icons.backspace_outlined,
                onPressed: _selectedAnswer == null || fb != null
                    ? null
                    : _handleClearButtonPressed,
              ),
              const SizedBox(width: 8),
              _navButton(
                label: 'Skip',
                icon: Icons.redo_rounded,
                onPressed:
                    _busy || fb != null ? null : () => _submitAnswer('0'),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: FilledButton(
                  onPressed: _busy
                      ? null
                      : fb != null
                          ? _goNext
                          : _selectedAnswer == null
                              ? null
                              : () => _submitAnswer(
                                  _selectedAnswer!.substring(0, 1)),
                  child: _busy
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(fb != null
                                  ? 'Continue'
                                  : widget.isMock
                                      ? 'Check'
                                      : 'Next'),
                              const SizedBox(width: 4),
                              const Icon(Icons.chevron_right_rounded),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navButton({
    required String label,
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 4),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18),
              Text(label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _feedbackCard(_MockFeedback fb) {
    final Color color;
    final IconData icon;
    final String title;
    if (fb.skipped) {
      color = Brand.warning;
      icon = Icons.redo_rounded;
      title = 'Skipped';
    } else if (fb.isCorrect == true) {
      color = Brand.accent;
      icon = Icons.check_circle_rounded;
      title = 'Correct!';
    } else if (fb.isCorrect == false) {
      color = Brand.danger;
      icon = Icons.cancel_rounded;
      title = 'Wrong answer';
    } else {
      color = Brand.primary;
      icon = Icons.info_rounded;
      title = 'Answer submitted';
    }

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Brand.radius),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(title,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800, color: color)),
            ],
          ),
          if (fb.isCorrect != true && fb.correctDisplay.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text: 'Correct answer: ',
                  style: TextStyle(color: Brand.textMuted)),
              TextSpan(
                  text: fb.correctDisplay,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, color: Brand.accent)),
            ])),
          ],
          if (fb.explanation.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(fb.explanation,
                style: const TextStyle(
                    fontSize: 13, color: Brand.textMuted, height: 1.45)),
          ],
        ],
      ),
    );
  }

  Widget _optionTile(String letter, String text, {_MockFeedback? feedback}) {
    final locked = feedback != null;
    final selected =
        locked ? feedback.yourAnswer == letter : _selectedAnswer == letter;

    // Colours: normal selection is blue; after a mock answer, the correct
    // option turns green and a wrong pick turns red.
    Color accent = Brand.primary;
    Color fill = selected ? Brand.primaryLight : Colors.white;
    bool highlight = selected;
    if (locked && feedback.correctLetter != null) {
      if (feedback.correctLetter == letter) {
        accent = Brand.accent;
        fill = Brand.accentLight;
        highlight = true;
      } else if (selected) {
        accent = Brand.danger;
        fill = Brand.dangerLight;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: fill,
        borderRadius: BorderRadius.circular(Brand.radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(Brand.radius),
          onTap: locked ? null : () => setState(() => _selectedAnswer = letter),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Brand.radius),
              border: Border.all(
                color: highlight ? accent : Brand.border,
                width: highlight ? 1.6 : 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: highlight ? accent : Brand.background,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    letter,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: highlight ? Colors.white : Brand.textMuted,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.4,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
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

/// Result of one answered question in a mock exam.
class _MockFeedback {
  _MockFeedback({
    required this.yourAnswer,
    required this.correctLetter,
    required this.correctDisplay,
    required this.isCorrect,
    required this.explanation,
  });

  final String yourAnswer; // letter sent, e.g. "B" ("0" = skipped)
  bool get skipped => yourAnswer == '0';
  final String? correctLetter; // e.g. "C", null if unknown
  final String correctDisplay; // e.g. "C. Paris"
  final bool? isCorrect; // null if the correct answer wasn't provided
  final String explanation;

  static const _letters = ['A', 'B', 'C', 'D', 'E'];

  /// True for field names that hold the correct answer, e.g. "answer", "ans",
  /// "correct_option", "currect_anwser", "right_ans". Option fields and the
  /// user's own answer are excluded.
  static bool _isAnswerKey(String key) {
    final k = key.toLowerCase();
    if (k.startsWith('option') || k.contains('your') || k.contains('user')) {
      return false;
    }
    return k.contains('ans') ||
        k.contains('correct') ||
        k.contains('currect') ||
        k.contains('right');
  }

  /// Turns an answer value into an option letter: "C", "c", "optionc",
  /// "option_c", "Option C", "3" (1-based) or the option's text.
  static String? _toLetter(String raw, String Function(String) option) {
    final v = raw.trim().toLowerCase();
    if (v.isEmpty) return null;
    final m = RegExp(r'^(?:option[\s_-]*)?([a-e])$').firstMatch(v);
    if (m != null) return m.group(1)!.toUpperCase();
    final n = int.tryParse(v);
    if (n != null && n >= 1 && n <= 5) return _letters[n - 1];
    for (final l in _letters) {
      if (option(l).isNotEmpty && option(l).toLowerCase() == v) return l;
    }
    return null;
  }

  /// Gets the correct answer from the exam_start question first, then from
  /// the next_question reply (top level or inside "data").
  factory _MockFeedback.from(Map<String, dynamic> question, String yourAnswer,
      Map<String, dynamic>? reply) {
    String option(String l) => clean(question['option${l.toLowerCase()}']);
    final sources = <Map>[
      question,
      if (reply?['data'] is Map) reply!['data'] as Map,
      if (reply != null) reply,
    ];

    String raw = '';
    String? letter;
    for (final src in sources) {
      for (final entry in src.entries) {
        if (!_isAnswerKey('${entry.key}')) continue;
        final v = clean(entry.value);
        if (v.isEmpty) continue;
        final l = _toLetter(v, option);
        if (l != null) {
          raw = v;
          letter = l;
          break;
        }
        if (raw.isEmpty) raw = v; // keep as a fallback text answer
      }
      if (letter != null) break;
    }

    String explanation = '';
    for (final src in sources) {
      explanation = clean(src['explanation']);
      if (explanation.isNotEmpty) break;
    }

    if (letter == null) {
      debugPrint('Mock exam: correct answer not recognised for question '
          '${question['id']}. Question fields: $question');
    }

    return _MockFeedback(
      yourAnswer: yourAnswer,
      correctLetter: letter,
      correctDisplay: letter != null
          ? (option(letter).isEmpty ? letter : '$letter. ${option(letter)}')
          : raw,
      isCorrect: letter != null
          ? letter == yourAnswer
          : (raw.isNotEmpty
              ? raw.toLowerCase() == option(yourAnswer).toLowerCase()
              : null),
      explanation: explanation,
    );
  }
}

class SubmitButtonAnimation extends StatefulWidget {
  const SubmitButtonAnimation({super.key});

  @override
  State<SubmitButtonAnimation> createState() => _SubmitButtonAnimationState();
}

class _SubmitButtonAnimationState extends State<SubmitButtonAnimation> {
  double _width = 150;
  double _height = 50;
  Color _color = Colors.white;

  void _animateButton() {
    setState(() {
      _width = 200;
      _height = 60;
      _color = Colors.green;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: _animateButton,
          child: const Text(
            'Final Submit',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
