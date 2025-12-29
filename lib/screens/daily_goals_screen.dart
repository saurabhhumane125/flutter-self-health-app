import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late List<DailyGoal> goals;
  late String todayKey;

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
    if (progress == 0) return "Let’s start fresh 🌱";
    if (progress < 0.5) return "Good effort, keep going 🙂";
    if (progress < 1) return "Great self-care today 💪";
    return "Perfect day! 🌟";
  }

  Future<void> _loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    for (var goal in goals) {
      goal.completed = prefs.getBool('${goal.id}_$todayKey') ?? false;
    }
    setState(() {});
  }

  Future<void> _toggleGoal(DailyGoal goal) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      goal.completed = !goal.completed;
    });
    await prefs.setBool('${goal.id}_$todayKey', goal.completed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F8),
      appBar: AppBar(
        title: const Text('Daily Goals'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _ProgressCard(
              progress: progress,
              completed: completedCount,
              total: goals.length,
              insight: insightText,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: goals.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  return _GoalTile(
                    goal: goal,
                    onTap: () => _toggleGoal(goal),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
