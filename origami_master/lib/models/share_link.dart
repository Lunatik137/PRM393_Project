import 'package:flutter/foundation.dart';

@immutable
class ShareLink {
  final String id;
  final String creationId;
  final String token;
  final String url;
  final DateTime createdAt;
  final bool isActive;

  const ShareLink({
    required this.id,
    required this.creationId,
    required this.token,
    required this.url,
    required this.createdAt,
    this.isActive = true,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShareLink &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          creationId == other.creationId &&
          token == other.token &&
          url == other.url &&
          createdAt == other.createdAt &&
          isActive == other.isActive;

  @override
  int get hashCode =>
      id.hashCode ^
      creationId.hashCode ^
      token.hashCode ^
      url.hashCode ^
      createdAt.hashCode ^
      isActive.hashCode;
}
