import 'package:flutter/material.dart';
import '../../../app/app_routes.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_primary_button.dart';

class CreationDetailScreen extends StatelessWidget {
  const CreationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Creation Detail',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              color: Colors.grey[300],
              child: const Center(child: Icon(Icons.photo, size: 100)),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Awesome Crane',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Text('Completed on October 12, 2023'),
                  const SizedBox(height: 16),
                  const Text(
                    'This was my first attempt at a crane. It took some time but I am proud of the result!',
                  ),
                  const SizedBox(height: 32),
                  AppPrimaryButton(
                    text: 'Share This Creation',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.generateShareLink);
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
