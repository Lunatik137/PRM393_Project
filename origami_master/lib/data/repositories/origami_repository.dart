import '../models/origami_model.dart';
import '../models/origami_step.dart';

abstract class OrigamiRepository {
  Future<List<OrigamiModel>> getOrigamiModels();
  Future<OrigamiModel?> getOrigamiModelById(String id);
  Future<List<OrigamiStep>> getStepsByOrigamiId(String origamiId);
}
