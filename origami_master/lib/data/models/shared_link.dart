class SharedLink {
  final String id;
  final String creationId;
  final String token;
  final String url;
  final DateTime createdAt;
  final bool isActive;

  SharedLink({
    required this.id,
    required this.creationId,
    required this.token,
    required this.url,
    required this.createdAt,
    required this.isActive,
  });
}
