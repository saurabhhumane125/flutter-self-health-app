import 'package:flutter/material.dart';
import '../screens/daily_goals_screen.dart';

class GoalTile extends StatelessWidget {
  final DailyGoal goal;
  final VoidCallback onTap;

  const GoalTile({
    super.key,
    required this.goal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: goal.completed ? const Color(0xFFDFF6EE) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: goal.completed
                  ? const Color(0xFF4CAF93)
                  : Colors.grey.shade300,
            ),
          ),
          child: Row(
            children: [
              Icon(
                goal.icon,
                color: goal.completed ? const Color(0xFF4CAF93) : Colors.grey,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  goal.title,
                  style: TextStyle(
                    fontSize: 16,
                    decoration:
                        goal.completed ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: goal.completed
                    ? const Icon(Icons.check_circle,
                        color: Color(0xFF4CAF93), key: ValueKey(true))
                    : const Icon(Icons.circle_outlined, key: ValueKey(false)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
