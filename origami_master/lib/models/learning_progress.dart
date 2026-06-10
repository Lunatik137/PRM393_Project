import 'package:flutter/foundation.dart';

@immutable
class LearningProgress {
  final String origamiId;
  final int currentStep;
  final int totalSteps;
  final bool isCompleted;

  const LearningProgress({
    required this.origamiId,
    required this.currentStep,
    required this.totalSteps,
    required this.isCompleted,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LearningProgress &&
          runtimeType == other.runtimeType &&
          origamiId == other.origamiId &&
          currentStep == other.currentStep &&
          totalSteps == other.totalSteps &&
          isCompleted == other.isCompleted;

  @override
  int get hashCode =>
      origamiId.hashCode ^
      currentStep.hashCode ^
      totalSteps.hashCode ^
      isCompleted.hashCode;
}
