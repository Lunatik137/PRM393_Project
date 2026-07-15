import 'package:flutter/foundation.dart';
import '../core/utils/image_url_resolver.dart';

@immutable
class OrigamiStep {
  final String id;
  final String origamiId;
  final int stepNumber;
  final String title;
  final String description;
  final String imagePath;
  final String? proTip;

  const OrigamiStep({
    required this.id,
    required this.origamiId,
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.imagePath,
    this.proTip,
  });

  factory OrigamiStep.fromJson(Map<String, dynamic> json) {
    return OrigamiStep(
      id: json['id']?.toString() ?? '',
      origamiId: json['origamiId']?.toString() ?? '',
      stepNumber: json['stepNumber'] as int? ?? 0,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      imagePath: resolveImageUrl(json['imageUrl']?.toString()),
      proTip: json['proTip']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'origamiId': origamiId,
      'stepNumber': stepNumber,
      'title': title,
      'description': description,
      'imageUrl': imagePath,
      'proTip': proTip,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrigamiStep &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          origamiId == other.origamiId &&
          stepNumber == other.stepNumber &&
          title == other.title &&
          description == other.description &&
          imagePath == other.imagePath &&
          proTip == other.proTip;

  @override
  int get hashCode =>
      id.hashCode ^
      origamiId.hashCode ^
      stepNumber.hashCode ^
      title.hashCode ^
      description.hashCode ^
      imagePath.hashCode ^
      proTip.hashCode;
}
