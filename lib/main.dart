import 'package:flutter/material.dart';
import 'screens/daily_goals_screen.dart';

void main() {
  runApp(const SelfHealthApp());
}

class SelfHealthApp extends StatelessWidget {
  const SelfHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Self Health',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF4CAF93),
        scaffoldBackgroundColor: const Color(0xFFF4FBF8),
      ),
      home: const DailyGoalsScreen(),
    );
  }
}
