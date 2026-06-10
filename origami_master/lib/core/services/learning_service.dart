import '../../data/mock/mock_data.dart';
import '../../models/learning_progress.dart';

class LearningService {
  LearningService._();
  static final LearningService instance = LearningService._();

  final List<LearningProgress> _progress = List.from(MockData.learningProgress);

  Future<LearningProgress?> getProgress(String origamiId) async {
    try {
      return _progress.firstWhere((p) => p.origamiId == origamiId);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveProgress({
    required String origamiId,
    required int currentStep,
    required int totalSteps,
    bool isCompleted = false,
  }) async {
    final index = _progress.indexWhere((p) => p.origamiId == origamiId);
    final newProgress = LearningProgress(
      origamiId: origamiId,
      currentStep: currentStep,
      totalSteps: totalSteps,
      isCompleted: isCompleted,
    );

    if (index != -1) {
      _progress[index] = newProgress;
    } else {
      _progress.add(newProgress);
    }
  }
}
