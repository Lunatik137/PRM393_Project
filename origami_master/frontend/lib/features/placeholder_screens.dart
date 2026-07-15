import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  final String name;
  final Map<String, String>? parameters;

  const PlaceholderScreen({super.key, required this.name, this.parameters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is the $name Screen'),
            if (parameters != null && parameters!.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Parameters:'),
              ...parameters!.entries.map((e) => Text('${e.key}: ${e.value}')),
            ],
          ],
        ),
      ),
    );
  }
}
