import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../core/utils/image_url_resolver.dart';
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

  static String _parseDifficulty(dynamic diff) {
    final val = diff?.toString();
    switch (val) {
      case '1': return 'Beginner';
      case '2': return 'Intermediate';
      case '3': return 'Advanced';
      case '4': return 'Expert';
      default: return 'Beginner';
    }
  }

  static List<String> _parseMaterials(dynamic raw) {
    if (raw == null) return [];
    if (raw is List) {
      return raw.map((e) => e.toString()).toList();
    }
    if (raw is String) {
      if (raw.isEmpty) return [];
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          return decoded.map((e) => e.toString()).toList();
        }
        return [raw];
      } catch (_) {
        return [raw];
      }
    }
    return [];
  }

  factory OrigamiModel.fromJson(Map<String, dynamic> json) {
    return OrigamiModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      category: json['category']?['name']?.toString() ?? '',
      difficulty: _parseDifficulty(json['difficulty']),
      estimatedMinutes: json['estimatedMinutes'] as int? ?? 0,
      imagePath: resolveImageUrl(json['thumbnailUrl']?.toString() ?? json['coverImageUrl']?.toString()),
      materials: _parseMaterials(json['materials']),
      steps: (json['steps'] as List<dynamic>?)
              ?.map((e) => OrigamiStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

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
