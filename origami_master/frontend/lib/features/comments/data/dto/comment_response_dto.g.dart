// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentAuthorResponseDto _$CommentAuthorResponseDtoFromJson(
  Map<String, dynamic> json,
) => CommentAuthorResponseDto(
  id: json['id'] as String,
  username: json['username'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
);

CommentResponseDto _$CommentResponseDtoFromJson(Map<String, dynamic> json) =>
    CommentResponseDto(
      id: json['id'] as String,
      author: CommentAuthorResponseDto.fromJson(
        json['author'] as Map<String, dynamic>,
      ),
      content: json['content'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isOwner: json['isOwner'] as bool,
    );
