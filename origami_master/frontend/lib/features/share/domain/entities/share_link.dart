import 'package:equatable/equatable.dart';

class ShareLink extends Equatable {
  final String id;
  final String creationId;
  final String creationName;
  final String shareUrl;
  final String token;
  final DateTime createdAt;
  final bool isActive;

  const ShareLink({
    required this.id,
    required this.creationId,
    required this.creationName,
    required this.shareUrl,
    required this.token,
    required this.createdAt,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        id,
        creationId,
        creationName,
        shareUrl,
        token,
        createdAt,
        isActive,
      ];
}
