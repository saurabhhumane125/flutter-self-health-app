import 'package:flutter/material.dart';
import 'history_screen.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  int selectedMood = -1;
  final Map<String, int> moodHistory = {};

  final List<String> moods = ['😞', '😐', '🙂', '😄', '😍'];
  final List<String> messages = [
    'Low mood. Take rest.',
    'Stable mood. Maintain routine.',
    'Good mood. Keep going!',
    'Happy mood. Stay active!',
    'Excellent mood. Amazing day!'
  ];

  void selectMood(int index) {
    setState(() {
      selectedMood = index;
      moodHistory[DateTime.now().toString().split(' ')[0]] = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF93),
        title: const Text('Daily Health Check'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'history') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HistoryScreen(moodHistory),
                  ),
                );
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'history',
                child: Text('View History'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            'How are you feeling today?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),

          /// MOOD ICONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(moods.length, (index) {
              return GestureDetector(
                onTap: () => selectMood(index),
                child: AnimatedScale(
                  scale: selectedMood == index ? 1.4 : 1.0,
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    moods[index],
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 40),

          /// MESSAGE CARD
          if (selectedMood != -1)
            AnimatedOpacity(
              opacity: 1,
              duration: const Duration(milliseconds: 400),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    messages[selectedMood],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
