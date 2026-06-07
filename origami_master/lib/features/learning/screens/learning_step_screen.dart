import 'package:flutter/material.dart';
import '../../../app/app_routes.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_primary_button.dart';

class LearningStepScreen extends StatefulWidget {
  const LearningStepScreen({super.key});

  @override
  State<LearningStepScreen> createState() => _LearningStepScreenState();
}

class _LearningStepScreenState extends State<LearningStepScreen> {
  int currentStep = 1;
  final int totalSteps = 10;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Step $currentStep of $totalSteps',
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.architecture, size: 100),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Fold the paper in half diagonally to form a triangle.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                if (currentStep > 1)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => currentStep--),
                      child: const Text('Back'),
                    ),
                  ),
                if (currentStep > 1) const SizedBox(width: 16),
                Expanded(
                  child: AppPrimaryButton(
                    text: currentStep < totalSteps ? 'Next' : 'Finish',
                    onPressed: () {
                      if (currentStep < totalSteps) {
                        setState(() => currentStep++);
                      } else {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.completionResult,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
