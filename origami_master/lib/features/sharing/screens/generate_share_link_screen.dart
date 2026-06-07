import 'package:flutter/material.dart';
import '../../../app/app_routes.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_primary_button.dart';

class GenerateShareLinkScreen extends StatelessWidget {
  const GenerateShareLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Generate Share Link',
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.link, size: 80, color: Colors.blue),
            const SizedBox(height: 24),
            const Text(
              'Create a Private Link',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Anyone with this link will be able to view your creation even if they don\'t have the app.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            AppPrimaryButton(
              text: 'Generate Link',
              onPressed: () {
                // Mock link generation
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Link Generated'),
                    content: const Text(
                      'https://origamimaster.app/share/abc-123',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, AppRoutes.sharedLinks);
                        },
                        child: const Text('View All Links'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
