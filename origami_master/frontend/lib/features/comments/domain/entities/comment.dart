import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String id;
  final String postId;
  final String authorId;
  final String authorName;
  final String? authorAvatar;
  final String content;
  final DateTime createdAt;
  final bool isOwner;

  const Comment({
    required this.id,
    required this.postId,
    required this.authorId,
    required this.authorName,
    this.authorAvatar,
    required this.content,
    required this.createdAt,
    required this.isOwner,
  });

  @override
  List<Object?> get props => [
        id,
        postId,
        authorId,
        authorName,
        authorAvatar,
        content,
        createdAt,
        isOwner,
      ];
}
