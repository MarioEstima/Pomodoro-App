import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pomodoro_app/core/theme/app_colors.dart';
import 'package:pomodoro_app/features/pomodoro/widgets/time_ring.dart';
import 'package:pomodoro_app/features/pomodoro/widgets/timer_button.dart';

enum SessionType { focus, shortBreak }

extension SessionTypeX on SessionType {
  int get seconds => this == SessionType.focus ? 25 * 60 : 5 * 60;
  String get label => this == SessionType.focus ? "Focus" : "Short Break";
  SessionType get next =>
      this == SessionType.focus ? SessionType.shortBreak : SessionType.focus;
}

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  SessionType _session = SessionType.focus;
  late int _remaining = _session.seconds;
  bool _running = false;
  Timer? _timer;

  double get _progress => 1 - (_remaining / _session.seconds);

  String _format(int s, {bool padMinutes = true}) {
    final m = (s ~/ 60).toString();
    final sec = (s % 60).toString().padLeft(2, '0');
    return "${padMinutes ? m.padLeft(2, '0') : m}:$sec";
  }

  void _toggle() => _running ? _pause() : _start();

  void _start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remaining <= 1) {
        _skip(autoStart: true);
      } else {
        setState(() => _remaining--);
      }
    });
    setState(() => _running = true);
  }

  void _pause() {
    _timer?.cancel();
    setState(() => _running = false);
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _running = false;
      _remaining = _session.seconds;
    });
  }

  void _skip({bool autoStart = false}) {
    _timer?.cancel();
    setState(() {
      _session = _session.next;
      _remaining = _session.seconds;
      _running = false;
    });
    if (autoStart) _start();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_session.label)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimeRing(progress: _progress, time: _format(_remaining)),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimerButton(
                  width: 150,
                  color: AppColors.neutralButton,
                  icon: _running
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  onTap: _toggle,
                ),
                const SizedBox(width: 12),
                TimerButton(
                  width: 90,
                  color: AppColors.mint,
                  icon: Icons.refresh_rounded,
                  onTap: _reset,
                ),
                const SizedBox(width: 12),
                TimerButton(
                  width: 66,
                  color: AppColors.mint,
                  icon: Icons.skip_next_rounded,
                  onTap: () => _skip(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Text(
                  "Up next",
                  style: GoogleFonts.figtree(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  _format(_session.next.seconds, padMinutes: false),
                  style: GoogleFonts.figtree(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  _session.next.label,
                  style: GoogleFonts.figtree(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
