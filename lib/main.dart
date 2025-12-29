import 'package:flutter/material.dart';
import 'screens/mood_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Self Health Recorder',
      theme: ThemeData(
        primaryColor: const Color(0xFF4CAF93),
        scaffoldBackgroundColor: const Color(0xFFF5FBF8),
        useMaterial3: true,
      ),
      home: const MoodScreen(),
    );
  }
}
