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
  final String? localImagePath;

  const Comment({
    required this.id,
    required this.postId,
    required this.authorId,
    required this.authorName,
    this.authorAvatar,
    required this.content,
    required this.createdAt,
    required this.isOwner,
    this.localImagePath,
  });

  Comment copyWith({
    String? id,
    String? postId,
    String? authorId,
    String? authorName,
    String? authorAvatar,
    String? content,
    DateTime? createdAt,
    bool? isOwner,
    String? localImagePath,
  }) {
    return Comment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      isOwner: isOwner ?? this.isOwner,
      localImagePath: localImagePath ?? this.localImagePath,
    );
  }

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
        localImagePath,
      ];
}
