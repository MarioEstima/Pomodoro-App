import 'package:flutter/material.dart';
import 'package:pomodoro_app/core/theme/app_colors.dart';

class TimerButton extends StatelessWidget {
  final double width;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  TimerButton({
    super.key,
    required this.width,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: SizedBox(
          width: width,
          height: 90,
          child: Icon(icon, color: AppColors.icon, size: 30, ),
        ),
      ),
    );
  }
}
