import 'package:flutter/material.dart';
import '../../../app/app_routes.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/origami_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Featured Folds'),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return OrigamiCard(
                  title: 'Crane ${index + 1}',
                  difficulty: 'Easy',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.foldDetail);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Quick Actions'),
          ListTile(
            leading: const Icon(Icons.explore),
            title: const Text('Go to Explore'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.explore),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('View Profile'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
          ),
        ],
      ),
    );
  }
}
