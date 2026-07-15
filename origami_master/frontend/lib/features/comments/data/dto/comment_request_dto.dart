import 'package:json_annotation/json_annotation.dart';
part 'comment_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class CommentRequestDto {
  final String content;

  CommentRequestDto({required this.content});

  Map<String, dynamic> toJson() => _$CommentRequestDtoToJson(this);
}
