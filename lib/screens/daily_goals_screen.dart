import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/goal_tile.dart';
import '../widgets/progress_card.dart';

class DailyGoal {
  final String id;
  final String title;
  final IconData icon;
  bool completed;

  DailyGoal({
    required this.id,
    required this.title,
    required this.icon,
    this.completed = false,
  });
}

class DailyGoalsScreen extends StatefulWidget {
  const DailyGoalsScreen({super.key});

  @override
  State<DailyGoalsScreen> createState() => _DailyGoalsScreenState();
}

class _DailyGoalsScreenState extends State<DailyGoalsScreen> {
  late String todayKey;
  late List<DailyGoal> goals;

  @override
  void initState() {
    super.initState();
    todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());

    goals = [
      DailyGoal(id: 'sleep', title: 'Sleep well', icon: Icons.bedtime),
      DailyGoal(
          id: 'activity',
          title: 'Physical activity',
          icon: Icons.directions_walk),
      DailyGoal(id: 'water', title: 'Hydration', icon: Icons.water_drop),
      DailyGoal(id: 'mind', title: 'Mental calm', icon: Icons.self_improvement),
      DailyGoal(
          id: 'screen', title: 'Less screen time', icon: Icons.phone_android),
    ];

    _loadGoals();
  }

  int get completedCount => goals.where((g) => g.completed).length;
  double get progress => completedCount / goals.length;

  String get insightText {
    if (completedCount == goals.length) {
      return 'Perfect day! Keep the streak alive 🔥';
    }
    if (completedCount >= 3) {
      return 'Great job! You’re on track 👍';
    }
    return 'Small steps matter. Stay consistent 🌱';
  }

  Future<void> _loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var g in goals) {
        g.completed = prefs.getBool('$todayKey-${g.id}') ?? false;
      }
    });
  }

  Future<void> _toggleGoal(DailyGoal goal) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      goal.completed = !goal.completed;
      prefs.setBool('$todayKey-${goal.id}', goal.completed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Health Goals'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ProgressCard(
            progress: progress,
            text: insightText,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: goals.length,
              itemBuilder: (context, index) {
                return GoalTile(
                  goal: goals[index],
                  onTap: () => _toggleGoal(goals[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
