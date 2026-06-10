import 'package:flutter/foundation.dart';
import 'origami_step.dart';

@immutable
class OrigamiModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String difficulty;
  final int estimatedMinutes;
  final String imagePath;
  final List<String> materials;
  final List<OrigamiStep> steps;

  const OrigamiModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.estimatedMinutes,
    required this.imagePath,
    required this.materials,
    required this.steps,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrigamiModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          category == other.category &&
          difficulty == other.difficulty &&
          estimatedMinutes == other.estimatedMinutes &&
          imagePath == other.imagePath &&
          listEquals(materials, other.materials) &&
          listEquals(steps, other.steps);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      category.hashCode ^
      difficulty.hashCode ^
      estimatedMinutes.hashCode ^
      imagePath.hashCode ^
      materials.hashCode ^
      steps.hashCode;
}
