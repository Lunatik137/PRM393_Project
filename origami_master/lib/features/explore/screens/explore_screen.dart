import 'package:flutter/material.dart';
import '../../../app/app_routes.dart';
import '../../../core/widgets/origami_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Search models...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return OrigamiCard(
                  title: 'Origami $index',
                  difficulty: index % 2 == 0 ? 'Easy' : 'Medium',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.foldDetail);
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
