import '../models/origami_model.dart';
import '../models/origami_step.dart';
import '../repositories/origami_repository.dart';

class MockOrigamiRepository implements OrigamiRepository {
  final List<OrigamiModel> _models = [
    OrigamiModel(
      id: '1',
      title: 'Crane',
      category: 'Birds',
      difficulty: 'Easy',
      durationMinutes: 5,
      xpReward: 50,
      imagePath: 'assets/images/crane.png',
    ),
    OrigamiModel(
      id: '2',
      title: 'Dragon',
      category: 'Fantasy',
      difficulty: 'Hard',
      durationMinutes: 30,
      xpReward: 200,
      imagePath: 'assets/images/dragon.png',
    ),
  ];

  @override
  Future<List<OrigamiModel>> getOrigamiModels() async {
    return _models;
  }

  @override
  Future<OrigamiModel?> getOrigamiModelById(String id) async {
    return _models.firstWhere((m) => m.id == id);
  }

  @override
  Future<List<OrigamiStep>> getStepsByOrigamiId(String origamiId) async {
    return [
      OrigamiStep(
        id: 's1',
        origamiId: origamiId,
        stepNumber: 1,
        title: 'Fold in half',
        description: 'Fold the paper diagonally.',
        imagePath: 'assets/images/step1.png',
      ),
    ];
  }
}
