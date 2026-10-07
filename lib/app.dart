import 'package:flutter/material.dart';
import 'package:pomodoro_app/core/theme/app_theme.dart';
import 'package:pomodoro_app/features/pomodoro/pomodoro_screen.dart';

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(), 
      home: const PomodoroScreen(),
    );
  }
}
