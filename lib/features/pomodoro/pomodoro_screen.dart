import 'package:flutter/material.dart';

import 'package:pomodoro_app/core/theme/app_colors.dart';
import 'package:pomodoro_app/features/pomodoro/widgets/time_ring.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Focus')),
      body: Center(child: SizedBox(child: TimeRing(progress: 10.0, time: "25:10"))),
    );
  }
}
