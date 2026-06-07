import 'package:flutter/material.dart';
import '../../../app/app_routes.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../../../core/widgets/app_secondary_button.dart';

class CompletionResultScreen extends StatelessWidget {
  const CompletionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.emoji_events, size: 100, color: Colors.amber),
            const SizedBox(height: 24),
            const Text(
              'Amazing Job!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Text(
              'You have completed the Paper Crane.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      '+50 XP',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text('New Achievement: First Fold!'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
            AppPrimaryButton(
              text: 'Share Creation',
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.generateShareLink);
              },
            ),
            const SizedBox(height: 12),
            AppSecondaryButton(
              text: 'Back to Home',
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
            ),
          ],
        ),
      ),
    );
  }
}
