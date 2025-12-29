import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  final Map<String, int> moodHistory;

  const HistoryScreen(this.moodHistory, {super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<String> moodIcons = ['😞', '😐', '🙂', '😄', '😍'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood History'),
      ),
      body: widget.moodHistory.isEmpty
          ? const Center(child: Text('No records yet'))
          : ListView(
              children: widget.moodHistory.entries.map((entry) {
                return Dismissible(
                  key: Key(entry.key),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    setState(() {
                      widget.moodHistory.remove(entry.key);
                    });
                  },
                  child: ListTile(
                    leading: Text(
                      moodIcons[entry.value],
                      style: const TextStyle(fontSize: 28),
                    ),
                    title: Text(entry.key),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        setState(() {
                          widget.moodHistory[entry.key] = (entry.value + 1) % 5;
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
