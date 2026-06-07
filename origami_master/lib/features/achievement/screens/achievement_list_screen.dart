import 'package:flutter/material.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/achievement_badge_card.dart';

class AchievementListScreen extends StatelessWidget {
  const AchievementListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Achievements',
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 8,
        itemBuilder: (context, index) {
          return AchievementBadgeCard(
            title: 'Achievement $index',
            description: 'Description for achievement $index',
            isUnlocked: index < 3,
            progress: index < 3 ? 1.0 : 0.4,
          );
        },
      ),
    );
  }
}
