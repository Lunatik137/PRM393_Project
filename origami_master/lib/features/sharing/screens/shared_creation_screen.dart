import 'package:flutter/material.dart';
import '../../../core/widgets/app_scaffold.dart';

class SharedCreationScreen extends StatelessWidget {
  const SharedCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Shared Creation',
      body: Column(
        children: [
          Container(
            height: 400,
            color: Colors.grey[300],
            child: const Center(child: Icon(Icons.photo, size: 100)),
          ),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shared by Alex',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Check out this amazing Paper Crane I made!'),
              ],
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'View-only mode',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
