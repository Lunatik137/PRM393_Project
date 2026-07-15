import 'package:json_annotation/json_annotation.dart';
part 'comment_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class CommentAuthorResponseDto {
  final String id;
  final String? username;
  final String? avatarUrl;

  CommentAuthorResponseDto({
    required this.id,
    this.username,
    this.avatarUrl,
  });

  factory CommentAuthorResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CommentAuthorResponseDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class CommentResponseDto {
  final String id;
  final CommentAuthorResponseDto author;
  final String? content;
  final DateTime createdAt;
  final bool isOwner;

  // postId is not returned by backend, default to empty
  String get postId => '';
  String get authorId => author.id;
  String? get authorName => author.username;
  String? get authorAvatar => author.avatarUrl;

  CommentResponseDto({
    required this.id,
    required this.author,
    this.content,
    required this.createdAt,
    required this.isOwner,
  });

  factory CommentResponseDto.fromJson(Map<String, dynamic> json) => _$CommentResponseDtoFromJson(json);
}
