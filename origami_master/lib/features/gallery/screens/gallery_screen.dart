import 'package:flutter/material.dart';
import '../../../app/app_routes.dart';
import '../../../core/widgets/creation_card.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Creations',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return CreationCard(
                  title: 'My Crane $index',
                  date: 'Oct ${index + 1}, 2023',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.creationDetail);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
