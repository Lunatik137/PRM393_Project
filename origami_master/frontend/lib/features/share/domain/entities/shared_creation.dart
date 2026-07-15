import 'package:equatable/equatable.dart';

class SharedCreation extends Equatable {
  final String imageUrl;
  final String origamiModelName;
  final String creatorUsername;
  final DateTime completionDate;
  final String visibility;
  final String? description;

  const SharedCreation({
    required this.imageUrl,
    required this.origamiModelName,
    required this.creatorUsername,
    required this.completionDate,
    required this.visibility,
    this.description,
  });

  @override
  List<Object?> get props => [
        imageUrl,
        origamiModelName,
        creatorUsername,
        completionDate,
        visibility,
        description,
      ];
}
