import "package:flutter/material.dart";
import "package:pomodoro_app/core/theme/app_colors.dart";

class TimeRing extends StatelessWidget {
  final double progress;
  final String time;

  const TimeRing({super.key, required this.progress, required this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 10,
              strokeCap: StrokeCap.round,
              color: AppColors.primary,
              backgroundColor: AppColors.mint,
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 76,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
