import 'package:flutter/material.dart';

import 'package:pomodoro_app/core/theme/app_colors.dart';
import 'package:pomodoro_app/features/pomodoro/widgets/time_ring.dart';
import 'package:pomodoro_app/features/pomodoro/widgets/timer_button.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Focus')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimeRing(progress: 0.0, time: "25:00"),
            SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimerButton(
                  width: 130,
                  color: AppColors.neutralButton,
                  icon: Icons.play_arrow_rounded,
                  onTap: () {},
                ),
                SizedBox(width: 12),
                TimerButton(
                  width: 90,
                  color: AppColors.mint,
                  icon: Icons.refresh_rounded,
                  onTap: () {},
                ),
                SizedBox(width: 12),
                TimerButton(
                  width: 66,
                  color: AppColors.mint,
                  icon: Icons.skip_next_rounded,
                  onTap: () {},
                ),
              ],
            ),

            Row()
          ],
        ),
      ),
    );
  }
}
