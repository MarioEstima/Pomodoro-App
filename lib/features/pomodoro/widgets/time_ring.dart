import "package:flutter/material.dart";
import "package:pomodoro_app/core/theme/app_colors.dart";
import 'package:google_fonts/google_fonts.dart';

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
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 400),
              builder: (context, value, _) => CircularProgressIndicator(
                value: value,
                strokeWidth: 10,
                strokeCap: StrokeCap.round,
                color: AppColors.primary,
                backgroundColor: AppColors.mint,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final char in time.split('')) _RollingChar(char: char),
            ],
          ),
        ],
      ),
    );
  }
}

class _RollingChar extends StatelessWidget {
  final String char;

  const _RollingChar({required this.char});

  @override
  Widget build(BuildContext context) {
    final isColon = char == ':';
    final currentKey = ValueKey(char);

    final text = Text(
      char,
      key: currentKey,
      style: GoogleFonts.figtree(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 70,
      ),
    );

    if (isColon) {
      return SizedBox(width: 24, child: Center(child: text));
    }

    return ClipRect(
      child: SizedBox(
        width: 42,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) {
            final isIncoming = child.key == currentKey;
            final offset = Tween<Offset>(
              begin: isIncoming ? const Offset(0, -1) : const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation);

            return SlideTransition(
              position: offset,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: Center(key: currentKey, child: text),
        ),
      ),
    );
  }
}
