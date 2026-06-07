import 'package:flutter/material.dart';

class ProgressRing extends StatelessWidget {
  final double value;
  final String label;
  final String subLabel;

  const ProgressRing({
    super.key,
    required this.value,
    required this.label,
    required this.subLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: 8,
                backgroundColor: Colors.grey[200],
              ),
            ),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        Text(subLabel, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
