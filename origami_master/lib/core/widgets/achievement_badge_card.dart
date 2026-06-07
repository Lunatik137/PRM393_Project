import 'package:flutter/material.dart';

class AchievementBadgeCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isUnlocked;
  final double progress;

  const AchievementBadgeCard({
    super.key,
    required this.title,
    required this.description,
    required this.isUnlocked,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isUnlocked ? Colors.amber : Colors.grey,
          child: Icon(
            isUnlocked ? Icons.emoji_events : Icons.lock,
            color: Colors.white,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                isUnlocked ? Colors.amber : Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
