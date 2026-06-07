import 'package:flutter/material.dart';
import '../../../app/app_routes.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../../../core/widgets/section_header.dart';

class FoldDetailScreen extends StatelessWidget {
  const FoldDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Fold Detail',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              color: Colors.grey[300],
              child: const Center(child: Icon(Icons.image, size: 100)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Paper Crane',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Text('Difficulty: Easy • 5 mins'),
                  const SizedBox(height: 16),
                  const Text(
                    'The crane is the most classic of all origami. It represents long life and good fortune.',
                  ),
                  const SizedBox(height: 24),
                  const SectionHeader(title: 'Community Gallery'),
                  const Text('See what others have created:'),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 8),
                          color: Colors.grey[200],
                          child: const Icon(Icons.photo_library),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  AppPrimaryButton(
                    text: 'Start Folding',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.learningStep);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
